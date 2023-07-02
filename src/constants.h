//
// Created by julian on 09.02.23.
//

#ifndef FASTPHYSER_CONSTANTS_H
#define FASTPHYSER_CONSTANTS_H


#include "exceptions/exceptions.h"
#include <xgboost/c_api.h>
#include <chrono>

// Boosting Hyperparameters
constexpr int VALUE_MAX_DEPTH = 20;
constexpr int POLICY_MAX_DEPTH = 25; // larger as the feature vector is larger

constexpr float VALUE_SUB_SAMPLE = 1; // default 1
constexpr float POLICY_SUB_SAMPLE = 1; // default 1

constexpr float VALUE_MIN_CHILD_WEIGHT = 1; // default 1
constexpr float POLICY_MIN_CHILD_WEIGHT = 1; // default 1

constexpr int VALUE_MAX_ITERATIONS = 200;
constexpr int POLICY_MAX_ITERATIONS = 200;


// Ciruclar buffers for training data
constexpr int VALUE_CIRCULAR_BUFFER = 3;
constexpr int POLICY_CIRCULAR_BUFFER = 3;



//constexpr std::string_view POLICY_ETA = "0.3";  use default
//constexpr std::string_view VALUE_ETA = "0.3";   use default


// Monte Carlo Search
constexpr int NUM_BIG_STEPS = 20;
constexpr int NUM_SMALL_STEPS_BREADTH = 400;
constexpr int NUM_SMALL_STEPS_DEPTH = 12;

constexpr float ROLLOUT_DECAY_BASE = 0.95;

constexpr int MCTS_SIMULATIONS = 6000; // 2500

constexpr int RL_ITERATIONS = 10;

// Feature vector dimension
constexpr int NUM_FEATURES = 4093;

//constexpr int PREFETCH_DEPTH = 2;


//timings
constexpr std::chrono::seconds DEFAULT_SEARCH_TIMEOUT(240);


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
