//
// Created by julian on 28.02.23.
//

#ifndef FASTPHYSER_STRATEGIES_H
#define FASTPHYSER_STRATEGIES_H

#include <vector>
#include <string>

#include <boost/program_options.hpp>

namespace po = boost::program_options;

/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST policy and value functions and Siz2TermWalk
 *
 * */
void balancedBDMC_complete(std::vector<std::string>& problems, po::variables_map& opts);


/*
 *  Runs Balanced Breadth-Depths Monte Carlo Search with XGBOOST policy and Siz2TermWalk
 *  NO Value Function!!!
 *
 * */
void balancedBDMC_policy_only(std::vector<std::string>& problems, po::variables_map& opts);

#endif //FASTPHYSER_STRATEGIES_H
