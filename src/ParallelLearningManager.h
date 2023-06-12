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
#include "Policy.h"
#include "Value.h"
#include <optional>
#include <iostream>
#include <mutex>
#include <oneapi/tbb/concurrent_vector.h>
#include <boost/program_options.hpp>
#include "Sy2CPP/AstPrinter.h"
#include "statistics.h"

#include <taskflow/taskflow.hpp>


namespace po = boost::program_options;


/**
 * Could use SFINAE but let's just do ducktyping for now
 * @tparam Search
 */
template<class Search>
class ParallelLearningManager {

    AbstractFeatureGenerator* features;
    PolicyFunction* policy;
    ValueFunction* value;

    int RL_Iterations = 20;
    int parallel_cores;

    // keep order
    std::chrono::seconds search_timeout;
    experiment_statistics experim_stats;

    po::variables_map argument_map;

public:
    explicit ParallelLearningManager(AbstractFeatureGenerator* features,
                                     PolicyFunction* pol,
                                     ValueFunction* val,
                                     po::variables_map& vm):
            features{features},
            policy{pol},
            value{val},
            search_timeout(vm["timeout"].as<int>()),
            experim_stats(features, pol, val, search_timeout, Search::get_search_name(), vm.count("seed") ? std::to_string(vm["seed"].as<int>()) : ""),
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
    experiment_statistics start(std::vector<std::string>& problems, std::vector<std::string>& test_set);

};


template<class Search>
experiment_statistics ParallelLearningManager<Search>::start(std::vector<std::string>& problems, std::vector<std::string>& test_set) {

    experim_stats.problems = problems;
    experim_stats.testing_set = test_set;

    tbb::concurrent_vector<std::pair<std::vector<float>,float>> policy_data;
    tbb::concurrent_vector<std::pair<std::vector<float>,float>> value_data;


    for (int iteration = 0; iteration < RL_Iterations; ++iteration) {

        // RUN on training set
        tbb::concurrent_vector<stat_problem> successful;
        tbb::concurrent_vector<stat_problem> failed;
        tbb::concurrent_vector<stat_problem> timed_out;
        tf::Executor executor( parallel_cores == 0 ? std::thread::hardware_concurrency() : parallel_cores);
        tf::Taskflow taskflow;
        for (auto & problem : problems) {
            taskflow.emplace([&](){
                Search search(problem, features, policy, value, search_timeout, argument_map, iteration=iteration);
                search.start_search();

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
                if (search.get_solution()) { // successful search
                    successful.emplace_back(stat_problem{search.get_problem(), search.get_graph_size()});
                } else {
                    if (search.search_timed_out()) {
                        timed_out.emplace_back(stat_problem{search.get_problem(), search.get_graph_size()});
                    } else {
                        failed.emplace_back(stat_problem{search.get_problem(), search.get_graph_size()});
                    }
                }

                // print output
                ftxui_print_searcher_status(experim_stats, RL_Iterations, successful.size(), failed.size(), timed_out.size());
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
        for (auto & problem : test_set) {
            taskflow_test.emplace([&](){
                Search search(problem, features, policy, value, search_timeout, argument_map);
                search.start_search();

                // add statistics
                if (search.get_solution()) { // successful search
                    successful_test.emplace_back(stat_problem{search.get_problem(), search.get_graph_size()});
                    //std::vector<Sy2CPP::DefineFunCmd> sol = search.get_solution().value();
                    //std::cout << Sy2CPP::AstToString::to_string(sol[0]) << std::endl;
                } else {
                    if (search.search_timed_out()) {
                        timed_out_test.emplace_back(stat_problem{search.get_problem(), search.get_graph_size()});
                    } else {
                        failed_test.emplace_back(stat_problem{search.get_problem(), search.get_graph_size()});
                    }
                }
                ftxui_print_searcher_status_test(experim_stats, RL_Iterations, successful_test.size(), failed_test.size(), timed_out_test.size());
            });
        }
        // start TESTING RUN with timing
        executor.run(taskflow_test).wait();



        // look at all problems to gather statistics and training data
        experiment_iteration& it_stat = experim_stats.iterations.emplace_back();
        it_stat.iteration_time = time;
        it_stat.policy_data_size = policy_data.size();
        it_stat.value_data_size = value_data.size();

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
            if (policy) {
                std::vector<std::pair<std::vector<float>,float>> tmp_pol(policy_data.begin(), policy_data.end());
                policy->train(tmp_pol, argument_map);
            }

            if (value) {
                std::vector<std::pair<std::vector<float>,float>> tmp_val(value_data.begin(), value_data.end());
                value->train(tmp_val, argument_map);
            }
        }

        ftxui_print_searcher_status(experim_stats, RL_Iterations, successful_test.size(), failed_test.size(), timed_out_test.size());
    }

    return this->experim_stats;

}

#endif //FASTPHYSER_PARALLELLEARNINGMANAGER_H
