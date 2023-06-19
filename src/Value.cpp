//
// Created by julian on 13.02.23.
//

#include "Value.h"
#include <iostream>
#include <xgboost/c_api.h>
#include "constants.h"


XGBoostValue::XGBoostValue() {
}

XGBoostValue::~XGBoostValue() {
    if (booster) {
        safe_xgboost(XGBoosterFree(*booster));
    }

}

// should probably rewrite to use vector.data()
bool XGBoostValue::train(const std::vector<std::pair<std::vector<float>, float>>& data, boost::program_options::variables_map& vm, int iteration) {
    // no training data
    if (data.empty()) {
        return false;
    }
    this->ready_predict = false;


    std::size_t rows = data.size();
    std::size_t cols = data[0].first.size();

    std::vector<float> data_matrix;

    std::vector<float> data_labels;

    //fill data-set
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            data_matrix.push_back(data[row].first[col]);
        }
        data_labels.push_back(data[row].second);
    }

    // create data
    DMatrixHandle training_dmatrix;
    safe_xgboost(XGDMatrixCreateFromMat(data_matrix.data(), rows, cols, -1, &training_dmatrix));
    safe_xgboost(XGDMatrixSetFloatInfo(training_dmatrix, "label", data_labels.data(), rows));

    //free potential old booster
    if (booster.has_value()) {
        safe_xgboost(XGBoosterFree(booster.value()));
        booster = std::make_optional<BoosterHandle>();
    } else {
        booster = std::make_optional<BoosterHandle>();
    }


    // Create new and set params
    safe_xgboost(XGBoosterCreate(&training_dmatrix, 1, &booster.value()));

    if (vm.count("seed")) {
        XGBoosterSetParam(*booster, "seed",  (std::to_string(vm["seed"].as<int>()) + std::to_string(iteration)).c_str());
    }
    safe_xgboost(XGBoosterSetParam(*booster, "booster", "gbtree"));
    //XGBoosterSetParam(booster, "objective", "reg:linear");
    safe_xgboost(XGBoosterSetParam(*booster, "max_depth", std::to_string(VALUE_MAX_DEPTH).c_str()));

    //XGBoosterSetParam(booster, "eta", "0.1");
    //XGBoosterSetParam(booster, "min_child_weight", "1");
    safe_xgboost(XGBoosterSetParam(*booster, "min_child_weight", std::to_string(VALUE_MIN_CHILD_WEIGHT).c_str()));
    safe_xgboost(XGBoosterSetParam(*booster, "subsample", std::to_string(VALUE_SUB_SAMPLE).c_str()));
    //XGBoosterSetParam(booster, "colsample_bytree", "1");
    //XGBoosterSetParam(h_booster, "num_parallel_tree", "1");

    std::cout << "TRAINING Value" << std::endl;

    // train for n iterations
    for (int iter = 0; iter < VALUE_MAX_ITERATIONS; ++iter) {
        safe_xgboost(XGBoosterUpdateOneIter(booster.value(), iter, training_dmatrix));
    }

    // free resources
    safe_xgboost(XGDMatrixFree(training_dmatrix));
    this->ready_predict = true;
    return true;

}

std::vector<float> XGBoostValue::predict(std::vector<std::vector<float>> &inputs) {
    if (inputs.empty()) {
        return {};
    }
    std::size_t rows = inputs.size();
    std::size_t cols = inputs[0].size();


    //create dmatrix features
    std::vector<float> feat;
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            feat.push_back(inputs[row][col]);
        }
    }

    return predict(feat, rows, cols);
}

std::vector<float> XGBoostValue::predict(const std::vector<float> &inputs, const size_t rows, const size_t cols) {
    DMatrixHandle pred_vecs;
    safe_xgboost(XGDMatrixCreateFromMat(inputs.data(), rows, cols, -1, &pred_vecs));

    //prediction
    bst_ulong out_len;
    const float *f;
    safe_xgboost(XGBoosterPredict(booster.value(), pred_vecs, 0, 0, false, &out_len, &f));
    if (out_len != rows) {
        throw XGBoostException("Predicted lengths does not match input.");
    }

    std::vector<float> res(f, f+out_len);
    safe_xgboost(XGDMatrixFree(pred_vecs));

    return res;
}


