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
    std::string features_generator;
    std::string policy;
    std::string value;
    std::string git_hash = GIT_COMMIT_HASH;

private:
    [[nodiscard]] ftxui::Element render_general_info() const;
    ftxui::Element render_iterations_abs();

public:

    experiment_statistics(std::string  feature_gen, std::string  policy, std::string  value):
        features_generator(std::move(feature_gen)),
        policy(std::move(policy)),
        value(std::move(value))
    {   }

    experiment_statistics(AbstractFeatureGenerator* features, PolicyFunction* pol, ValueFunction* val) :
            experiment_statistics(features? features->get_name() : "",
                   pol ? pol->get_name() : "",
                   val ? val->get_name() : "")
    {}



    ftxui::Elements render_statistics();

};


#endif //FASTPHYSER_STATISTICS_H
