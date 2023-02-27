//
// Created by julian on 24.02.23.
//

#include "statistics.h"


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
        ftxui::text("It # "),
        ftxui::separator(),
        ftxui::text("Succ "),
        ftxui::separator(),
        ftxui::text("Fail "),
        ftxui::separator(),
        ftxui::text("T/O "),
        ftxui::separator(),
        ftxui::text("Tot. Time ")
        }));
    its.push_back(ftxui::separator());

    for (int i = 0; i < iterations.size(); ++i) {
        int solved = static_cast<int>(iterations[i].succeeded.size());
        int failed = static_cast<int>(iterations[i].failed.size());
        int timed_out = static_cast<int>(iterations[i].timed_out.size());
        int total = static_cast<int>(problems.size());

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
        }));
        its.push_back(ftxui::separator());
    }
    return ftxui::window(ftxui::text(" Previous Iterations"), ftxui::hbox(its));
}
