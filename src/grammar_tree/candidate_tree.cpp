//
// Created by julian on 01.02.23.
//

#include "candidate_tree.h"
#include "ast.h"
#include "../exceptions/exceptions.h"

std::shared_ptr<CandidateTreeGenerator>
CandidateTreeGenerator::build(Sy2CPP::Problem &problem, Sy2CPP::SymbolTable &symbolT) {
    auto generator = std::make_shared<CandidateTreeGenerator>();
    problem.accept(*generator);
    return generator;
}

std::any CandidateTreeGenerator::visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun)  {

    if (!synthFun.get_grammar()) {
        throw ForbiddenState("The parsed problem does not have a grammar. We do not support default grammars for now.");
    }
    synthFun.get_grammar()->accept(*this);
    std::vector<Sy2CPP::DefineFunCmd> sols;
    sols.emplace_back(synthFun.get_identifier(),synthFun.get_arguments(),synthFun.get_sort(),this->root->copy());
    this->solution = std::make_optional<std::vector<Sy2CPP::DefineFunCmd>>(sols);

    return {};
}

std::any CandidateTreeGenerator::visitGrammarDef(Sy2CPP::GrammarDef &grammarDef)  {
    Sy2CPP::EitherIdentifier id = grammarDef.get_non_terminals()[0].first;
    root = std::static_pointer_cast<Sy2CPP::Term>(std::make_shared<Sy2CPP::IdentifierTerm>(id));

    this->non_terminal_counter = CountNonTerminals(grammarDef.get_non_terminals());
    for (auto& rule : grammarDef.get_rules()) {
        rule.accept(*this);
    }
    this->left_most_product_generator = GenerateLeftMostProdukts(this->rules);
    if (grammarDef.get_non_terminals().empty()) {
        throw ForbiddenState("List of non terminals in Grammar definition cannot be empty.");
    }
    if (rules.empty()) {
        throw ForbiddenState("List of grammar rules cannot be empty.");
    }
    return {};
}

std::any CandidateTreeGenerator::visitGroupedRuleList(Sy2CPP::GroupedRuleList &groupedRuleList)  {
    Sy2CPP::EitherIdentifier lhs = groupedRuleList.get_identifier();
    std::vector<Sy2CPP::TermPtr> rhs;
    for(const auto &term : groupedRuleList.get_terms()) {
        rhs.push_back(term->copy());
    }
    if (rules.contains(lhs)) {
        throw ForbiddenState("Seems like there are two rules with the same LHS. This is not allowed.");
    }

    rules.insert({lhs, rhs});
    return {};
}

std::vector<Sy2CPP::TermPtr> CandidateTreeGenerator::generate_leftmost_product_terms(Sy2CPP::Term *term) {
    return this->left_most_product_generator.generate_leftmost_products(term);
}

int CandidateTreeGenerator::count_non_terminals(Sy2CPP::Term *term) {
    return this->non_terminal_counter.count_non_terminals(term);
}

Sy2CPP::Term *CandidateTreeGenerator::get_root() {
    return root.get();
}

bool CandidateTreeGenerator::is_leaf(Sy2CPP::Term *term) {
    //return is_leaf_visitor.is_leaf(term);
    return count_non_terminals(term) == 0;
}

Sy2CPP::SyGuSSolution CandidateTreeGenerator::get_term_as_solution(Sy2CPP::Term* term) {
    this->solution.value()[0].set_term(term->copy());
    return solution;
}

std::any CountNonTerminals::visitNumeral(Sy2CPP::Numeral &numeral) {
    return 0;
}

std::any CountNonTerminals::visitDecimal(Sy2CPP::Decimal &decimal) {
    return 0;

}

std::any CountNonTerminals::visitBoolConst(Sy2CPP::BoolConst &boolConst) {
    return 0;

}

std::any CountNonTerminals::visitBinConst(Sy2CPP::BinConst &bin) {
    return 0;

}

