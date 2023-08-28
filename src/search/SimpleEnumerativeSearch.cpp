//
// Created by julian on 28.08.23.
//

#include "SimpleEnumerativeSearch.h"
#include "../utilities.h"

Sy2CPP::SyGuSSolution SimpleEnumerativeSearch::start_search() {
    Sy2CPP::Term* root = tree_generator->get_root();
    auto current_iteration = tree_generator->generate_leftmost_product_terms(root);
    std::vector<Sy2CPP::TermPtr> next_iteration;

    for (int i = 0; i < 10; ++i) {
        for (auto& term : current_iteration) {
            if (tree_generator->is_leaf(term.get())) {
                z3::check_result res = verifier->check_candidate(verifier->get_synth_funs()[0], term.get());
                if (res == z3::check_result::unsat) {
                    return {tree_generator->get_term_as_solution(term.get())};
                }
            } else {
                concat(next_iteration, tree_generator->generate_leftmost_product_terms(term.get()));
            }
        }
        current_iteration = std::move(next_iteration);
        next_iteration.clear();
    }


    return std::nullopt;
}
