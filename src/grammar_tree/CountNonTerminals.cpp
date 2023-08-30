//
// Created by julian on 30.08.23.
//

#include "CountNonTerminals.h"


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
