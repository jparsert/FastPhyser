//
// Created by julian on 28.02.23.
//

#ifndef FASTPHYSER_STRATEGIES_H
#define FASTPHYSER_STRATEGIES_H

#include <vector>
#include <string>

#include <boost/program_options.hpp>
#include "reinforcement_learning/statistics.h"

namespace po = boost::program_options;


/**
 * To do simple implementations to understand and work with the codebase, start here
 * @return
 */
std::optional<experiment_statistics> debug(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/**
 * To do simple implementations to understand and work with the codebase, start here
 * @return
 */
std::optional<experiment_statistics> default_simple_enumerative_search(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/**
 * Default probabilistic search. It is important that opts also contains a file with probabilties
 * @return
 */
std::optional<experiment_statistics> simple_probabilistic_search(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);



/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST policy and value functions and Siz2TermWalk
 *
 * */
std::optional<experiment_statistics> balancedBDMC_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);


/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST policy and Siz2TermWalk
 *  NO Value Function!!!
 *
 * */
std::optional<experiment_statistics> balancedBDMC_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST value and Siz2TermWalk
 *  NO policy Function!!!
 *
 * */
std::optional<experiment_statistics> balancedBDMC_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs AlphaZero Carlo Search with XGBOOST value/policy and Siz2TermWalk
 *
 * */
std::optional<experiment_statistics> AlphaZero_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs AlphaZero Carlo Search with XGBOOST value/policy and Siz2TermWalk and circular buffer for training data retention
 *
 * */
std::optional<experiment_statistics> AlphaZero_Circular(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs AlphaZero Carlo Search with XGBOOST value/policy and Siz2TermWalk and circular buffer for training data retention
 *
 * */
std::optional<experiment_statistics> AlphaZero_Circular_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs AlphaZero Carlo Search with XGBOOST value/policy and Siz2TermWalk and circular buffer for training data retention
 *
 * */
std::optional<experiment_statistics> AlphaZero_Circular_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);


/*
 *  Runs AlphaZero Carlo Search and Prefetching of sibling nodes with XGBOOST value/policy and Siz2TermWalk
 *
 * */
std::optional<experiment_statistics> AlphaZeroPrefetch_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);




#endif //FASTPHYSER_STRATEGIES_H
