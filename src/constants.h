//
// Created by julian on 09.02.23.
//

#ifndef FASTPHYSER_CONSTANTS_H
#define FASTPHYSER_CONSTANTS_H


#include "exceptions/exceptions.h"
#include <xgboost/c_api.h>


// Monte Carlo Search
constexpr int NUM_BIG_STEPS = 20;
constexpr int NUM_SMALL_STEPS_BREADTH = 200;
constexpr int NUM_SMALL_STEPS_DEPTH = 20;

// Feature vector dimension
constexpr int NUM_FEATURES = 2000;


constexpr void safe_xgboost(int call) {
    if (call != 0) {
        throw XGBoostException("Error in :" + std::string(XGBGetLastError()));
    }
}
#endif //FASTPHYSER_CONSTANTS_H
