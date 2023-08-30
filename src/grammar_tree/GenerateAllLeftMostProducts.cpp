//
// Created by julian on 30.08.23.
//

#include "GenerateAllLeftMostProducts.h"


GenerateAllLeftMostProducts::GenerateAllLeftMostProducts(const std::unordered_map<Sy2CPP::EitherIdentifier, std::vector<Sy2CPP::TermPtr>>& vector) :
        rules{vector} {
}

std::any GenerateAllLeftMostProducts::visitNumeral(Sy2CPP::Numeral &numeral) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateAllLeftMostProducts::visitDecimal(Sy2CPP::Decimal &decimal) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateAllLeftMostProducts::visitBoolConst(Sy2CPP::BoolConst &boolConst) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateAllLeftMostProducts::visitHexConst(Sy2CPP::HexConst &hex) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateAllLeftMostProducts::visitBinConst(Sy2CPP::BinConst &bin) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateAllLeftMostProducts::visitStringConst(Sy2CPP::StringConst &s) {
    return std::vector<Sy2CPP::TermPtr>();
}

std::any GenerateAllLeftMostProducts::visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) {
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

std::any GenerateAllLeftMostProducts::visitApplicationTerm(Sy2CPP::ApplicationTerm &application) {
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

std::vector<Sy2CPP::TermPtr> GenerateAllLeftMostProducts::generate_leftmost_products(Sy2CPP::Term * term) {
    return std::any_cast<std::vector<Sy2CPP::TermPtr>>(term->accept(*this));
}
