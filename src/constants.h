//
// Created by julian on 09.02.23.
//

#ifndef FASTPHYSER_CONSTANTS_H
#define FASTPHYSER_CONSTANTS_H


#include "exceptions/exceptions.h"
#include <xgboost/c_api.h>
#include <chrono>

// Monte Carlo Search
constexpr int NUM_BIG_STEPS = 20;
constexpr int NUM_SMALL_STEPS_BREADTH = 500;
constexpr int NUM_SMALL_STEPS_DEPTH = 20;

constexpr int MCTS_SIMULATIONS = 2500;

constexpr int RL_ITERATIONS = 20;

// Feature vector dimension
constexpr int NUM_FEATURES = 2000;

//timings
constexpr std::chrono::seconds SEARCH_TIMEOUT(10);


constexpr void safe_xgboost(int call) {
    if (call != 0) {
        throw XGBoostException("Error in :" + std::string(XGBGetLastError()));
    }
}


#ifndef GIT_COMMIT_HASH
#define GIT_COMMIT_HASH "UNKNOWN"
#endif

// needs newer version of gcc
//constexpr std::string get_compiled_git_hash() {
//    return GIT_COMMIT_HASH;
//}


#endif //FASTPHYSER_CONSTANTS_H
