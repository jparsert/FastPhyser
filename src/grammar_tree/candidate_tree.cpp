//
// Created by julian on 01.02.23.
//

#include "CountNonTerminals.h"
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
    this->left_most_product_generator = GenerateAllLeftMostProducts(this->rules);
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

