//
// Created by julian on 26.06.23.
//

#ifndef FASTPHYSER_DATACOLLECTOR_H
#define FASTPHYSER_DATACOLLECTOR_H

#include <oneapi/tbb/concurrent_vector.h>

#include <boost/circular_buffer.hpp>


class DataCollector {

public:
    virtual void add_iteration_data(const tbb::concurrent_vector<std::pair<std::vector<float>,float>>& d) = 0;

    [[nodiscard]] virtual std::vector<std::pair<std::vector<float>, float>> get_all_data() const = 0;

    [[nodiscard]] virtual size_t get_size() const = 0;

    [[nodiscard]] virtual std::string get_name() const = 0;

    virtual ~DataCollector() = default;

};


class DefaultDataCollector : public DataCollector {

private:
    std::vector<std::pair<std::vector<float>, float>> data;


public:
    void add_iteration_data(const tbb::concurrent_vector<std::pair<std::vector<float>,float>>& d) override;

    [[nodiscard]] std::vector<std::pair<std::vector<float>, float>> get_all_data() const override { return data; }

    [[nodiscard]] size_t get_size() const override { return data.size(); }

    [[nodiscard]] std::string get_name() const override { return "DefaultDataCollector"; }

};


class CircularDataCollector : public DataCollector {

    boost::circular_buffer<std::vector<std::pair<std::vector<float>, float>>> buffer;

public:

    explicit CircularDataCollector(const size_t& size) : buffer{size} { }

    void add_iteration_data(const tbb::concurrent_vector<std::pair<std::vector<float>,float>>& d) override;

    [[nodiscard]] std::vector<std::pair<std::vector<float>, float>> get_all_data() const override;

    [[nodiscard]] size_t get_size() const override;

    [[nodiscard]] std::string get_name() const override { return "CircularColl(" + std::to_string(this->buffer.capacity()) + ")"; }

};


#endif //FASTPHYSER_DATACOLLECTOR_H
