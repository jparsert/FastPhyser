//
// Created by julian on 28.02.23.
//

#include "strategies.h"

#include "search/BalancedBDMonteCarlo.h"
#include "search/AZ_Prefetch.h"

#include "ParallelLearningManager.h"
#include "search/AlphaZero.h"
#include "statistics.h"
#include "DataCollector.h"

#include <boost/program_options.hpp>


experiment_statistics balancedBDMC_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}


experiment_statistics balancedBDMC_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), nullptr, policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

experiment_statistics balancedBDMC_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), nullptr, value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

experiment_statistics AlphaZero_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<AlphaZero> learner(term_walk.get(), policy.get(), value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

experiment_statistics AlphaZeroPrefetch_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts)
{
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<AZ_Prefetch> learner(term_walk.get(), policy.get(), value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}