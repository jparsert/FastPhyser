//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_VALUE_H
#define FASTPHYSER_VALUE_H

#include <vector>
#include <xgboost/c_api.h>
#include <optional>

class ValueFunction {

public:

    virtual ~ValueFunction() = default;

    virtual void set_training_data(std::vector<std::pair<std::vector<float>, float>>& pairs) = 0;

    virtual bool train() = 0;

    virtual bool can_predict() = 0;

    virtual std::vector<float> predict(std::vector<std::vector<float>>& inputs) = 0;


};


class XGBoostValue : public ValueFunction {

    std::optional<BoosterHandle> booster=std::nullopt;

    bool ready_predict=false;

    //training data
    std::vector<std::pair<std::vector<float>, float>> data;


public:

    XGBoostValue();

    ~XGBoostValue() override;

    void set_training_data(std::vector<std::pair<std::vector<float>, float>>& pairs) override{
        this->data = pairs;
    }

    bool train() override;

    bool can_predict() override{return ready_predict;}

    std::vector<float> predict(std::vector<std::vector<float>>& inputs) override;


};



#endif //FASTPHYSER_VALUE_H
