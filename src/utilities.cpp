//
// Created by julian on 09.02.23.
//

#include "utilities.h"

std::vector<std::string> files_with_suffix_in_dirs(const std::vector<std::string>& dirs, const std::string& suffix) {
    std::vector<std::string> res;

    for (auto& dir : dirs) {
        if (std::filesystem::is_regular_file(dir)) {
            if (dir.ends_with(suffix)) {
                res.push_back(dir);
            }
            continue;
        }
        for (const auto &entry: std::filesystem::directory_iterator(dir)) {
            if (entry.path().string().ends_with(suffix)) {
                res.push_back(entry.path().string());
            }
        }
    }

    return res;
}