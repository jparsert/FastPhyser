//
// Created by julian on 22.02.23.
//

#ifndef FASTPHYSER_PARALLELLEARNINGMANAGER_H
#define FASTPHYSER_PARALLELLEARNINGMANAGER_H



#include <chrono>
#include "search/search.h"
#include "Features.h"
#include <memory>
#include <vector>
#include "guidance/Policy.h"
#include "guidance/Value.h"
#include <optional>
#include <iostream>
#include <mutex>

#include <boost/program_options.hpp>
#include "AstPrinter.h"
#include "statistics.h"
#include "DataCollector.h"

#include <oneapi/tbb/info.h>
#include <oneapi/tbb/parallel_for.h>
#include <oneapi/tbb/task_arena.h>
#include <oneapi/tbb/global_control.h>
#include <oneapi/tbb/concurrent_vector.h>

namespace po = boost::program_options;


/**
 * Could use SFINAE but let's just do ducktyping for now
 * @tparam Search
 */
template<class Search>
class ParallelLearningManager {

    PolicyFunction* policy;
    ValueFunction* value;

    DataCollector* policy_data_collector;
    DataCollector* value_data_collector;

    int RL_Iterations = 20;
    int parallel_cores;

    // keep order
    std::chrono::seconds search_timeout;
    experiment_statistics experim_stats;

    po::variables_map argument_map;

public:
    explicit ParallelLearningManager(PolicyFunction* pol,
                                     ValueFunction* val,
                                     DataCollector* pol_data_col,
                                     DataCollector* val_data_col,
                                     po::variables_map& vm):
            policy{pol},
            value{val},
            policy_data_collector{pol_data_col},
            value_data_collector{val_data_col},
            search_timeout(vm["timeout"].as<int>()),
            experim_stats(Search::get_feature_generator_name(), pol, val, search_timeout,
                          Search::get_search_name(),
                          vm.count("seed") ? std::to_string(vm["seed"].as<int>()) : "",
                          vm["num-parallel"].as<int>(),
                          pol_data_col->get_name(),
                          val_data_col->get_name()),
            parallel_cores{vm["num-parallel"].as<int>()},
            argument_map(vm)
    {
        if (vm.contains("RL-its")) {
            RL_Iterations = vm["RL-its"].as<int>();
        }

    }

public:

    /**
     * Should probably return some statistics
     */
    experiment_statistics start(std::vector<std::string>& train_set, std::vector<std::string>& test_set);

};


