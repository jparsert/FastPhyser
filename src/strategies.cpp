//
// Created by julian on 28.02.23.
//

#include "strategies.h"

#include "search/rl_search/BalancedBDMonteCarlo.h"
#include "search/rl_search/AZ_Prefetch.h"

#include "reinforcement_learning/ParallelLearningManager.h"
#include "search/rl_search/AlphaZero.h"
#include "reinforcement_learning/statistics.h"
#include "reinforcement_learning/DataCollector.h"

#include <boost/program_options.hpp>

#include "search/SimpleEnumerativeSearch.h"
#include "search/SimpleProbabilisticSearch.h"


std::optional<experiment_statistics> debug(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    for (const auto& prob : problems){
        try {
            AlphaZero<Size2TermWalk> search(prob, policy.get(), value.get(),
                                            static_cast<std::chrono::seconds>(opts["timeout"].as<int>()), opts, 1);
        } catch (Sy2CPP::TypingError& e) {
            std::cout << "Error on: " << prob << std::endl;
            std::cout << e.what() << std::endl;
        }

    }

    return std::nullopt;
}

std::optional<experiment_statistics> default_simple_enumerative_search(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {

    for (const auto& prob : problems){
        SimpleEnumerativeSearch search(prob, opts);
        Sy2CPP::SyGuSSolution sol = search.start_search();
        if (sol.has_value()) {
            std::cout << "Found the following solution to file: " << prob << std::endl;
            std::cout << Sy2CPP::to_string(sol);
        } else {
            std::cout << prob <<": UNKNOWN" << std::endl;
        }

    }

    return std::nullopt;
}



std::optional<experiment_statistics> simple_probabilistic_search(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts)
{
    if (problems.size() != 1) {
        std::cout << "Too few or too many problems. You need to specify exactly one problem." << std::endl;
        return std::nullopt;
    }

    SimpleProbabilisticSearch search(problems[0], opts); /// problems[0] as we only consider 1 problem as input for now
    Sy2CPP::SyGuSSolution sol = search.start_search();

    if (sol.has_value()) {
        std::cout << "Found the following solution to file: " << problems[0] << std::endl;
        std::cout << Sy2CPP::to_string(sol);
    } else {
        std::cout << problems[0] <<": UNKNOWN" << std::endl;
    }

    return std::nullopt;

}


std::optional<experiment_statistics> balancedBDMC_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<BalancedBDMonteCarlo<Size2TermWalk>> learner(policy.get(), value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

std::optional<experiment_statistics> balancedBDMC_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<BalancedBDMonteCarlo<Size2TermWalk>> learner(policy.get(), nullptr, policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

std::optional<experiment_statistics> balancedBDMC_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<BalancedBDMonteCarlo<Size2TermWalk>> learner(nullptr, value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

std::optional<experiment_statistics> AlphaZero_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<AlphaZero<Size2TermWalk>> learner(policy.get(), value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

std::optional<experiment_statistics> AlphaZero_Circular(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    CircularDataCollector policy_data_co(POLICY_CIRCULAR_BUFFER);
    CircularDataCollector value_data_co(VALUE_CIRCULAR_BUFFER);

    ParallelLearningManager<AlphaZero<Size2TermWalk>> learner(policy.get(), value.get(), &policy_data_co, &value_data_co, opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

std::optional<experiment_statistics> AlphaZero_Circular_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    CircularDataCollector policy_data_co(POLICY_CIRCULAR_BUFFER);
    CircularDataCollector value_data_co(VALUE_CIRCULAR_BUFFER);

    ParallelLearningManager<AlphaZero<Size2TermWalk>> learner(nullptr, value.get(), &policy_data_co, &value_data_co, opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}

std::optional<experiment_statistics> AlphaZero_Circular_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts) {
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    CircularDataCollector policy_data_co(POLICY_CIRCULAR_BUFFER);
    CircularDataCollector value_data_co(VALUE_CIRCULAR_BUFFER);

    ParallelLearningManager<AlphaZero<Size2TermWalk>> learner(policy.get(), nullptr, &policy_data_co, &value_data_co, opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}


std::optional<experiment_statistics> AlphaZeroPrefetch_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts)
{
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();
    std::unique_ptr<DataCollector> policy_data_co = std::make_unique<DefaultDataCollector>();
    std::unique_ptr<DataCollector> value_data_co = std::make_unique<DefaultDataCollector>();

    ParallelLearningManager<AZ_Prefetch<Size2TermWalk>> learner(policy.get(), value.get(), policy_data_co.get(), value_data_co.get(), opts);
    auto stats = learner.start(problems, test_set);
    return stats;
}