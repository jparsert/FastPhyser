//
// Created by julian on 28.02.23.
//

#include "strategies.h"

#include "search/BalancedBDMonteCarlo.h"
#include <boost/program_options.hpp>
#include "ParallelLearningManager.h"
#include "search/AlphaZero.h"
#include "statistics.h"


experiment_statistics balancedBDMC_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), value.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}


experiment_statistics balancedBDMC_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), nullptr, opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

experiment_statistics balancedBDMC_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), nullptr, value.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

experiment_statistics AlphaZero_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();

    ParallelLearningManager<AlphaZero> learner(term_walk.get(), policy.get(), value.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}
