//
// Created by julian on 24.02.23.
//

#include "statistics.h"

#include <utility>

#include "fplus/fplus.hpp"

#include <nlohmann/json.hpp>
using json = nlohmann::json;

std::shared_ptr<ftxui::Node>to_ftxui_text(int number) {
    return ftxui::text(std::to_string(number)) | size(ftxui::WIDTH, ftxui::EQUAL, 12);
}

std::shared_ptr<ftxui::Node>to_ftxui_text(const std::string& str) {
    return ftxui::text(str) | size(ftxui::WIDTH, ftxui::EQUAL, 15);
}


ftxui::Elements experiment_statistics::render_statistics() {
    ftxui::Elements result;
    result.push_back(render_general_info());
    result.push_back(render_iterations_abs());

    return result;
}

ftxui::Element experiment_statistics::render_general_info() const {
    auto some_info = ftxui::vbox({
                                         ftxui::hbox({
                                                             to_ftxui_text("Git Hash:"), to_ftxui_text(GIT_COMMIT_HASH),
                                                     }),
                                         ftxui::hbox({
                                                             to_ftxui_text("Timeout (s):"), to_ftxui_text(static_cast<int>(timeout.count())),
                                                     }),
                                         ftxui::hbox({
                                                             ftxui::text("Value:"), to_ftxui_text(this->value),
                                                     }),
                                         ftxui::hbox({
                                                             ftxui::text("Policy:"), to_ftxui_text(this->policy),
                                                     }),
                                         ftxui::hbox({
                                                             ftxui::text("Features Extract.:"), to_ftxui_text(this->features_generator),
                                                     }),
                                         ftxui::hbox({
                                                             ftxui::text("Total # of problems:"), to_ftxui_text(static_cast<int>(this->problems.size())),
                                                     }),
                                 });
    return window(ftxui::text("Experiment Options"), some_info);
}

std::string get_formatted_percentage_of(int x, int y) {
    char str[80];
    sprintf(str, "%.f", (100.0*(static_cast<float>(x)/static_cast<float>(y))));
    return str;

}

ftxui::Element experiment_statistics::render_iterations_abs() {
    ftxui::Elements its;
    its.push_back(ftxui::vbox({
        ftxui::text(pad_left("It # ", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("Succ ", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("Fail ", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("T/O ", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("Tot. Time ", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("Avg. Graph Size", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("Policy data len", ' ', 16)),
        ftxui::separator(),
        ftxui::text(pad_left("Value data len", ' ', 16)),

        }));
    its.push_back(ftxui::separator());

    for (int i = 0; i < iterations.size(); ++i) {
        int solved = static_cast<int>(iterations[i].succeeded.size());
        int failed = static_cast<int>(iterations[i].failed.size());
        int timed_out = static_cast<int>(iterations[i].timed_out.size());
        int total = static_cast<int>(problems.size());
        int policy_data_size = static_cast<int>(iterations[i].policy_data_size);
        int value_data_size = static_cast<int>(iterations[i].value_data_size);

        unsigned long avg_graph_size = fplus::fold_left( [](const auto& x, const auto& y){return x+y;}, 0,
                                              fplus::transform(
                                                      [](const stat_problem& problem) {return problem.graph_size;}, iterations[i].succeeded)) / std::max(iterations[i].succeeded.size(), static_cast<std::size_t>(1));


        its.push_back(ftxui::vbox({
                                          to_ftxui_text(i+1),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(solved, total)+"% (" + std::to_string(solved) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(failed, total)+"% (" + std::to_string(failed) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(timed_out, total)+"% (" + std::to_string(timed_out) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(iterations[i].iteration_time.count()) + "s"),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(avg_graph_size) + " Vtx."),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(policy_data_size) + " pairs"),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(value_data_size) + " pairs")
        }));
        its.push_back(ftxui::separator());
    }
    return ftxui::window(ftxui::text(" Previous Iterations"), ftxui::hbox(its));
}

void experiment_statistics::add_run_command(std::basic_string<char> basicString) {
    this->run_command = std::move(basicString);

}

json to_json(const stat_problem& prob) {
    json j;
    j["problem"] = prob.name;
    j["graph_size"] = prob.graph_size;
    return j;
}


json to_json(const experiment_iteration& it) {
    json res;
    res["iteration_time"] = it.iteration_time.count();
    res["policy_data_pairs"] = it.policy_data_size;
    res["value_data_pairs"] = it.value_data_size;

    auto successful = json::array();
    for (const auto& problem : it.succeeded) {
        successful.push_back(to_json(problem));
    }
    res["successful"] = successful;

    auto failed = json::array();
    for (const auto& problem : it.failed) {
        failed.push_back(to_json(problem));
    }
    res["failed"] = failed;

    auto timed_out = json::array();
    for (const auto& problem : it.timed_out) {
        timed_out.push_back(to_json(problem));
    }
    res["timed_out"] = timed_out;
    return res;
}


json to_json(const experiment_statistics& exp_stats) {
    json res;

    res["feature_generator"] = exp_stats.features_generator;
    res["policy_function"] = exp_stats.policy;
    res["value_function"] = exp_stats.value;
    res["timeout"] = exp_stats.timeout.count();
    res["git_hash"] = exp_stats.git_hash;
    res["run_command"] = exp_stats.run_command;
    res["all_problems"] = exp_stats.problems;

    auto iterations = json::array();
    for (const auto& it : exp_stats.iterations) {
        iterations.push_back(to_json(it));
    }
    res["iterations"] = iterations;
    return res;
}

