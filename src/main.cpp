#include <iostream>

#include "utilities.h"
#include <boost/program_options.hpp>

#include "strategies.h"

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
    balancedBDMC_policy_only(problems, vm);

    return 0;

}
