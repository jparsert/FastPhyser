#include <iostream>

#include <boost/program_options.hpp>
#include <string>
#include <fstream>
#include <nlohmann/json.hpp>
#include <map>

#include "utilities.h"
#include "strategies.h"

using json = nlohmann::json;
namespace po = boost::program_options;


std::map<std::string, std::function<experiment_statistics(std::vector<std::string>&, po::variables_map&)>> strategies {
    {"default", balancedBDMC_complete},
    {"balancedBDMC", balancedBDMC_complete},
    {"balancedBDMC_policy", balancedBDMC_policy_only},
    {"balancedBDMC_value", balancedBDMC_value_only},
    {"AlphaZero_complete" , AlphaZero_complete}
};


std::optional<po::variables_map> parse_cmd_args(int argc, char* argv[])  {
    po::options_description desc("Allowed options");
    desc.add_options()
            ("help,h", "produce help message")
            ("input,I", po::value<std::vector<std::string>>()->multitoken()->required(), "Directory containing problem files.")
            ("result-file", po::value<std::string>(), "File where to print experimental results in JSON format.")
            ("RL-its", po::value<int>(), "Number of Reinforcement Learning Iterations.")
            ("strategy", po::value<std::string>(), "Name of strategy to use")
            ("timeout", po::value<int>()->default_value(DEFAULT_SEARCH_TIMEOUT.count()), "Timeout set to search function.")
            ("num-parallel", po::value<int>()->default_value(0), "Number of parallel workers. The default is half the system cores. Note that many parallel workers are memory intensive and may lead to forced process termination.")
            ;

    po::variables_map vm;
    try {
        po::store(po::parse_command_line(argc, argv, desc), vm);
        po::notify(vm);
    } catch (boost::program_options::required_option& e) {
        std::cout << "Missing required options" << std::endl;
        std::cout << desc << std::endl;
        return std::nullopt;
    }
    if (vm.count("help")) {
        std::cout << desc << std::endl;
        return std::nullopt;
    }

    return vm;
}


int main(int argc, char* argv[]) {


    auto arg_parsed = parse_cmd_args(argc, argv);
    if(!arg_parsed) {
        return 0;
    }
    po::variables_map vm = arg_parsed.value();

    // collect all problem files
    std::vector<std::string> problems = files_with_suffix_in_dirs(vm["input"].as<std::vector<std::string>>(), ".sl");

    std::string strategy = vm.count("strategy") ? vm["strategy"].as<std::string>() : "default";
    // run experiments with the correct strategy
    experiment_statistics results = strategies[strategy](problems, vm);


    // Print the results in JSON
    auto args = std::vector<std::string>{argv, argv+argc};
    auto run_cmd = std::accumulate(args.begin(), args.end(), std::string(""));
    results.add_run_command(run_cmd);

    std::string result_file;
    if (vm.count("result-file")) {
        result_file = vm["result-file"].as<std::string>();
    } else {
        result_file = "experiment_results" + get_current_timestamp_as_string() + ".json";
    }
    json js_res = to_json(results);
    std::ofstream res_file(result_file);
    res_file << std::setw(4) << js_res << std::endl;

    return 0;

}
