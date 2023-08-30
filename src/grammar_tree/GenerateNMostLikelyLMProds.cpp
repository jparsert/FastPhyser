//
// Created by julian on 30.08.23.
//

#include "GenerateNMostLikelyLMProds.h"
#include "ast.h"
#include "../exceptions/exceptions.h"
#include "AstPrinter.h"

std::any GenerateNMostLikelyLMProds::visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun)  {

    if (!synthFun.get_grammar()) {
        throw ForbiddenState("The parsed problem does not have a grammar. We do not support default grammars for now.");
    }
    synthFun.get_grammar()->accept(*this);
    std::vector<Sy2CPP::DefineFunCmd> sols;
    sols.emplace_back(synthFun.get_identifier(),synthFun.get_arguments(),synthFun.get_sort(),this->root->copy());
    this->solution = std::make_optional<std::vector<Sy2CPP::DefineFunCmd>>(sols);

    return {};
}

std::any GenerateNMostLikelyLMProds::visitGrammarDef(Sy2CPP::GrammarDef &grammarDef)  {
    Sy2CPP::EitherIdentifier id = grammarDef.get_non_terminals()[0].first;
    root = std::static_pointer_cast<Sy2CPP::Term>(std::make_shared<Sy2CPP::IdentifierTerm>(id));

    this->non_terminal_counter = CountNonTerminals(grammarDef.get_non_terminals());

    std::vector<std::pair<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>>> rules;

    for (auto& rule : grammarDef.get_rules()) {
        auto res = std::any_cast<std::pair<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>>>(rule.accept(*this));
        rules.push_back(res);
    }
    // add probabilities

    size_t i = 0;
    for (auto& x : rules) {
        std::vector<std::pair<int, Sy2CPP::TermPtr>> rh_sides;
        for(auto& rule: x.second) {
            rh_sides.emplace_back(probabilities[i], rule);
            std::sort(rh_sides.rbegin(), rh_sides.rend()); // Sort is important as we will use this to get the most likely elements
            ++i;
        }
        rules_and_probs.insert({x.first, rh_sides});
    }

    if (grammarDef.get_non_terminals().empty()) {
        throw ForbiddenState("List of non terminals in Grammar definition cannot be empty.");
    }
    if (rules.empty()) {
        throw ForbiddenState("List of grammar rules cannot be empty.");
    }
    return {};
}

std::any GenerateNMostLikelyLMProds::visitGroupedRuleList(Sy2CPP::GroupedRuleList &groupedRuleList)  {
    Sy2CPP::EitherIdentifier lhs = groupedRuleList.get_identifier();
    std::vector<Sy2CPP::TermPtr> rhs;
    for(const auto &term : groupedRuleList.get_terms()) {
        rhs.push_back(term->copy());
    }
    std::pair<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>> res(lhs, rhs);
    return {res};
}

std::shared_ptr<GenerateNMostLikelyLMProds>
GenerateNMostLikelyLMProds::build(Sy2CPP::Problem &problem, Sy2CPP::SymbolTable &symbolT, const std::vector<int>& probs, int N) {
    auto generator = std::make_shared<GenerateNMostLikelyLMProds>(probs, N);
    problem.accept(*generator);
    /*
    for (auto x : generator->rules_and_probs) {
        std::cout << Sy2CPP::to_string(x.first) << std::endl;
        for (auto y : x.second) {
            std::cout << "  " <<y.first << Sy2CPP::AstToString::to_string(*y.second) << std::endl;
        }
    }
    */
    return generator;
}

std::any GenerateNMostLikelyLMProds::visitNumeral(Sy2CPP::Numeral &numeral) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateNMostLikelyLMProds::visitDecimal(Sy2CPP::Decimal &decimal) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateNMostLikelyLMProds::visitBoolConst(Sy2CPP::BoolConst &boolConst) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateNMostLikelyLMProds::visitHexConst(Sy2CPP::HexConst &hex) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateNMostLikelyLMProds::visitBinConst(Sy2CPP::BinConst &bin) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateNMostLikelyLMProds::visitStringConst(Sy2CPP::StringConst &s) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateNMostLikelyLMProds::visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) {
    if (this->rules_and_probs.contains(term.get_identifier())) {
        std::vector<Sy2CPP::TermPtr> new_sub_terms;

        // the right-hand sides for the identifier
        const std::vector<std::pair<int, Sy2CPP::TermPtr>>& rh_sides = rules_and_probs.at(term.get_identifier());

        // Check that we get the first N elements, if N is LEQ than to size then get all elements.
        auto new_n = N >= rh_sides.size() ? rh_sides.size() - 1 : N;

        std::vector<std::pair<int, Sy2CPP::TermPtr>> N_most_liekly(rh_sides.begin(), rh_sides.begin() + static_cast<long>(new_n));

        for(const std::pair<int, Sy2CPP::TermPtr>& t : N_most_liekly) {
            // For now we don't care about the actual probablities. The comparative probability is encoded in the sorting of the rule list.
            new_sub_terms.push_back(std::move(t.second->copy()));
        }
        return new_sub_terms;
    } else {
        return std::vector<Sy2CPP::TermPtr>();
    }
}

std::any GenerateNMostLikelyLMProds::visitApplicationTerm(Sy2CPP::ApplicationTerm &application) {
    std::vector<Sy2CPP::TermPtr> args = application.get_arguments();
    Sy2CPP::EitherIdentifier id = application.get_identifier();
    std::vector<Sy2CPP::TermPtr> results;

    for (int i = 0; i < args.size(); ++i) {
        //recurse into arguments
        auto new_subterms = std::any_cast<std::vector<Sy2CPP::TermPtr>>(args[i]->accept(*this));
        if (!new_subterms.empty()){ // This means that while recursing we found new terms (i.e. we encountered non-temrinal)
            for (auto& new_arg : new_subterms) {
                std::vector<Sy2CPP::TermPtr> new_arg_list;
                for (int j = 0; j < args.size(); ++j) {
                    if (i == j) {
                        new_arg_list.push_back(std::move(new_arg));
                    } else {
                        new_arg_list.push_back(std::move(args[j]->copy()));
                    }
                }
                results.emplace_back(
                        std::static_pointer_cast<Sy2CPP::Term>(
                                std::make_shared<Sy2CPP::ApplicationTerm>(id,new_arg_list)));
            }
            return results; // Since we produce leftmost products we can finish interation here.
        }
    }

    return results;
}

std::vector<Sy2CPP::TermPtr> GenerateNMostLikelyLMProds::generate_n_most_likely_LM_products(Sy2CPP::Term *term) {
    return std::any_cast<std::vector<Sy2CPP::TermPtr>>(term->accept(*this));

}

Sy2CPP::Term *GenerateNMostLikelyLMProds::get_root() {
    return root.get();
}

Sy2CPP::SyGuSSolution GenerateNMostLikelyLMProds::get_term_as_solution(Sy2CPP::Term* term) {
    this->solution.value()[0].set_term(term->copy());
    return solution;
}

bool GenerateNMostLikelyLMProds::is_leaf(Sy2CPP::Term *term) {
    return this->non_terminal_counter.count_non_terminals(term) == 0;
}