std::any CountNonTerminals::visitHexConst(Sy2CPP::HexConst &hex) {
    return 0;

}

std::any CountNonTerminals::visitStringConst(Sy2CPP::StringConst &s) {
    return 0;

}

std::any CountNonTerminals::visitIdentifierTerm(Sy2CPP::IdentifierTerm &term)  {
    if (this->non_terminals.contains(term.get_identifier())){
        return 1;
    } else {
        return 0;
    }
}

std::any CountNonTerminals::visitApplicationTerm(Sy2CPP::ApplicationTerm &application) {
    int sum = 0;
    for (auto& arg : application.get_arguments()) {
        sum += std::any_cast<int>(arg->accept(*this));
    }
    return sum;
}

CountNonTerminals::CountNonTerminals(const std::vector<Sy2CPP::SortedVar>& vector) {
    for (const auto& s_var: vector) {
        this->non_terminals.insert(s_var.first);
    }
}

int CountNonTerminals::count_non_terminals(Sy2CPP::Term *term){
    return std::any_cast<int>(term->accept(*this));
}

GenerateLeftMostProdukts::GenerateLeftMostProdukts(const std::unordered_map<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>>& vector) :
    rules{vector} {
}

std::any GenerateLeftMostProdukts::visitNumeral(Sy2CPP::Numeral &numeral) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateLeftMostProdukts::visitDecimal(Sy2CPP::Decimal &decimal) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateLeftMostProdukts::visitBoolConst(Sy2CPP::BoolConst &boolConst) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateLeftMostProdukts::visitHexConst(Sy2CPP::HexConst &hex) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateLeftMostProdukts::visitBinConst(Sy2CPP::BinConst &bin) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateLeftMostProdukts::visitStringConst(Sy2CPP::StringConst &s) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateLeftMostProdukts::visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) {
    if (this->rules.contains(term.get_identifier())) {
        std::vector<Sy2CPP::TermPtr> new_sub_terms;
        for(const Sy2CPP::TermPtr& t : rules.at(term.get_identifier())) {
            new_sub_terms.push_back(std::move(t->copy()));
        }
        return new_sub_terms;
    } else {
        return std::vector<Sy2CPP::TermPtr>();
    }
}

std::any GenerateLeftMostProdukts::visitApplicationTerm(Sy2CPP::ApplicationTerm &application) {
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

std::vector<Sy2CPP::TermPtr> GenerateLeftMostProdukts::generate_leftmost_products(Sy2CPP::Term * term) {
    return std::any_cast<std::vector<Sy2CPP::TermPtr>>(term->accept(*this));
}

/*
IsLeaf::IsLeaf(const std::vector<Sy2CPP::SortedVar> &vector) {
    for (const auto& s_var: vector) {
        this->non_terminals.insert(s_var.first);
    }
}

int IsLeaf::is_leaf(Sy2CPP::Term *term) {
    return std::any_cast<bool>(term->accept(*this));
}


std::any IsLeaf::visitNumeral(Sy2CPP::Numeral &numeral) {
    return true;
}

std::any IsLeaf::visitDecimal(Sy2CPP::Decimal &decimal) {
    return true;
}

std::any IsLeaf::visitBoolConst(Sy2CPP::BoolConst &boolConst) {
    return true;
}

std::any IsLeaf::visitHexConst(Sy2CPP::HexConst &hex) {
    return true;
}

std::any IsLeaf::visitBinConst(Sy2CPP::BinConst &bin) {
    return true;

}

std::any IsLeaf::visitStringConst(Sy2CPP::StringConst &s) {
    return true;

}

std::any IsLeaf::visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) {
    if (this->non_terminals.contains(term.get_identifier())) {
        return false;
    }
    return true;
}

std::any IsLeaf::visitApplicationTerm(Sy2CPP::ApplicationTerm &application) {
    for (auto& arg : application.get_arguments()) {
        if(!std::any_cast<bool>(arg->accept(*this))) {
            return false;
        }
    }
    return true;
}
 */

