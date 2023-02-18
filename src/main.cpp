#include <iostream>


#include <filesystem>
#include "verification/smt_problem_builder.h"

#include "candidate_tree.h"
#include "search/BalancedBDMonteCarlo.h"
#include "utilities.h"
#include "DefaultLearningManager.h"
#include <boost/program_options.hpp>


namespace po = boost::program_options;


int main(int argc, char* argv[]) {


    po::options_description desc("Allowed options");
    desc.add_options()
            ("help", "produce help message")
            ("input,I", po::value<std::vector<std::string>>()->multitoken(), "Directory containing problem files.")
            ;

    po::variables_map vm;
    po::store(po::parse_command_line(argc, argv, desc), vm);
    po::notify(vm);

    if (vm.count("help")) {
        std::cout << desc << "\n";
        return 1;
    }

    std::vector<std::string> problems = files_with_suffix_in_dirs(vm["input"].as<std::vector<std::string>>(), ".sl");

    std::unique_ptr<AbstractFeatureGenerator> term_walk = std::make_unique<Size2TermWalk>();
    std::unique_ptr<PolicyFunction> policy = std::make_unique<XGBoostPolicy>();
    std::unique_ptr<ValueFunction> value = std::make_unique<XGBoostValue>();


    DefaultLearningManager<BalancedBDMonteCarlo> learner(term_walk.get(), policy.get(), value.get());
    learner.start(problems);

    return 0;

}
