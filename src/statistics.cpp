//
// Created by julian on 24.02.23.
//

#include "statistics.h"

#include <utility>

#include <nlohmann/json.hpp>
#include <fstream>

using ordered_json = nlohmann::ordered_json;

std::shared_ptr<ftxui::Node> to_ftxui_text(int number) {
    return ftxui::text(std::to_string(number)) | size(ftxui::WIDTH, ftxui::EQUAL, 12);
}

std::shared_ptr<ftxui::Node> to_ftxui_text(const std::string &str) {
    return ftxui::text(str) | size(ftxui::WIDTH, ftxui::EQUAL, 20);
}


ftxui::Elements experiment_statistics::render_statistics() const {
    ftxui::Elements result;
    result.push_back(render_general_info());
    result.push_back(render_iterations_abs());

    return result;
}

ftxui::Element experiment_statistics::render_general_info() const {
    auto some_info = ftxui::vbox({
                                         ftxui::hbox({
                                                             ftxui::vbox({
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Git Hash: "),
                                                                                                     to_ftxui_text(
                                                                                                             GIT_COMMIT_HASH),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Timeout (s): "),
                                                                                                     to_ftxui_text(
                                                                                                             static_cast<int>(timeout.count())),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Strategy: "),
                                                                                                     to_ftxui_text(
                                                                                                             search_name),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Value: "),
                                                                                                     to_ftxui_text(
                                                                                                             this->value),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Policy: "),
                                                                                                     to_ftxui_text(
                                                                                                             this->policy),
                                                                                             }),
                                                                         }),
                                                             ftxui::separator(),
                                                             ftxui::vbox({
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Features Extract.:"),
                                                                                                     to_ftxui_text(
                                                                                                             this->features_generator),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "Seed:"),
                                                                                                     to_ftxui_text(
                                                                                                             this->seed),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "# training problems:"),
                                                                                                     to_ftxui_text(
                                                                                                             static_cast<int>(this->problems.size())),
                                                                                             }),
                                                                                 ftxui::hbox({
                                                                                                     to_ftxui_text(
                                                                                                             "# testing problems:"),
                                                                                                     to_ftxui_text(
                                                                                                             static_cast<int>(this->testing_set.size())),
                                                                                             }),
                                                                         }),
                                                     })
                                 });
    return window(ftxui::text("Experiment Options"), some_info);
}


