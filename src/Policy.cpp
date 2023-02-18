//
// Created by julian on 13.02.23.
//

#include "Policy.h"
#include <xgboost/c_api.h>
#include "constants.h"
#include <string>
#include "exceptions/exceptions.h"
#include <iostream>

XGBoostPolicy::XGBoostPolicy() = default;

XGBoostPolicy::~XGBoostPolicy() {
    if (booster) {
        safe_xgboost(XGBoosterFree(*booster));
    }
}

// should probably rewrite to use vector.data()
bool XGBoostPolicy::train() {
    // no training data
    if (data.empty()) {
        return false;
    }
    this->ready_predict = false;

    std::size_t rows = data.size();
    std::size_t cols = data.at(0).first.size();

    std::vector<float> data_matrix;

    float data_labels[rows];


    //fill data-set
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            if (data[row].first.size() != cols) {
                throw std::exception();
            }
            data_matrix.push_back(data[row].first[col]);
        }
        data_labels[row] = data[row].second;
        std::cout << data[row].second;
    }
    std::cout << std::endl;

    // create data
    DMatrixHandle training_dmatrix;
    safe_xgboost(XGDMatrixCreateFromMat(data_matrix.data(), rows, cols, -1, &training_dmatrix));
    safe_xgboost(XGDMatrixSetFloatInfo(training_dmatrix, "label", data_labels, rows));

    //free potential old booster

    //free potential old booster
    if (booster) {
        safe_xgboost(XGBoosterFree(*booster));
        booster = std::make_unique<BoosterHandle>();
    } else {
        booster = std::make_unique<BoosterHandle>();
    }

    // Create new and set params
    safe_xgboost(XGBoosterCreate(&training_dmatrix, 1, booster.get()));
    safe_xgboost(XGBoosterSetParam(*booster, "booster", "gbtree"));
    //XGBoosterSetParam(booster, "objective", "reg:linear");
    safe_xgboost(XGBoosterSetParam(*booster, "max_depth", "15"));
    //XGBoosterSetParam(booster, "seed", "0");
    //XGBoosterSetParam(booster, "eta", "0.1");
    //XGBoosterSetParam(booster, "min_child_weight", "1");
    //XGBoosterSetParam(booster, "subsample", "0.5");
    //XGBoosterSetParam(booster, "colsample_bytree", "1");
    //XGBoosterSetParam(h_booster, "num_parallel_tree", "1");


    // train for n iterations
    for (int iter = 0; iter < 200; ++iter) {
        safe_xgboost(XGBoosterUpdateOneIter(*booster, iter, training_dmatrix));
    }

    // free resources
    safe_xgboost(XGDMatrixFree(training_dmatrix));
    this->ready_predict = true;
    return true;

}

std::vector<float> XGBoostPolicy::predict(std::vector<std::vector<float>> &inputs) {
    if (inputs.empty()) {
        return {};
    }
    std::size_t rows = inputs.size();
    std::size_t cols = inputs[0].size();


    //create dmatrix features
    float feat[rows][cols];
    for (int row = 0; row < rows; row++) {
        for (int col = 0; col < cols; col++) {
            feat[row][col] = inputs[row][col];
        }
    }
    DMatrixHandle pred_vecs;
    safe_xgboost(XGDMatrixCreateFromMat(reinterpret_cast<float*>(feat), rows, cols, -1, &pred_vecs));

    //prediction
    bst_ulong out_len;
    const float *f;
    safe_xgboost(XGBoosterPredict(*booster, pred_vecs, 0, 0, false, &out_len, &f));
    if (out_len != rows) {
        throw XGBoostException("Predicted lengths does not match input.");
    }

    std::vector<float> res(f, f+out_len);
    safe_xgboost(XGDMatrixFree(pred_vecs));

    return res;
}
