//
// Created by julian on 28.02.23.
//

#ifndef FASTPHYSER_STRATEGIES_H
#define FASTPHYSER_STRATEGIES_H

#include <vector>
#include <string>

#include <boost/program_options.hpp>
#include "statistics.h"

namespace po = boost::program_options;

/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST policy and value functions and Siz2TermWalk
 *
 * */
experiment_statistics balancedBDMC_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);


/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST policy and Siz2TermWalk
 *  NO Value Function!!!
 *
 * */
experiment_statistics balancedBDMC_policy_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST value and Siz2TermWalk
 *  NO policy Function!!!
 *
 * */
experiment_statistics balancedBDMC_value_only(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs AlphaZero Carlo Search with XGBOOST value/policy and Siz2TermWalk
 *
 * */
experiment_statistics AlphaZero_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);

/*
 *  Runs AlphaZero Carlo Search with XGBOOST value/policy and Siz2TermWalk
 *
 * */
experiment_statistics AlphaZeroPrefetch_complete(std::vector<std::string>& problems, std::vector<std::string>& test_set, po::variables_map& opts);




#endif //FASTPHYSER_STRATEGIES_H
