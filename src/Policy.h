//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_POLICY_H
#define FASTPHYSER_POLICY_H

#include <vector>

#include <xgboost/c_api.h>
#include <memory>

class PolicyFunction {

public:

    virtual ~PolicyFunction() = default;

    virtual bool train(const std::vector<std::pair<std::vector<float>, float>>& pairs) = 0;

    virtual bool can_predict() = 0;

    virtual std::vector<float> predict(const std::vector<std::vector<float>>& inputs) = 0;

    [[nodiscard]] virtual std::string get_name() const = 0;
};


class XGBoostPolicy : public PolicyFunction{


    std::unique_ptr<BoosterHandle> booster;

    bool ready_predict=false;

public:

    XGBoostPolicy();

    ~XGBoostPolicy() override;



    bool train(const std::vector<std::pair<std::vector<float>, float>>& data) override;

    bool can_predict() override {return ready_predict;}

    std::vector<float> predict(const std::vector<std::vector<float>>& inputs) override;

    [[nodiscard]] std::string get_name() const override {return "XGBoostPolicy";}
};


#endif //FASTPHYSER_POLICY_H
