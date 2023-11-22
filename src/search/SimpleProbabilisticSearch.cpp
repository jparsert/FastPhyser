//
// Created by Yixuan on 15.11.23.
//

#include "SimpleProbabilisticSearch.h"
#include "AstPrinter.h"

Sy2CPP::SyGuSSolution SimpleProbabilisticSearch::start_search() {

    for (int j = 0; j < 20000000; j++) {
        // std::cout << "Iteration: " << j << std::endl;
        Sy2CPP::Term* root = term_generator->get_root();
        auto current_iteration = term_generator->generate_n_most_likely_LM_products(root);
        std::vector<Sy2CPP::TermPtr> next_iteration;
        for (int i = 0; i < 30; ++i) {
            for (auto& term : current_iteration) {
                std::cout << Sy2CPP::AstToString::to_string(*term) << std::endl;
                //std::cout << "verifier->get_synth_funs()[0]: " << verifier->get_synth_funs()[0] << std::endl;
                if (term_generator->is_leaf(term.get())) {
                    z3::check_result res = verifier->check_candidate(verifier->get_synth_funs()[0], term.get());
                    if (res == z3::check_result::unsat) {
                        return { term_generator->get_term_as_solution(term.get()) };
                    }
                }
                else {
                    concat(next_iteration, term_generator->generate_n_most_likely_LM_products(term.get()));
                }
            }
            current_iteration = std::move(next_iteration);
            next_iteration.clear();
        }
    }
    return std::nullopt;
}