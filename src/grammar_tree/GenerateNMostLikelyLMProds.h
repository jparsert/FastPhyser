//
// Created by julian on 30.08.23.
//

#ifndef FASTPHYSER_GENERATENMOSTLIKELYLMPRODS_H
#define FASTPHYSER_GENERATENMOSTLIKELYLMPRODS_H


#include <utility>

#include "ast.h"
#include "symbol_table.h"
#include "CountNonTerminals.h"
#include "GenerateAllLeftMostProducts.h"

/**
 * Generate the N most likely left-most products
 */
class GenerateNMostLikelyLMProds : public Sy2CPP::AstBaseVisitor{

    // This is where we do memory management of root. Hence, get_root returns a raw pointer, not a smart pointer.
    // The raw pointer will remain valid as long as the instance of this class is valid.
    Sy2CPP::TermPtr root;

    // Properties of function to be synthesised (used to generate Sy2CPP::SynthesisSolution)
    Sy2CPP::SyGuSSolution solution;

    CountNonTerminals non_terminal_counter;

    std::vector<int> probabilities;


    std::unordered_map<Sy2CPP::EitherIdentifier, std::vector<std::pair<int, Sy2CPP::TermPtr>>> rules_and_probs;

    // How many most likely terms do we want at most?
    // If N = 1 then we will get the one likely term. for 2 the 2 most likely terms etc.
    int N;

public:

    explicit GenerateNMostLikelyLMProds(std::vector<int> probabilities, int N_most_likely=1): N(N_most_likely), probabilities(std::move(probabilities))
    {

    }


    /**
     * Building the CandidateTreeGenerator from ast and symbol table. Note that we are deep copying the terms
     * from the AST. We also give a vector of probabilities.
     * @param problem
     * @param symbolT
     * @param probs
     * @return Pointer to Generator object
     */
    static std::shared_ptr<GenerateNMostLikelyLMProds> build(Sy2CPP::Problem& problem, Sy2CPP::SymbolTable& symbolT, const std::vector<int>& probs, int N=1);

    /**
     * We make a deep copy of the term and wrap it into a SyGuS solution. The memory of the given Term pointer is not
     * managed
     * @param term that will be wrapped
     * @return Copy of term wrapped in SyGuS solution`
     */
    Sy2CPP::SyGuSSolution get_term_as_solution(Sy2CPP::Term* term);

    Sy2CPP::Term* get_root();
    bool is_leaf(Sy2CPP::Term* term);

    // These 3 functions are required to collect grammar and respective probabilities
    std::any visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun) override;
    std::any visitGrammarDef(Sy2CPP::GrammarDef &grammarDef) override;
    std::any visitGroupedRuleList(Sy2CPP::GroupedRuleList &groupedRuleList) override;


    /**
     * Generate at most N most likely product terms of the left-most nonterminal
     * @return
     */
    std::vector<Sy2CPP::TermPtr> generate_n_most_likely_LM_products(Sy2CPP::Term* term);

    // visitor functions
    std::any visitNumeral(Sy2CPP::Numeral &numeral) override;
    std::any visitDecimal(Sy2CPP::Decimal &decimal) override ;
    std::any visitBoolConst(Sy2CPP::BoolConst &boolConst) override;
    std::any visitHexConst(Sy2CPP::HexConst &hex) override;
    std::any visitBinConst(Sy2CPP::BinConst &bin) override;
    std::any visitStringConst(Sy2CPP::StringConst &s) override;
    std::any visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) override;
    std::any visitApplicationTerm(Sy2CPP::ApplicationTerm &application) override;

};


#endif //FASTPHYSER_GENERATENMOSTLIKELYLMPRODS_H
