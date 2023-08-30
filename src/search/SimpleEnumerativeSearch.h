//
// Created by julian on 28.08.23.
//

#ifndef FASTPHYSER_SIMPLEENUMERATIVESEARCH_H
#define FASTPHYSER_SIMPLEENUMERATIVESEARCH_H


#include <string>
#include <memory>
#include <chrono>
#include <utility>

#include <boost/program_options/variables_map.hpp>

#include "../grammar_tree/candidate_tree.h"
#include "../verification/smt_problem_builder.h"

#include "Sy2CPP.h"


class SimpleEnumerativeSearch {

    private:
        std::string problem;
        std::shared_ptr<Sy2CPP::Problem> ast;
        std::shared_ptr<Sy2CPP::SymbolTable> symbol_table;

        std::shared_ptr<SyGuSZ3SolverReprBuilder> verifier;
        std::shared_ptr<CandidateTreeGenerator> tree_generator;


        //maximum search time
        //std::chrono::seconds timeout;


public:

    explicit SimpleEnumerativeSearch(std::string  path,
                       const boost::program_options::variables_map& vm) :
            problem{std::move(path)}
    {
        auto pair = Sy2CPP::get_ast_and_symbol_table_from_file(problem);
        ast = pair.first;
        symbol_table = pair.second;

        verifier = SyGuSZ3SolverReprBuilder::build(*ast, *symbol_table);
        tree_generator = CandidateTreeGenerator::build(*ast, *symbol_table);

    }

    Sy2CPP::SyGuSSolution start_search();


};


#endif //FASTPHYSER_SIMPLEENUMERATIVESEARCH_H
