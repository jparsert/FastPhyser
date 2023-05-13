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
        } else {
            for (const auto &entry: std::filesystem::recursive_directory_iterator(dir)) {
                if (entry.path().string().ends_with(suffix)) {
                    res.push_back(entry.path().string());
                }
            }
        }
    }

    return res;
}


std::string pad_right(std::string const& str, size_t s, char padding)
{
    if ( str.size() < s ) {
        return str + std::string(s - str.size(), padding);
    } else {
        return str;
    }
}


std::string pad_left(std::string const& str, size_t s, char padding)
{
    if ( str.size() < s ) {
        return std::string(s - str.size(), padding) + str;
    } else {
        return str;
    }
}


std::string get_compiled_git_hash() {
    return GIT_COMMIT_HASH;
}


std::string get_current_timestamp_as_string() { // todo fix this with c++20 once std::format is implemented
    auto t = std::time(nullptr);
    auto tm = *std::localtime(&t);

    std::ostringstream oss;
    oss << std::put_time(&tm, "%d-%m-%Y||%H-%M-%S");
    auto str = oss.str();
    return str;
}