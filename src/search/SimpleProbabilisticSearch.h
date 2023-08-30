//
// Created by julian on 30.08.23.
//

#ifndef FASTPHYSER_SIMPLEPROBABILISTICSEARCH_H
#define FASTPHYSER_SIMPLEPROBABILISTICSEARCH_H

#include <string>
#include <memory>
#include <chrono>
#include <utility>

#include <boost/program_options/variables_map.hpp>

#include "../grammar_tree/candidate_tree.h"
#include "../verification/smt_problem_builder.h"

#include "Sy2CPP.h"
#include "../grammar_tree/GenerateNMostLikelyLMProds.h"
#include "../exceptions/exceptions.h"
#include "../utilities.h"

class SimpleProbabilisticSearch {
private:
    std::string problem;
    std::shared_ptr<Sy2CPP::Problem> ast;
    std::shared_ptr<Sy2CPP::SymbolTable> symbol_table;

    std::shared_ptr<SyGuSZ3SolverReprBuilder> verifier;

    std::shared_ptr<GenerateNMostLikelyLMProds> term_generator;


    //maximum search time
    //std::chrono::seconds timeout;


public:

    explicit SimpleProbabilisticSearch(std::string  path,
    const boost::program_options::variables_map& vm) :
    problem{std::move(path)}
    {
        auto pair = Sy2CPP::get_ast_and_symbol_table_from_file(problem);
        ast = pair.first;
        symbol_table = pair.second;

        verifier = SyGuSZ3SolverReprBuilder::build(*ast, *symbol_table);

        std::vector<int> probabilities;
        if (!vm.count("probability-file")) {
            std::cout << "No file containing grammar probabilities was given" << std::endl;
            throw MissingProbabilitiesFile("Probabilities file was not given. However this is required for the given strategy.");
        }
        probabilities = read_lines_in_file_as_int(vm["probability-file"].as<std::string>());

        term_generator = GenerateNMostLikelyLMProds::build(*ast, *symbol_table, probabilities);

    }

    Sy2CPP::SyGuSSolution start_search();


};

#endif //FASTPHYSER_SIMPLEPROBABILISTICSEARCH_H
