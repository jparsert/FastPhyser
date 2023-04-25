//
// Created by julian on 24.02.23.
//

#ifndef FASTPHYSER_STATISTICS_H
#define FASTPHYSER_STATISTICS_H


#include <string>
#include <utility>
#include <vector>
#include <chrono>


#include <ftxui/dom/elements.hpp>  // for operator|, text, Element, hbox, bold, color, filler, separator, vbox, window, gauge, Fit, size, dim, EQUAL, WIDTH
#include <ftxui/screen/screen.hpp>  // for Full, Screen
#include <ftxui/dom/node.hpp>  // for Render
#include <ftxui/screen/color.hpp>  // for Color, Color:

#include "Value.h"
#include "Features.h"
#include "Policy.h"

#include <nlohmann/json.hpp>
using json = nlohmann::json;

// Holding the statistics during training for printing and saving

std::shared_ptr<ftxui::Node>to_ftxui_text(int number);

std::string get_formatted_percentage_of(int x, int y);

std::shared_ptr<ftxui::Node>to_ftxui_text(const std::string& str);

struct stat_problem{
    std::string name;
    unsigned long graph_size;
};


struct experiment_iteration {
    std::chrono::seconds iteration_time;
    std::size_t policy_data_size;
    std::size_t value_data_size;

    std::vector<stat_problem> failed;

    std::vector<stat_problem> succeeded;

    std::vector<stat_problem> timed_out;


};


struct experiment_statistics {
    // TODO add commandline options

    std::vector<std::string> problems;
    std::vector<experiment_iteration> iterations;
    std::chrono::seconds timeout;
    std::string features_generator;
    std::string policy;
    std::string value;
    std::string git_hash = GIT_COMMIT_HASH;
    std::string run_command;
    std::string search_name;

private:
    [[nodiscard]] ftxui::Element render_general_info() const;
    ftxui::Element render_iterations_abs();

public:

    experiment_statistics(std::string  feature_gen, std::string  policy, std::string  value, std::chrono::seconds timeout, std::string  searcher):
        features_generator(std::move(feature_gen)),
        policy(std::move(policy)),
        value(std::move(value)),
        timeout(timeout),
        search_name(std::move(searcher))
    {   }

    experiment_statistics(AbstractFeatureGenerator* features, PolicyFunction* pol, ValueFunction* val,
                          std::chrono::seconds timeout, std::string name) :
            experiment_statistics(features? features->get_name() : "DEFAULT",
                   pol ? pol->get_name() : "DEFAULT",
                   val ? val->get_name() : "DEFAULT",
                   timeout, std::move(name))
    {}

    ftxui::Elements render_statistics();

    void add_run_command(std::basic_string<char> basicString);

};


json to_json(const stat_problem& problem);
json to_json(const experiment_iteration& experiment_iteration);
json to_json(const experiment_statistics& experiment_statistics);

#endif //FASTPHYSER_STATISTICS_H
