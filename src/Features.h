//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_FEATURES_H
#define FASTPHYSER_FEATURES_H

#include "ast.h"
#include "constants.h"
#include "utilities.h"
#include <map>
#include <unordered_map>

/*
class AbstractFeatureGenerator {

public:

    virtual ~AbstractFeatureGenerator() = default;

    virtual std::vector<float> get_specification_features(Sy2CPP::Problem* problem) = 0;

    virtual std::vector<float> get_candidate_features(Sy2CPP::Term* term) = 0;


    [[nodiscard]] virtual size_t get_spec_feature_dim() const = 0;

    [[nodiscard]] virtual size_t get_candidate_feature_dim() const = 0;

};
*/

// these are (hopefully) as far as I can tell deterministic
class Size2TermWalk : public Sy2CPP::AstBaseVisitor {

    std::vector<float> features;
    std::unordered_map<Sy2CPP::EitherIdentifier, size_t> arguments;

public:

    Size2TermWalk(): features(NUM_FEATURES,0) { }

    static std::string get_name() {return "Size2TermWalk";}

    static size_t get_spec_feature_dim() { return NUM_FEATURES; } ;

    static size_t get_candidate_feature_dim() { return NUM_FEATURES; };

    static std::vector<float> get_specification_features(Sy2CPP::Problem* problem) {
        Size2TermWalk tw;
        problem->accept(tw);
        return tw.features;
    }

    static std::vector<float> get_candidate_features(Sy2CPP::Term* term) {
        Size2TermWalk tw;
        term->accept(tw);
        return tw.features;
    }

    // visitor functions
    std::any visitNumeral(Sy2CPP::Numeral &numeral) override {
        features[numeral.get_value() % NUM_FEATURES] += 1.0f;
        return static_cast<std::size_t>(numeral.get_value());
    }
    std::any visitDecimal(Sy2CPP::Decimal &decimal) override{
        throw Sy2CPP::NotImplemented("Feature not Implemented");
    }
    std::any visitBoolConst(Sy2CPP::BoolConst &boolConst) override {
        return static_cast<std::size_t>(0);
    }
    std::any visitHexConst(Sy2CPP::HexConst &hex) override {
        throw Sy2CPP::NotImplemented("Feature not Implemented");
    }
    std::any visitBinConst(Sy2CPP::BinConst &bin) override {
        throw Sy2CPP::NotImplemented("Feature not Implemented");
    }
    std::any visitStringConst(Sy2CPP::StringConst &s) override {
        throw Sy2CPP::NotImplemented("Feature not Implemented");
    }
    std::any visitIdentifierTerm(Sy2CPP::IdentifierTerm &term) override {
        auto x = term.get_identifier();
        if (arguments.contains(x)) {  // This is a function argument
            const size_t hash = arguments[x];
            features[hash] += 1.0f;
            return hash;
        } else { // This is not a function argument but some other variable
            std::size_t hash = std::hash<Sy2CPP::EitherIdentifier>()(term.get_identifier());
            features[hash % NUM_FEATURES] += 1.0f;
            return hash;
        }
    }

    std::any visitApplicationTerm(Sy2CPP::ApplicationTerm &application) override {
        std::size_t hash = std::hash<Sy2CPP::EitherIdentifier>()(application.get_identifier());

        for (auto& sub: application.get_arguments()) {
            auto next_hash = std::any_cast<std::size_t>(sub->accept(*this));
            features[hash_combine<size_t, size_t>(hash, next_hash) % NUM_FEATURES] += 1.0f;
        }

        return hash;
    }

    std::any visitExistsTerm(Sy2CPP::ExistsTerm &exists) override {
        std::size_t hash = std::hash<std::string>()("Exists");
        auto next_hash = std::any_cast<std::size_t>(exists.get_term()->accept(*this));
        features[hash_combine<std::size_t, std::size_t>(hash, next_hash) % NUM_FEATURES] += 1.0f;
        return hash;
    }

    std::any visitForallTerm(Sy2CPP::ForallTerm &forall) override {
        std::size_t hash = std::hash<std::string>()("Forall");
        auto next_hash = std::any_cast<std::size_t>(forall.get_term()->accept(*this));
        features[hash_combine<std::size_t, std::size_t>(hash, next_hash) % NUM_FEATURES] += 1.0f;
        return hash;
    }

    std::any visitLetTerm(Sy2CPP::LetTerm &let) override {
        std::size_t hash = std::hash<std::string>()("let");
        auto next_hash = std::any_cast<std::size_t>(let.get_term()->accept(*this));
        features[hash_combine<std::size_t, std::size_t>(hash, next_hash) % NUM_FEATURES] += 1.0f;
        return hash;
    }

    std::any visitConstraintCmd(Sy2CPP::ConstraintCmd &constraintCmd) override {
        constraintCmd.get_term()->accept(*this);
        return {};
    }

    std::any visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun) override {
        std::vector<Sy2CPP::SortedVar> args =  synthFun.get_arguments();

        auto hash = std::hash<std::string>()("synth_fun_arg");

        for (int i = 0; i < args.size(); ++i) {
            size_t comb_hash = hash_combine(hash, i) % NUM_FEATURES;
            arguments.insert({args[i].first, comb_hash});
        }
        return {};
    }

};



#endif //FASTPHYSER_FEATURES_H
