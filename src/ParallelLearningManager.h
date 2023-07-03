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
#include <oneapi/tbb/concurrent_vector.h>
#include <boost/program_options.hpp>
#include "AstPrinter.h"
#include "statistics.h"
#include "DataCollector.h"

#include <taskflow/taskflow.hpp>


namespace po = boost::program_options;


/**
 * Could use SFINAE but let's just do ducktyping for now
 * @tparam Search
 */
template<class Search, class FeatureGenerator>
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
            experim_stats(FeatureGenerator::get_class_name(), pol, val, search_timeout, Search::get_search_name(), vm.count("seed") ? std::to_string(vm["seed"].as<int>()) : ""),
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


template<class Search, class AbstractFeatureGenerator>
experiment_statistics ParallelLearningManager<Search, AbstractFeatureGenerator>::start(std::vector<std::string>& train_set, std::vector<std::string>& test_set) {

    experim_stats.problems = train_set;
    experim_stats.testing_set = test_set;




    for (int iteration = 0; iteration < RL_Iterations; ++iteration) {

        // collect data
        tbb::concurrent_vector<std::pair<std::vector<float>,float>> policy_data;
        tbb::concurrent_vector<std::pair<std::vector<float>,float>> value_data;

        // RUN on training set
        tbb::concurrent_vector<stat_problem> successful;
        tbb::concurrent_vector<stat_problem> failed;
        tbb::concurrent_vector<stat_problem> timed_out;
        tf::Executor executor( parallel_cores == 0 ? std::thread::hardware_concurrency() : parallel_cores);
        tf::Taskflow taskflow;
        for (int i = 0; i < train_set.size(); ++i) {
            taskflow.emplace([&](){
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
                ftxui_print_searcher_status(experim_stats, "Training Iteration " + std::to_string(std::min(iteration+1, RL_Iterations)) + "/" + std::to_string(RL_Iterations), successful.size(), failed.size(), timed_out.size());
            });

        }

        // start TRAINING RUN with timing
        auto t1 = std::chrono::steady_clock::now();
        executor.run(taskflow).wait();
        auto time = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - t1);


        // Run Testing SET:
        tbb::concurrent_vector<stat_problem> successful_test;
        tbb::concurrent_vector<stat_problem> failed_test;
        tbb::concurrent_vector<stat_problem> timed_out_test;
        tf::Executor executor_test( parallel_cores == 0 ? std::thread::hardware_concurrency() : parallel_cores);
        tf::Taskflow taskflow_test;
        for (int i = 0; i < test_set.size(); ++i) {
            taskflow_test.emplace([&](){
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
                ftxui_print_searcher_status(experim_stats, "Training Iteration " + std::to_string(std::min(iteration+1, RL_Iterations)) + "/" + std::to_string(RL_Iterations), successful_test.size(), failed_test.size(), timed_out_test.size());
            });
        }
        // start TESTING RUN with timing
        executor.run(taskflow_test).wait();

        // look at all train_set to gather statistics and training data
        experiment_iteration& it_stat = experim_stats.iterations.emplace_back();
        it_stat.iteration_time = time;
        it_stat.policy_data_size = policy_data_collector->get_size();
        it_stat.value_data_size = value_data_collector->get_size();

        // learning stats
        it_stat.succeeded = std::vector<stat_problem>(successful.begin(), successful.end());
        it_stat.failed = std::vector<stat_problem>(failed.begin(), failed.end());
        it_stat.timed_out = std::vector<stat_problem>(timed_out.begin(), timed_out.end());

        // testing stats
        it_stat.test_succeeded = std::vector<stat_problem>(successful_test.begin(), successful_test.end());
        it_stat.test_failed = std::vector<stat_problem>(failed_test.begin(), failed_test.end());
        it_stat.test_timed_out = std::vector<stat_problem>(timed_out_test.begin(), timed_out_test.end());

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
        ftxui_print_searcher_status(experim_stats, "Training Iteration " + std::to_string(std::min(iteration+1, RL_Iterations)) + "/" + std::to_string(RL_Iterations), successful_test.size(), failed_test.size(), timed_out_test.size());
    }

    return this->experim_stats;

}

#endif //FASTPHYSER_PARALLELLEARNINGMANAGER_H
