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

    experiment_statistics experim_stats;



public:
    explicit ParallelLearningManager(AbstractFeatureGenerator* features,
                                    PolicyFunction* pol,
                                    ValueFunction* val,
                                    po::variables_map& vm):
            features{features},
            policy{pol},
            value{val},
            experim_stats(features, pol, val)
    {
        if (vm.contains("RL-its")) {
            RL_Iterations = vm["RL-its"].as<int>();
        }

    }

    void searcher_status(std::size_t successful,
                         std::size_t failed,
                         std::size_t timed_out);


public:

    /**
     * Should probably return some statistics
     */
    experiment_statistics start(std::vector<std::string>& problems);

};


template<class Search>
void ParallelLearningManager<Search>::searcher_status(std::size_t successful,
                                                      std::size_t failed,
                                                      std::size_t timed_out) {

    auto total_completed = successful + failed + timed_out;
    static std::string reset_position;
    auto stats = experim_stats.render_statistics();
    stats.push_back(ftxui::window(ftxui::text("Current Iteration " + std::to_string(experim_stats.iterations.size()+1) + "/" + std::to_string(this->RL_Iterations)),
                                  ftxui::vbox({
                                      ftxui::hbox({
                                          ftxui::text(pad_right("Completed ", 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(std::to_string(total_completed) + "/" + std::to_string(experim_stats.problems.size()), 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(get_formatted_percentage_of(static_cast<int>(total_completed), experim_stats.problems.size()) + "%", 6)),
                                          ftxui::separator(),
                                          ftxui::gauge(
                                                  static_cast<float>(total_completed) /
                                                  static_cast<float>(experim_stats.problems.size()))
                                      }),
                                      ftxui::separator(),
                                      ftxui::hbox({
                                          ftxui::text(pad_right("Solved", 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(std::to_string(successful) + "/" +std::to_string(total_completed), 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(get_formatted_percentage_of(static_cast<int>(successful), static_cast<int>(total_completed)) + "%", 6)),
                                          ftxui::separator(),
                                          ftxui::gauge(
                                                  static_cast<float>(successful) /
                                                  static_cast<float>(total_completed))
                                      }),
                                      ftxui::hbox({
                                          ftxui::text(pad_right("Failed", 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(std::to_string(failed) + "/" +std::to_string(total_completed), 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(get_formatted_percentage_of(static_cast<int>(failed), static_cast<int>(total_completed)) + "%", 6)),
                                          ftxui::separator(),
                                          ftxui::gauge(
                                                  static_cast<float>(failed) /
                                                  static_cast<float>(total_completed))
                                      }),
                                      ftxui::hbox({
                                          ftxui::text(pad_right("Timed Out", 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(std::to_string(timed_out) + "/" +std::to_string(total_completed), 12)),
                                          ftxui::separator(),
                                          ftxui::text(pad_right(get_formatted_percentage_of(static_cast<int>(timed_out), static_cast<int>(total_completed)) + "%", 6)),
                                          ftxui::separator(),
                                          ftxui::gauge(
                                              static_cast<float>(timed_out) /
                                              static_cast<float>(total_completed))
                                      })
                                  }))
                                  );
    auto document = ftxui::vbox(stats);
    auto screen = ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(document));
    Render(screen, document);
    std::cout << reset_position;
    screen.Print();
    reset_position = screen.ResetPosition();

}


template<class Search>
experiment_statistics ParallelLearningManager<Search>::start(std::vector<std::string>& problems) {

    experim_stats.problems = problems;

    tbb::concurrent_vector<std::pair<std::vector<float>,float>> policy_data;
    tbb::concurrent_vector<std::pair<std::vector<float>,float>> value_data;


    for (int iteration = 0; iteration < RL_Iterations; ++iteration) {

        std::cout << "###################### ITERATION " << iteration+1 << "/"<<RL_Iterations << " ######################" << std::endl;

        tbb::concurrent_vector<stat_problem> successful;
        tbb::concurrent_vector<stat_problem> failed;
        tbb::concurrent_vector<stat_problem> timed_out;

        tf::Executor executor(std::thread::hardware_concurrency()/2);
        tf::Taskflow taskflow;


        for (auto & problem : problems) {
            taskflow.emplace([&](){
                Search search(problem, features, policy, value);
                search.start_search();

                //add training data
                // policy training data
                for (auto& pair : search.get_policy_data()) {
                    policy_data.emplace_back(pair);
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
                this->searcher_status(successful.size(), failed.size(), timed_out.size());
            });

        }

        auto t1 = std::chrono::steady_clock::now();

        // run
        executor.run(taskflow).wait();

        auto time = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - t1);

        // look at all problems to gather statistics and training data
        experiment_iteration& it_stat = experim_stats.iterations.emplace_back();
        it_stat.iteration_time = time;
        it_stat.policy_data_size = policy_data.size();
        it_stat.value_data_size = value_data.size();

        it_stat.succeeded = std::vector<stat_problem>(successful.begin(), successful.end());
        it_stat.failed = std::vector<stat_problem>(failed.begin(), failed.end());
        it_stat.timed_out = std::vector<stat_problem>(timed_out.begin(), timed_out.end());

        // add new training data and train if we have iterations left
        if (iteration < this->RL_Iterations - 1) {
            if (policy) {
                std::vector<std::pair<std::vector<float>,float>> tmp_pol(policy_data.begin(), policy_data.end());
                policy->set_training_data(tmp_pol);
                policy->train();
            }

            if (value) {
                std::vector<std::pair<std::vector<float>,float>> tmp_val(value_data.begin(), value_data.end());
                value->set_training_data(tmp_val);
                value->train();
            }
        }

    }

    return this->experim_stats;

}

#endif //FASTPHYSER_PARALLELLEARNINGMANAGER_H