template<class Search>
experiment_statistics ParallelLearningManager<Search>::start(std::vector<std::string>& train_set, std::vector<std::string>& test_set) {

    experim_stats.problems = train_set;
    experim_stats.testing_set = test_set;



    for (int iteration = 0; iteration < RL_Iterations; ++iteration) {

        // collect data
        tbb::concurrent_vector<std::pair<std::vector<float>,float>> policy_data;
        tbb::concurrent_vector<std::pair<std::vector<float>,float>> value_data;

        // RUN on training set
        experiment_iteration& it_stat = experim_stats.iterations.emplace_back();
        tbb::concurrent_vector<stat_problem>& successful = it_stat.succeeded;
        tbb::concurrent_vector<stat_problem>& failed = it_stat.failed;
        tbb::concurrent_vector<stat_problem>& timed_out = it_stat.timed_out;

        // look at all train_set to gather statistics and training data
        it_stat.policy_data_size = policy_data_collector->get_size();
        it_stat.value_data_size = value_data_collector->get_size();


        auto run_training = [&](int i){
            Search search(train_set[i], policy, value, search_timeout, argument_map, iteration=iteration);

            // get timing
            auto start_time = std::chrono::steady_clock::now();
            search.start_search();
            std::chrono::seconds search_time = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now()-start_time);

            //add training data
            // policy training data
            if (search.get_solution()) {  // policy only in successful runs
                for (auto &pair: search.get_policy_data()) {
                    policy_data.emplace_back(pair);
                }
            }
            // value training data;
            for (auto& pair : search.get_value_data()) {
                value_data.emplace_back(pair);
            }

            // add statistics
            stat_problem stat_p{search.get_problem(), search.get_graph_size(), search_time};
            if (search.get_solution()) { // successful search
                successful.emplace_back(stat_p);
            } else {
                if (search.search_timed_out()) {
                    timed_out.emplace_back(stat_p);
                } else {
                    failed.emplace_back(stat_p);
                }
            }

            // print output
            ftxui_print_searcher_status(experim_stats, "TRAINING Iteration " + std::to_string(std::min(iteration+1, RL_Iterations)) + "/" + std::to_string(RL_Iterations), successful.size(), failed.size(), timed_out.size(), experim_stats.problems.size());
        };

        // start TRAINING RUN with timing
        oneapi::tbb::task_arena train_arena(parallel_cores == 0 ? std::thread::hardware_concurrency() : parallel_cores);
        auto t1 = std::chrono::steady_clock::now();
        train_arena.execute([&](){oneapi::tbb::parallel_for(size_t(0), train_set.size() , size_t(1), run_training);}
        );
        auto time = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - t1);
        it_stat.iteration_time_training = time;

        // Run Testing SET:
        tbb::concurrent_vector<stat_problem>& successful_test = it_stat.test_succeeded;
        tbb::concurrent_vector<stat_problem>& failed_test = it_stat.test_failed;
        tbb::concurrent_vector<stat_problem>& timed_out_test = it_stat.test_timed_out;

        auto run_test = [&](int i){
                Search search(test_set[i], policy, value, search_timeout, argument_map, iteration);

                // get timing
                auto start_time = std::chrono::steady_clock::now();
                search.start_search();
                std::chrono::seconds search_time = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now()-start_time);

                // add statistics
                stat_problem stat_p{search.get_problem(), search.get_graph_size(), search_time};
                if (search.get_solution()) { // successful search
                    successful_test.emplace_back(stat_p);
                    //std::vector<Sy2CPP::DefineFunCmd> sol = search.get_solution().value();
                    //std::cout << Sy2CPP::AstToString::to_string(sol[0]) << std::endl;
                } else {
                    if (search.search_timed_out()) {
                        timed_out_test.emplace_back(stat_p);
                    } else {
                        failed_test.emplace_back(stat_p);
                    }
                }
                ftxui_print_searcher_status(experim_stats, "TESTING Iteration " + std::to_string(std::min(iteration+1, RL_Iterations)) + "/" + std::to_string(RL_Iterations), successful_test.size(), failed_test.size(), timed_out_test.size(), experim_stats.testing_set.size());
            };

        // start TESTING RUN with timing
        oneapi::tbb::task_arena test_arena(parallel_cores == 0 ? std::thread::hardware_concurrency() : parallel_cores);

        auto t1_test = std::chrono::steady_clock::now();
        test_arena.execute([&](){oneapi::tbb::parallel_for(size_t(0), test_set.size(), size_t(1), run_test);}
        );
        auto time_test = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - t1_test);
        it_stat.iteration_time_test = time_test;

        // add new training data and train if we have iterations left
        if (iteration < this->RL_Iterations - 1) {
            policy_data_collector->add_iteration_data(policy_data);
            value_data_collector->add_iteration_data(value_data);

            if (policy) {
                policy->train(policy_data_collector->get_all_data(), argument_map, iteration);
                if (argument_map.count("save-models")) {
                    std::filesystem::path fld(argument_map["save-models"].as<std::string>());
                    auto res = fld/("policy_it_" + std::to_string(iteration) + get_current_timestamp_as_string() + ".model");
                    policy->save_model(res.string());
                }
            }

            if (value) {
                value->train(value_data_collector->get_all_data(), argument_map, iteration);
                if (argument_map.count("save-models")) {
                    std::filesystem::path fld(argument_map["save-models"].as<std::string>());
                    auto res = fld/("value_it_" + std::to_string(iteration) + get_current_timestamp_as_string() + ".model");
                    value->save_model(res.string());
                }
            }
        }
        experim_stats.print_to_file("tmp_results.json");
        //ftxui_print_searcher_status(experim_stats, "" + std::to_string(std::min(iteration+1, RL_Iterations)) + "/" + std::to_string(RL_Iterations), successful_test.size(), failed_test.size(), timed_out_test.size());
    }

    return this->experim_stats;

}

#endif //FASTPHYSER_PARALLELLEARNINGMANAGER_H
