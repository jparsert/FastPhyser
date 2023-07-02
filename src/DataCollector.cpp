//
// Created by julian on 26.06.23.
//

#include "DataCollector.h"
#include "utilities.h"

void DefaultDataCollector::add_iteration_data(const tbb::concurrent_vector<std::pair<std::vector<float>, float>> &d) {
    concat(data, std::vector<std::pair<std::vector<float>,float>>(d.begin(), d.end()));
}

void CircularDataCollector::add_iteration_data(const tbb::concurrent_vector<std::pair<std::vector<float>, float>> &d) {
    buffer.push_back(std::vector<std::pair<std::vector<float>,float>>(d.begin(), d.end()));
}

std::vector<std::pair<std::vector<float>, float>> CircularDataCollector::get_all_data() const {
    std::vector<std::pair<std::vector<float>,float>> tmp;
    for (const auto& el: this->buffer) {
        concat(tmp, el);
    }
    return tmp;
}

size_t CircularDataCollector::get_size() const {
    size_t res = 0;
    for (const auto& el: this->buffer) {
        res += el.size();
    }
    return res;
}
