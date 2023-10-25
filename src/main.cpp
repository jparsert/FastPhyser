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


std::map<std::string, std::function<std::optional<experiment_statistics>(std::vector<std::string>&, std::vector<std::string>& test_set, po::variables_map&)>> strategies {
    {"debug", debug},
    {"default", default_simple_enumerative_search},
    {"simple_probabilistic", simple_probabilistic_search},
    {"balancedBDMC", balancedBDMC_complete},
    {"balancedBDMC_policy", balancedBDMC_policy_only},
    {"balancedBDMC_value", balancedBDMC_value_only},
    {"AlphaZero_complete" , AlphaZero_complete},
    {"AlphaZeroPrefetch_complete" , AlphaZeroPrefetch_complete},
    {"AlphaZero_Circular", AlphaZero_Circular},
    {"AlphaZero_Circular_value_only", AlphaZero_Circular_value_only},
    {"AlphaZero_Circular_policy_only", AlphaZero_Circular_policy_only},

};


std::optional<po::variables_map> parse_cmd_args(int argc, char* argv[])  {
    po::options_description desc("Allowed options");
    desc.add_options()
            ("help,h", "produce help message")
            ("seed",  po::value<int>(), "Set a Seed for RNG functions.")
            ("input,I", po::value<std::vector<std::string>>()->multitoken()->required(), "Directory containing training problem files.")
            ("test-set", po::value<std::vector<std::string>>()->multitoken(), "Directory containing testing problem files.")
            ("result-file", po::value<std::string>(), "File where to print experimental results in JSON format.")
            ("probability-file", po::value<std::string>(), "File containing the probabilities for the grammar rules.")
            ("RL-its", po::value<int>()->default_value(RL_ITERATIONS), "Number of Reinforcement Learning Iterations.")
            ("strategy", po::value<std::string>(), "Name of strategy to use")
            ("timeout", po::value<int>()->default_value(DEFAULT_SEARCH_TIMEOUT.count()), "Timeout set to search function.")
            ("num-parallel", po::value<int>()->default_value(0), "Number of parallel workers. The default is half the system cores. Note that many parallel workers are memory intensive and may lead to forced process termination.")
            ("save-models", po::value<std::string>(), "If models should be saved, the argument is the directory they will be saved to. Named after iterations")
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
    if(problems.empty()) {
        std::cerr << "Could not find any files with \".sl\" ending in: " << std::endl;
        for (const auto& x : vm["input"].as<std::vector<std::string>>()) {
            std::cerr << "\t" << x << std::endl;
        }
        return -1;
    }

    // collect all test files
    std::vector<std::string> test_set_problems;
    if (vm.count("test-set")) {
        test_set_problems = files_with_suffix_in_dirs(vm["test-set"].as<std::vector<std::string>>(), ".sl");
    }

    std::string strategy = vm.count("strategy") ? vm["strategy"].as<std::string>() : "default";
    // run experiments with the correct strategy
    if (! strategies.contains(strategy)){
        std::cerr << "Strategy " << strategy << " not found." << std::endl;
        std::cerr << "Known strategies are:" << std::endl;
        for (const auto& x: strategies) {
            std::cerr << "\t" << x.first << std::endl;
        }
        return -1;
    }
    std::optional<experiment_statistics> results = strategies[strategy](problems, test_set_problems, vm);

    if (results) {
        // Print the results in JSON
        auto args = std::vector<std::string>{argv, argv + argc};

        auto dash_fold = [](std::string a, std::string b) {
            return std::move(a) + ' ' + std::move(b);
        };

        std::string run_cmd = std::accumulate(std::next(args.begin()), args.end(),
                                              args[0], // start with first element
                                              dash_fold);

        results->add_run_command(run_cmd);

        std::string result_file;
        if (vm.count("result-file")) {
            result_file = vm["result-file"].as<std::string>();
        } else {
            result_file = "experiment_results" + get_current_timestamp_as_string() + ".json";
        }
        results->print_to_file(result_file);
    }

    return 0;
}
