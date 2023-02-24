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

#include "indicators/indicators.hpp"
#include "statistics.h"

#include <taskflow/taskflow.hpp>

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

    std::mutex completed_indices_mutex;
    std::vector<int> completed_indices;


public:
    explicit ParallelLearningManager(AbstractFeatureGenerator* features,
                                    PolicyFunction* pol,
                                    ValueFunction* val):
            features{features},
            policy{pol},
            value{val},
            experim_stats(features, pol, val)
    {}

    void searcher_status(const std::vector<Search>& );


public:

    /**
     * Should probably return some statistics
     */
    void start(std::vector<std::string>& problems);


};


template<class Search>
void ParallelLearningManager<Search>::searcher_status(const std::vector<Search>& searchers) {

    std::string reset_position;
    while(this->completed_indices.size() < searchers.size()) {
        auto stats = experim_stats.render_statistics();
        stats.push_back(ftxui::window(ftxui::text("Current Iteration " + std::to_string(experim_stats.iterations.size()+1) + "/" +
                                              std::to_string(this->RL_Iterations)), ftxui::hbox({
                                                  ftxui::text(std::to_string(completed_indices.size())), ftxui::text("/"),
                                                  ftxui::text(std::to_string(searchers.size())),
                                                  ftxui::separator(),
                                                  ftxui::text(get_formatted_percentage_of(completed_indices.size(),searchers.size()) + "%"),
                                                  ftxui::separator(),
                                                  ftxui::gauge(static_cast<float>(completed_indices.size())/static_cast<float>(searchers.size()))
                                              })));
        auto document = ftxui::vbox(stats);
        auto screen = ftxui::Screen::Create(ftxui::Dimension::Full(), ftxui::Dimension::Fit(document));
        Render(screen, document);
        std::cout << reset_position;
        screen.Print();
        reset_position = screen.ResetPosition();

        std::this_thread::sleep_for(std::chrono::seconds (10));
    }
}


template<class Search>
void ParallelLearningManager<Search>::start(std::vector<std::string>& problems) {

    experim_stats.problems = problems;

    std::vector<std::pair<std::vector<float>,float>> policy_data;
    std::vector<std::pair<std::vector<float>,float>> value_data;


    for (int iteration = 0; iteration < RL_Iterations; ++iteration) {

        std::cout << "###################### ITERATION " << iteration+1 << "/"<<RL_Iterations << " ######################" << std::endl;

        using namespace indicators;
        indicators::BlockProgressBar rlloop_bar{
                option::BarWidth{80},
                option::ForegroundColor{Color::blue},
                option::FontStyles{
                        std::vector<FontStyle>{FontStyle::bold}},
                option::MaxProgress{problems.size()}
        };

        std::vector<std::string> successful;
        std::vector<std::string> failed;
        std::vector<std::string> timed_out;
        tf::Executor executor(2);
        tf::Taskflow taskflow;

        std::vector<Search> searchers;
        completed_indices.clear();


        for (int i = 0; i < problems.size(); ++i) {
            searchers.emplace_back(problems[i], features, policy, value);
            auto task = taskflow.emplace([&,i](){
                searchers[i].start_search();
                std::lock_guard<std::mutex> lock(this->completed_indices_mutex);
                completed_indices.push_back(i);
            });

        }

        auto t1 = std::chrono::steady_clock::now();

        // run
        std::thread stat_printing([&](){std::cout << "Starting Printing" << std::endl; this->searcher_status(searchers);});
        executor.run(taskflow).wait();
        stat_printing.join();


        auto time = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now() - t1);

        // look at all problems to gather statistics and training data
        experiment_iteration& it_stat = experim_stats.iterations.emplace_back();
        it_stat.iteration_time = time;
        it_stat.policy_data_size = policy_data.size();
        it_stat.value_data_size = value_data.size();

        for (auto& searcher : searchers) {

            // add to lists for statistics
            if (searcher.get_solution()) { // successful search
                successful.push_back(searcher.get_problem());
                it_stat.succeeded.emplace_back(stat_problem{searcher.get_problem(), searcher.get_graph_size()});
            } else {
                if (searcher.search_timed_out()) {
                    timed_out.push_back(searcher.get_problem());
                    it_stat.timed_out.emplace_back(stat_problem{searcher.get_problem(), searcher.get_graph_size()});
                } else {
                    it_stat.failed.emplace_back(stat_problem{searcher.get_problem(), searcher.get_graph_size()});
                }
            }

            // policy training data
            for (auto& pair : searcher.get_policy_data()) {
                policy_data.emplace_back(pair);
            }

            // value training data;
            for (auto& pair : searcher.get_value_data()) {
                value_data.emplace_back(pair);
            }

        }
        std::cout << std::endl;

        // add new training data and train if we have iterations left
        if (iteration < this->RL_Iterations - 1) {
            if (policy) {
                policy->set_training_data(policy_data);
                policy->train();
            }

            if (value) {
                value->set_training_data(value_data);
                value->train();
            }
        }

    }

}

#endif //FASTPHYSER_PARALLELLEARNINGMANAGER_H
