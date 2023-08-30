//
// Created by julian on 30.08.23.
//

#ifndef FASTPHYSER_GENERATEALLLEFTMOSTPRODUCTS_H
#define FASTPHYSER_GENERATEALLLEFTMOSTPRODUCTS_H


#include "ast.h"
#include "symbol_table.h"
#include "CountNonTerminals.h"

class GenerateAllLeftMostProducts : public Sy2CPP::BfTermVisitor {

private:
    std::unordered_map<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>> rules;

public:
    explicit GenerateAllLeftMostProducts(const std::unordered_map<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>>& vector);
    GenerateAllLeftMostProducts() = default;

    std::vector<Sy2CPP::TermPtr> generate_leftmost_products(Sy2CPP::Term*);

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


#endif //FASTPHYSER_GENERATEALLLEFTMOSTPRODUCTS_H
