//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_VALUE_H
#define FASTPHYSER_VALUE_H

#include <vector>
#include <optional>
#include <string>

#include <xgboost/c_api.h>

#include <boost/program_options.hpp>


class ValueFunction {

public:

    virtual ~ValueFunction() = default;

    virtual bool train(const std::vector<std::pair<std::vector<float>, float>>& data, boost::program_options::variables_map& vm) = 0;

    virtual bool can_predict() = 0;

    virtual std::vector<float> predict(std::vector<std::vector<float>>& inputs) = 0;

    [[nodiscard]] virtual std::string get_name() const = 0;

    virtual std::vector<float> predict(const std::vector<float> &inputs, size_t rows, size_t cols) = 0;
};


class XGBoostValue : public ValueFunction {

    std::optional<BoosterHandle> booster=std::nullopt;

    bool ready_predict=false;


public:

    XGBoostValue();

    ~XGBoostValue() override;

    bool train(const std::vector<std::pair<std::vector<float>, float>>& data, boost::program_options::variables_map& vm) override;

    bool can_predict() override{return ready_predict;}

    std::vector<float> predict(std::vector<std::vector<float>>& inputs) override;

    [[nodiscard]] std::string get_name() const override {return "XGBoostValue";}

    std::vector<float> predict(const std::vector<float> &inputs, size_t rows, size_t cols) override;
};



#endif //FASTPHYSER_VALUE_H