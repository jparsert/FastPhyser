//
// Created by julian on 01.02.23.
//

#ifndef FASTPHYSER_CANDIDATE_TREE_H
#define FASTPHYSER_CANDIDATE_TREE_H


#include "ast.h"
#include "symbol_table.h"
#include "CountNonTerminals.h"
#include "GenerateAllLeftMostProducts.h"

/**
 * Generator class for generating the graph
 */
class CandidateTreeGenerator : public Sy2CPP::AstBaseVisitor {

private:
    std::unordered_map<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>> rules;
    CountNonTerminals non_terminal_counter;
    GenerateAllLeftMostProducts left_most_product_generator;
    //IsLeaf is_leaf_visitor;

    // This is where we do memory management of root. Hence, get_root returns a raw pointer, not a smart pointer.
    // The raw pointer will remain valid as long as the instance of this class is valid.
    Sy2CPP::TermPtr root;

    // Properties of function to be synthesised (used to generate Sy2CPP::SynthesisSolution)
    Sy2CPP::SyGuSSolution solution;


public:
    /**
     * Building the CandidateTreeGenerator from ast and symbol table. Note that we are deep copying the terms
     * from the AST.
     * @param problem
     * @param symbolT
     * @return Poiter to Generator object
     */
    static std::shared_ptr<CandidateTreeGenerator> build(Sy2CPP::Problem& problem, Sy2CPP::SymbolTable& symbolT);

    /**
     * We generate new terms on the heap (with Sy2CPP::Term::copy).
     * @param term
     * @return
     */
    std::vector<Sy2CPP::TermPtr> generate_leftmost_product_terms(Sy2CPP::Term* term);

    /**
     * We make a deep copy of the term and wrap it into a SyGuS solution. The memory of the given Term pointer is not
     * managed
     * @param term that will be wrapped
     * @return Copy of term wrapped in SyGuS solution`
     */
    Sy2CPP::SyGuSSolution get_term_as_solution(Sy2CPP::Term* term);

    int count_non_terminals(Sy2CPP::Term* term);

    bool is_leaf(Sy2CPP::Term* term);

    Sy2CPP::Term* get_root();

    // visitor functions
    std::any visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun) override;
    std::any visitGrammarDef(Sy2CPP::GrammarDef &grammarDef) override;
    std::any visitGroupedRuleList(Sy2CPP::GroupedRuleList &groupedRuleList) override;

};


#endif //FASTPHYSER_CANDIDATE_TREE_H
