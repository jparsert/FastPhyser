//
// Created by julian on 24.02.23.
//

#ifndef FASTPHYSER_STATISTICS_H
#define FASTPHYSER_STATISTICS_H

#include "constants.h"
#include <string>
#include <utility>
#include <vector>
#include <chrono>

#include <ftxui/dom/elements.hpp>  // for operator|, text, Element, hbox, bold, color, filler, separator, vbox, window, gauge, Fit, size, dim, EQUAL, WIDTH
#include <ftxui/screen/screen.hpp>  // for Full, Screen
#include <ftxui/dom/node.hpp>  // for Render
#include <ftxui/screen/color.hpp>  // for Color, Color:

#include <oneapi/tbb/concurrent_vector.h>

#include "guidance/Value.h"
#include "Features.h"
#include "guidance/Policy.h"

#include <nlohmann/json.hpp>

using json = nlohmann::json;

// Holding the statistics during training for printing and saving

std::shared_ptr<ftxui::Node>to_ftxui_text(int number);


std::shared_ptr<ftxui::Node>to_ftxui_text(const std::string& str);

struct stat_problem{
    std::string name;
    unsigned long graph_size;
    std::chrono::seconds search_time;
};


struct experiment_iteration {
    std::chrono::seconds iteration_time_training;
    std::chrono::seconds iteration_time_test;

    std::size_t policy_data_size;
    std::size_t value_data_size;

    tbb::concurrent_vector<stat_problem> failed;

    tbb::concurrent_vector<stat_problem> succeeded;

    tbb::concurrent_vector<stat_problem> timed_out;

    tbb::concurrent_vector<stat_problem> test_failed;

    tbb::concurrent_vector<stat_problem> test_succeeded;

    tbb::concurrent_vector<stat_problem> test_timed_out;

public:
    [[nodiscard]] unsigned long get_average_graph_size_test() const {
        unsigned long sum = 0;
        for (const auto& x : test_succeeded) {
            sum += x.graph_size;
        }

        return sum/std::max(test_succeeded.size(), static_cast<std::size_t>(1));
    }

    [[nodiscard]] unsigned long get_average_graph_size_training() const {
        unsigned long sum = 0;
        for (const auto& x : succeeded) {
            sum += x.graph_size;
        }

        return sum/std::max(succeeded.size(), static_cast<std::size_t>(1));
    }

};


struct experiment_statistics {
    // TODO add commandline options

    std::vector<std::string> problems;
    std::vector<std::string> testing_set;
    std::vector<experiment_iteration> iterations;
    std::chrono::seconds timeout;
    int num_parallel_option = 0;
    std::string features_generator;
    std::string policy;
    std::string value;
    std::string git_hash = GIT_COMMIT_HASH;
    std::string run_command;
    std::string search_name;
    std::string seed;
    std::string policy_max_depth = std::to_string(POLICY_MAX_DEPTH);
    std::string value_max_depth = std::to_string(VALUE_MAX_DEPTH);
    std::string policy_data_mgr;
    std::string value_data_mgr;


private:
    [[nodiscard]] ftxui::Element render_general_info() const;
    [[nodiscard]] ftxui::Element render_iterations_abs() const;

public:

    experiment_statistics(std::string  feature_gen,
                          std::string  policy,
                          std::string  value,
                          std::chrono::seconds timeout,
                          std::string  searcher,
                          std::string seed,
                          int parallelism,
                          std::string policy_data_mgr,
                          std::string value_data_mgr):
        features_generator(std::move(feature_gen)),
        policy(std::move(policy)),
        value(std::move(value)),
        timeout(timeout),
        search_name(std::move(searcher)),
        seed(std::move(seed)),
        num_parallel_option(parallelism),
        policy_data_mgr(std::move(policy_data_mgr)),
        value_data_mgr(std::move(value_data_mgr))
    {   }

    experiment_statistics(std::string features,
                          PolicyFunction* pol,
                          ValueFunction* val,
                          std::chrono::seconds timeout,
                          std::string name,
                          std::string seed,
                          int parallel,
                          std::string policy_data_mgr,
                          std::string value_data_mgr) :
            experiment_statistics(std::move(features),
                   pol ? pol->get_name() : "DEFAULT",
                   val ? val->get_name() : "DEFAULT",
                   timeout, std::move(name),
                   std::move(seed), parallel,
                   std::move(policy_data_mgr),
                   std::move(value_data_mgr))
    {}

    [[nodiscard]] ftxui::Elements render_statistics() const;

    void add_run_command(std::basic_string<char> basicString);

    void print_to_file(const std::string& file) const;

};

void ftxui_print_searcher_status(const experiment_statistics& experim_stats,
                                 const std::string& text,
                                 std::size_t successful,
                                 std::size_t failed,
                                 std::size_t timed_out,
                                 std::size_t overall_num);


using ordered_json = nlohmann::ordered_json;

json to_json(const stat_problem& problem);
json to_json(const experiment_iteration& experiment_iteration);
ordered_json to_json(const experiment_statistics& experiment_statistics);



#endif //FASTPHYSER_STATISTICS_H
