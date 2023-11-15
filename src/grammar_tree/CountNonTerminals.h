//
// Created by julian on 30.08.23.
//

#ifndef FASTPHYSER_COUNTNONTERMINALS_H
#define FASTPHYSER_COUNTNONTERMINALS_H


#include "ast.h"
#include "symbol_table.h"

class CountNonTerminals : public Sy2CPP::BfTermVisitor {

private:
    std::unordered_set<Sy2CPP::EitherIdentifier> non_terminals;

public:
    explicit CountNonTerminals(const std::unordered_set<Sy2CPP::EitherIdentifier>& non_terms):
            non_terminals{non_terms} {}

    explicit CountNonTerminals(const std::vector<Sy2CPP::SortedVar>& vector);

    CountNonTerminals() = default;

    int count_non_terminals(Sy2CPP::Term* term) ;

    // visito functions
    std::any visitNumeral(Sy2CPP::Numeral &numeral) override;
    std::any visitDecimal(Sy2CPP::Decimal &decimal) override ;
    std::any visitBoolConst(Sy2CPP::BoolConst &boolConst) override;
    std::any visitHexConst(Sy2CPP::HexConst &hex) override;
    std::any visitBinConst(Sy2CPP::BinConst &bin) override;
    std::any visitStringConst(Sy2CPP::StringConst &s) override;
    std::any visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) override;
    std::any visitApplicationTerm(Sy2CPP::ApplicationTerm &application) override;
    std::any visitBVConst(Sy2CPP::BVConst &cnst) override;
    std::any visitVariableGTerm(Sy2CPP::VariableGTerm &context) override;

};


#endif //FASTPHYSER_COUNTNONTERMINALS_H
