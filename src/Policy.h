//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_POLICY_H
#define FASTPHYSER_POLICY_H

#include <vector>

#include <xgboost/c_api.h>
#include <memory>
#include <optional>

class PolicyFunction {

public:

    virtual ~PolicyFunction() = default;

    virtual void set_training_data(std::vector<std::pair<std::vector<float>, float>>& pairs) = 0;

    virtual bool train() = 0;

    virtual bool can_predict() = 0;

    virtual std::vector<float> predict(std::vector<std::vector<float>>& inputs) = 0;

    [[nodiscard]] virtual std::string get_name() const = 0;
};


class XGBoostPolicy : public PolicyFunction{


    std::unique_ptr<BoosterHandle> booster;

    bool ready_predict=false;

    //training data
    std::vector<std::pair<std::vector<float>, float>> data;

public:

    XGBoostPolicy();

    ~XGBoostPolicy() override;

    void set_training_data(std::vector<std::pair<std::vector<float>, float>>& pairs) override {
        data = pairs;
    }

    bool train() override;

    bool can_predict() override {return ready_predict;}

    std::vector<float> predict(std::vector<std::vector<float>>& inputs) override;

    [[nodiscard]] std::string get_name() const override {return "XGBoostPolicy";}
};


#endif //FASTPHYSER_POLICY_H
