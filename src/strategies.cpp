//
// Created by julian on 28.02.23.
//

#include "strategies.h"

#include <filesystem>
#include "verification/smt_problem_builder.h"

#include "candidate_tree.h"
#include "search/BalancedBDMonteCarlo.h"
#include "utilities.h"
#include "DefaultLearningManager.h"
#include <boost/program_options.hpp>

#include "ParallelLearningManager.h"
#include "constants.h"

#include "strategies.h"

void balancedBDMC_complete(std::vector<std::string>& problems, po::variables_map& opts) {

    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), value.get());
    learner.start(problems);
}

void balancedBDMC_policy_only(std::vector<std::string>& problems, po::variables_map& opts) {
    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();

    ParallelLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), nullptr);
    learner.start(problems);
}