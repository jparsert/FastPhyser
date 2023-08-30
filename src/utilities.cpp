//
// Created by julian on 09.02.23.
//

#include "utilities.h"
#include <fstream>
#include <iterator>
#include <sstream>
#include <string>
#include <vector>

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

std::string get_formatted_percentage_of(int x, int y) {
    char str[80];
    sprintf(str, "%.f", (100.0*(static_cast<float>(x)/static_cast<float>(y))));
    return str;

}

std::string get_formatted_percentage_of(size_t x, size_t y) {
    char str[80];
    sprintf(str, "%.f", (100.0*(static_cast<float>(x)/static_cast<float>(y))));
    return str;
}

#include <sys/types.h>
#include <sys/sysinfo.h>
#include <cstdlib>
#include <cstdio>
#include <cstring>


size_t parse_read_mem_info_line(char* line){
    // This assumes that a digit will be found and the line ends in " Kb".
    size_t i = strlen(line);
    const char* p = line;
    while (*p <'0' || *p > '9') p++;
    line[i-3] = '\0';
    i = atoi(p);
    return i;
}


size_t current_process_vmemory(){ //Note: value read in KB, we multiply by 1000 to get bytes
    FILE* file = fopen("/proc/self/status", "r");
    size_t result = -1;
    char line[128];

    while (fgets(line, 128, file) != NULL){
        if (strncmp(line, "VmSize:", 7) == 0){
            result = parse_read_mem_info_line(line);
            break;
        }
    }
    fclose(file);
    return result*1000;
}

size_t total_system_vmemory() {
    struct sysinfo memInfo{};
    sysinfo(&memInfo);
    size_t totalVirtualMem = memInfo.totalram;
    //Add other values in next statement to avoid int overflow on right hand side...
    totalVirtualMem += memInfo.totalswap;
    totalVirtualMem *= memInfo.mem_unit;

    return totalVirtualMem;
}

std::vector<int> read_lines_in_file_as_int(const std::string& path) {
    std::vector<int> vec;

    std::ifstream file_in(path);
    if (!file_in) {
        throw std::exception();
    }

    std::string line;
    while (std::getline(file_in, line))
    {
        vec.push_back(std::stoi(line));
    }

    return vec;
}