//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_VALUE_H
#define FASTPHYSER_VALUE_H

#include <vector>
#include <xgboost/c_api.h>
#include <optional>
#include <string>

class ValueFunction {

public:

    virtual ~ValueFunction() = default;

    virtual bool train(const std::vector<std::pair<std::vector<float>, float>>& pairs) = 0;

    virtual bool can_predict() = 0;

    virtual std::vector<float> predict(const std::vector<std::vector<float>>& inputs) = 0;

    virtual std::vector<float> predict(const std::vector<float>& inputs, std::size_t rows, std::size_t cols) = 0;

    [[nodiscard]] virtual std::string get_name() const = 0;
};


class XGBoostValue : public ValueFunction {

    std::optional<BoosterHandle> booster=std::nullopt;

    bool ready_predict=false;


public:

    XGBoostValue();

    ~XGBoostValue() override;

    bool train(const std::vector<std::pair<std::vector<float>, float>>& data) override;

    bool can_predict() override{return ready_predict;}

    std::vector<float> predict(const std::vector<std::vector<float>>& inputs) override;

    std::vector<float> predict(const std::vector<float>& inputs, std::size_t rows, std::size_t cols) override;

    [[nodiscard]] std::string get_name() const override {return "XGBoostValue";}
};



#endif //FASTPHYSER_VALUE_H