ftxui::Element experiment_statistics::render_iterations_abs() const {
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
                                      ftxui::text(pad_left("Avg. Graph Size", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Tot Tr Time ", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Test Succ ", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Test Fail ", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Test T/O ", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Avg. Graph Size", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Policy data len", ' ', 16)),
                                      ftxui::separator(),
                                      ftxui::text(pad_left("Value data len", ' ', 16)),

                              }));
    its.push_back(ftxui::separator());

    for (int i = static_cast<int>(std::max(iterations.size() - 10, std::size_t(0))); i < iterations.size(); ++i) {
        int solved = static_cast<int>(iterations[i].succeeded.size());
        int failed = static_cast<int>(iterations[i].failed.size());
        int timed_out = static_cast<int>(iterations[i].timed_out.size());
        int total = static_cast<int>(problems.size());

        int solved_test = static_cast<int>(iterations[i].test_succeeded.size());
        int failed_test = static_cast<int>(iterations[i].test_failed.size());
        int timed_out_test = static_cast<int>(iterations[i].test_timed_out.size());
        int total_test = static_cast<int>(testing_set.size());

        int policy_data_size = static_cast<int>(iterations[i].policy_data_size);
        int value_data_size = static_cast<int>(iterations[i].value_data_size);

        unsigned long avg_graph_size =  iterations[i].get_average_graph_size_training();

        unsigned long avg_graph_size_test = iterations[i].get_average_graph_size_test();


        its.push_back(ftxui::vbox({
                                          i==(iterations.size() - 1) ? ftxui::text(std::to_string(i+1) + " (current)") : to_ftxui_text(i + 1),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(solved, total) + "% (" +
                                                        std::to_string(solved) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(failed, total) + "% (" +
                                                        std::to_string(failed) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(timed_out, total) + "% (" +
                                                        std::to_string(timed_out) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(avg_graph_size) + " Vtx."),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(iterations[i].iteration_time.count()) + "s"),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(solved_test, total_test) + "% (" +
                                                        std::to_string(solved_test) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(get_formatted_percentage_of(failed_test, total_test) + "% (" +
                                                        std::to_string(failed_test) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(
                                                  get_formatted_percentage_of(timed_out_test, total_test) + "% (" +
                                                  std::to_string(timed_out_test) + ")"),
                                          ftxui::separator(),
                                          to_ftxui_text(std::to_string(avg_graph_size_test) + " Vtx."),
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

void experiment_statistics::print_to_file(const std::string &file) const {
    nlohmann::ordered_json js_res = to_json(*this);
    std::ofstream res_file(file);
    res_file << std::setw(4) << js_res << std::endl;
}

json to_json(const stat_problem &prob) {
    json j;
    j["problem"] = prob.name;
    j["graph_size"] = prob.graph_size;
    j["search_time_seconds"] = prob.search_time.count();
    return j;
}


json to_json(const experiment_iteration &it) {
    json res;
    res["iteration_time"] = it.iteration_time.count();
    res["policy_data_pairs"] = it.policy_data_size;
    res["value_data_pairs"] = it.value_data_size;

    auto successful = json::array();
    for (const auto &problem: it.succeeded) {
        successful.push_back(to_json(problem));
    }
    res["successful"] = successful;

    auto failed = json::array();
    for (const auto &problem: it.failed) {
        failed.push_back(to_json(problem));
    }
    res["failed"] = failed;

    auto timed_out = json::array();
    for (const auto &problem: it.timed_out) {
        timed_out.push_back(to_json(problem));
    }
    res["timed_out"] = timed_out;


    // TESTING DATA
    auto successful_test = json::array();
    for (const auto &problem: it.test_succeeded) {
        successful_test.push_back(to_json(problem));
    }
    res["successful_test"] = successful_test;

    auto failed_test = json::array();
    for (const auto &problem: it.test_failed) {
        failed_test.push_back(to_json(problem));
    }
    res["failed_test"] = failed_test;

    auto timed_out_test = json::array();
    for (const auto &problem: it.test_timed_out) {
        timed_out_test.push_back(to_json(problem));
    }
    res["timed_out_test"] = timed_out_test;


    return res;
}


ordered_json to_json(const experiment_statistics &exp_stats) {
    ordered_json res;

    res["feature_generator"] = exp_stats.features_generator;
    res["policy_function"] = exp_stats.policy;
    res["value_function"] = exp_stats.value;
    res["timeout"] = exp_stats.timeout.count();
    res["git_hash"] = exp_stats.git_hash;
    res["run_command"] = exp_stats.run_command;
    res["seed"] = exp_stats.seed;
    res["search_algorithm"] = exp_stats.search_name;

    res["all_problems"] = exp_stats.problems;
    res["testing_set_problems"] = exp_stats.testing_set;

    auto iterations = json::array();
    for (const auto &it: exp_stats.iterations) {
        iterations.push_back(to_json(it));
    }
    res["iterations"] = iterations;
    return res;
}


void ftxui_print_searcher_status(const experiment_statistics &experim_stats, const std::string& heading, std::size_t successful,
                                 std::size_t failed,
                                 std::size_t timed_out) {

    auto total_completed = successful + failed + timed_out;
    auto stats = experim_stats.render_statistics();
    stats.push_back(ftxui::window(ftxui::text(heading),
                                  ftxui::vbox({
                                                      ftxui::hbox({
                                                                          ftxui::text(pad_right("Completed ", 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  std::to_string(total_completed) +
                                                                                  "/" + std::to_string(
                                                                                          experim_stats.problems.size()),
                                                                                  12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  get_formatted_percentage_of(
                                                                                          static_cast<int>(total_completed),
                                                                                          static_cast<int>(experim_stats.problems.size())) +
                                                                                  "%", 6)),
                                                                          ftxui::separator(),
                                                                          ftxui::gauge(
                                                                                  static_cast<float>(total_completed) /
                                                                                  static_cast<float>(experim_stats.problems.size()))
                                                                  }),
                                                      ftxui::separator(),
                                                      ftxui::hbox({
                                                                          ftxui::text(pad_right("Solved", 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  std::to_string(successful) + "/" +
                                                                                  std::to_string(total_completed), 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  get_formatted_percentage_of(
                                                                                          static_cast<int>(successful),
                                                                                          static_cast<int>(total_completed)) +
                                                                                  "%", 6)),
                                                                          ftxui::separator(),
                                                                          ftxui::gauge(
                                                                                  static_cast<float>(successful) /
                                                                                  static_cast<float>(total_completed))
                                                                  }),
                                                      ftxui::hbox({
                                                                          ftxui::text(pad_right("Failed", 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  std::to_string(failed) + "/" +
                                                                                  std::to_string(total_completed), 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  get_formatted_percentage_of(
                                                                                          static_cast<int>(failed),
                                                                                          static_cast<int>(total_completed)) +
                                                                                  "%", 6)),
                                                                          ftxui::separator(),
                                                                          ftxui::gauge(
                                                                                  static_cast<float>(failed) /
                                                                                  static_cast<float>(total_completed))
                                                                  }),
                                                      ftxui::hbox({
                                                                          ftxui::text(pad_right("Timed Out", 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  std::to_string(timed_out) + "/" +
                                                                                  std::to_string(total_completed), 12)),
                                                                          ftxui::separator(),
                                                                          ftxui::text(pad_right(
                                                                                  get_formatted_percentage_of(
                                                                                          static_cast<int>(timed_out),
                                                                                          static_cast<int>(total_completed)) +
                                                                                  "%", 6)),
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
    std::cout << screen.ResetPosition();
    screen.Print();
}
