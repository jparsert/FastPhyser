//
// Created by julian on 25.01.23.
//

#ifndef FASTPHYSER_SMT_PROBLEM_BUILDER_H
#define FASTPHYSER_SMT_PROBLEM_BUILDER_H

#include <map>
#include "symbol_table.h"
#include "z3++.h"


class SyGuSZ3SolverReprBuilder : public Sy2CPP::AstBaseVisitor {

    z3::context context;
    z3::solver solver;

    z3::expr_vector assumptions;
    z3::expr_vector constraints;

    /**
     * When verifing we want to negate the problem and look for unsat. For every (check-synth) command this list
     * contains the negated problems. For the following problem: this list contains [neg (C1 & C2), neg (C1 & C2 & C3)]
     * (constraint C1)
     * (constraint C2)
     * (check-synth)
     * (constraint C3)
     * (check-synth)
     */
    z3::expr_vector negated_constraints;

    // function declaration map does not need to be sorted as names have to be unique
    std::unordered_map<Sy2CPP::FunctionDescriptor, z3::func_decl> function_declarations;

    std::vector<Sy2CPP::FunctionDescriptor> synth_fun;

    Sy2CPP::SymbolTable& symbolTable;

    // bound variable stack
    std::vector<std::pair<Sy2CPP::SymbolDescriptor, z3::expr>> bd_variable_stack;

    // List of all free variables.
    z3::expr_vector free_variables;

    /**
     * Mapping synth-fun commands to their arguments. The arguments are pairs of SymbolDescriptor with their
     * corresponding de-Brujin indexed z3::expression variables.
     * c.f. z3::context.variable(idx, sort)
     */
    std::unordered_map<Sy2CPP::FunctionDescriptor,
                            std::vector<std::pair<
                                    Sy2CPP::SymbolDescriptor,
                                    z3::expr>>> synth_fun_arguments;

    z3::expr
    get_bound_var_expr(const Sy2CPP::SymbolDescriptor& descriptor);

    void
    push_bd_var_stack(const Sy2CPP::SymbolDescriptor& descriptor, const z3::expr& expr);

    /**
     * Pop last n variables from stack
     * @param n number of vars to pop
     * @return list of popped elements.
     */
    std::vector<std::pair<Sy2CPP::SymbolDescriptor, z3::expr>>
    pop_bd_var_stack(size_t n = 1);

    z3::expr get_constant(const Sy2CPP::EitherIdentifier &id, Sy2CPP::EitherSort &srt);
    z3::expr get_constant(const Sy2CPP::EitherIdentifier &id, Sy2CPP::EitherSort &&srt);

    static
    std::optional<z3::expr>
    create_theory_fun_expr(Sy2CPP::FunctionDescriptor& descriptor, z3::expr_vector& vector1);

    /**
     * List of models for CEGIS loop
     */
    std::vector<z3::model> cegis_models;
    /*
     * Runs Counter-example guided Inductive Synthesis on expression. Note that the expression is assumed to have
     * function declarations substituted accordingly.
     * */
    std::optional<z3::model> check_cegis_previous_models(const z3::expr& expr);

public:

    explicit SyGuSZ3SolverReprBuilder(Sy2CPP::SymbolTable& st):
        symbolTable{st}, constraints{context}, assumptions{context}, solver{context}, negated_constraints(context),
        free_variables(context) {}

    static std::shared_ptr<SyGuSZ3SolverReprBuilder> build(Sy2CPP::Problem& problem, Sy2CPP::SymbolTable& symbolT) {
        auto solver = std::make_shared<SyGuSZ3SolverReprBuilder>(symbolT);
        problem.accept(*solver);
        return solver;
    }

    void add_assumption(const z3::expr& assum);

    void reset_solver(const std::string& logic);

    void add_function_declaration(const Sy2CPP::FunctionDescriptor& desc, const z3::func_decl& decl);

    z3::func_decl get_function_declaration(Sy2CPP::FunctionDescriptor& descr) const;

    void add_synth_fun(const Sy2CPP::FunctionDescriptor& descriptor);

    std::vector<Sy2CPP::FunctionDescriptor> get_synth_funs() const;

    z3::check_result check_candidate(Sy2CPP::FunctionDescriptor& descr, Sy2CPP::Term* term );

    /**
     * Simply runs solver.check on constraints and assumptions without negation etc.
     * @return result of z3::solver.check()
     */
    z3::check_result check();


    // All Problem visitor functions
    std::any visitIndexedIdentifier(Sy2CPP::IndexedIdentifier &indexedIdentifier) override;
    std::any visitSimpleIdentifier(Sy2CPP::SimpleIdentifier &id) override;

    std::any visitProblem(Sy2CPP::Problem &problem) override;
    std::any visitNumeral(Sy2CPP::Numeral &numeral) override;
    std::any visitBoolConst(Sy2CPP::BoolConst &boolConst) override;
    std::any visitStringConst(Sy2CPP::StringConst &s) override;
    std::any visitSimpleSort(Sy2CPP::SimpleSort &sort) override;
    std::any visitParametricSort(Sy2CPP::ParametricSort &sort) override {
        throw Sy2CPP::NotImplemented("Parametric sorts are not implemented in SMT problem generation.");
    }
    std::any visitExistsTerm(Sy2CPP::ExistsTerm &exists) override;
    std::any visitForallTerm(Sy2CPP::ForallTerm &forall) override;
    std::any visitLetTerm(Sy2CPP::LetTerm &let) override;
    std::any visitApplicationTerm(Sy2CPP::ApplicationTerm &application) override;
    std::any visitAssumeCmd(Sy2CPP::AssumeCmd &assumeCmd) override;
    std::any visitConstraintCmd(Sy2CPP::ConstraintCmd &context) override;
    std::any visitDeclareVarCmd(Sy2CPP::DeclareVarCmd &context) override;
    std::any visitSetLogic(Sy2CPP::SetLogic &context) override;
    std::any visitCheckSynthCmd(Sy2CPP::CheckSynthCmd &context) override;
    std::any visitDefineFun(Sy2CPP::DefineFunCmd &context) override;
    std::any visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun) override;

};


#endif //FASTPHYSER_SMT_PROBLEM_BUILDER_H
