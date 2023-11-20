//
// Created by julian on 25.01.23.
//

#include <ranges>
#include "smt_problem_builder.h"
#include "exceptions.h"
#include "typing.h"
#include "resolvers.h"
#include "AstPrinter.h"

void SyGuSZ3SolverReprBuilder::add_assumption(const z3::expr& assum) {
    this->assumptions.push_back(assum.simplify());
}

void SyGuSZ3SolverReprBuilder::reset_solver(const std::string &logic) {
    this->solver = z3::solver(context, logic.c_str());
}

void
SyGuSZ3SolverReprBuilder::add_function_declaration(const Sy2CPP::FunctionDescriptor &desc, const z3::func_decl& decl)
{
    this->function_declarations.insert({desc, decl});
}

z3::func_decl SyGuSZ3SolverReprBuilder::get_function_declaration(Sy2CPP::FunctionDescriptor &descr) const {
    auto val = this->function_declarations.find(descr);
    if (val != this->function_declarations.end()) {
        return val->second;
    }
    std::string s = descr.operator std::string();
    throw Sy2CPP::UnknownSymbol("Could not locate FunctionDescriptor. "
                                "This should not happen as checks are in place to prevent this.");
}

void SyGuSZ3SolverReprBuilder::add_synth_fun(const Sy2CPP::FunctionDescriptor &descriptor) {
    this->synth_fun.push_back(descriptor);
}

std::vector<Sy2CPP::FunctionDescriptor> SyGuSZ3SolverReprBuilder::get_synth_funs() const {
    return this->synth_fun;
}


z3::check_result SyGuSZ3SolverReprBuilder::check() {
    solver.reset();
    solver.add(constraints[0]); // For now, we only support one check synth command
    return solver.check(assumptions);
}

std::any SyGuSZ3SolverReprBuilder::visitProblem(Sy2CPP::Problem &problem)  {
    for (const auto& cmd :problem.get_commands()) {
        cmd->accept(*this);
    }
    return {};
}

z3::expr
SyGuSZ3SolverReprBuilder::get_bound_var_expr(const Sy2CPP::SymbolDescriptor &descriptor) {
    for(auto& i : std::views::reverse(this->bd_variable_stack)) {
        if (descriptor == i.first) {
            return i.second;
        }
    }
    throw Sy2CPP::UnknownSymbol("Symbol " + to_string(descriptor.get_identifier()) +
                                " not found in let binding stack.");
}

void
SyGuSZ3SolverReprBuilder::push_bd_var_stack(const Sy2CPP::SymbolDescriptor &descriptor,
                                            const z3::expr& expr) {
    this->bd_variable_stack.emplace_back(descriptor, expr);
}

std::vector<std::pair<Sy2CPP::SymbolDescriptor, z3::expr>>
SyGuSZ3SolverReprBuilder::pop_bd_var_stack(size_t n) {
    std::vector<std::pair<Sy2CPP::SymbolDescriptor, z3::expr>> res;
    for (int i = 0; i < n; ++i) {
        res.push_back(this->bd_variable_stack.back());
        this->bd_variable_stack.pop_back();
    }
    return res;

}

std::any SyGuSZ3SolverReprBuilder::visitNumeral(Sy2CPP::Numeral &numeral) {
    return context.int_val(numeral.get_value());
}

std::any SyGuSZ3SolverReprBuilder::visitBoolConst(Sy2CPP::BoolConst &boolConst) {
    return context.bool_val(boolConst.get_value());
}

std::any SyGuSZ3SolverReprBuilder::visitStringConst(Sy2CPP::StringConst &s) {
    return context.string_val(s.get_string());
}

std::any SyGuSZ3SolverReprBuilder::visitSimpleIdentifier(Sy2CPP::SimpleIdentifier &id) {
    std::optional<Sy2CPP::SymbolDescriptor> descr =
            this->symbolTable.resolve_symbol_descriptor(id);


    // check if symbol table could resolve Identifier
    if (!descr.has_value()) {
        // Could be that we have a constant function
        Sy2CPP::FunctionDescriptor fun_descriptor = this->symbolTable.lookup_or_resolve_function(id, {}).value();

        // NOT THEORY FUNCTION
        z3::func_decl decl = this->get_function_declaration(fun_descriptor);
        return decl();
    }

    return this->get_bound_var_expr(descr.value());
}

std::any SyGuSZ3SolverReprBuilder::visitIndexedIdentifier(Sy2CPP::IndexedIdentifier &indexedIdentifier) {
    std::optional<Sy2CPP::SymbolDescriptor> descr =
            this->symbolTable.resolve_symbol_descriptor(indexedIdentifier);

    // check if symbol table could resolve Identifier
    if (!descr.has_value()) {
        throw Sy2CPP::UnknownSymbol("Could not find " + to_string(indexedIdentifier) + " in symbol table.");
    }
    return this->get_bound_var_expr(descr.value());
}

z3::expr SyGuSZ3SolverReprBuilder::get_constant(const Sy2CPP::EitherIdentifier& id, Sy2CPP::EitherSort& srt) {
    if(id.index() == 0) { // We have a SimpleIdentifier
        if(srt.index() == 0) {// We have a SimpleSort
            auto z3_srt = std::any_cast<z3::sort>(this->visitEitherSort(srt));
            Sy2CPP::SimpleIdentifier s_id = std::get<0>(id);
            return context.constant(s_id.get_symbol().c_str(), z3_srt);
        } else {
            throw Sy2CPP::UnsupportedFeature("Parametric sorts are not supported yet when building an SMT problem.");
        }
    } else {
        throw Sy2CPP::UnsupportedFeature("Indexed identifiers are not suported when building an SMT problem");
    }
}

z3::expr SyGuSZ3SolverReprBuilder::get_constant(const Sy2CPP::EitherIdentifier& id, Sy2CPP::EitherSort&& srt) {
    if(id.index() == 0) { // We have a SimpleIdentifier
        if(srt.index() == 0) {// We have a SimpleSort
            auto z3_srt = std::any_cast<z3::sort>(this->visitEitherSort(srt));
            Sy2CPP::SimpleIdentifier s_id = std::get<0>(id);
            return context.constant(s_id.get_symbol().c_str(), z3_srt);
        } else {
            throw Sy2CPP::UnsupportedFeature("Parametric sorts are not supported yet when building an SMT problem.");
        }
    } else {
        throw Sy2CPP::UnsupportedFeature("Indexed identifiers are not suported when building an SMT problem");
    }
}

std::any SyGuSZ3SolverReprBuilder::visitSimpleSort(Sy2CPP::SimpleSort &sort) {
    Sy2CPP::EitherIdentifier sort_id = sort.get_identifier();

    if (sort_id.index() == 0) { // simple id
        Sy2CPP::SimpleIdentifier simple_id = std::get<0>(sort_id);
        if (simple_id.get_symbol() == "Int") {
            return context.int_sort();
        } else if (simple_id.get_symbol() == "Bool") {
            return context.bool_sort();
        }
    } else if (sort_id.index() == 1) {
        Sy2CPP::IndexedIdentifier indexed_id = std::get<1>(sort_id);
        if (Sy2CPP::BVResolver::is_bv_sort({sort})) {
            auto x = Sy2CPP::BVResolver::get_size_of_bv(sort);
            if(x) {
                return context.bv_sort(x.value());
            }
        }
    }
    throw Sy2CPP::UnsupportedFeature("The required sort is neither Int, Bool nor BitVec.");
}

std::any SyGuSZ3SolverReprBuilder::visitExistsTerm(Sy2CPP::ExistsTerm &exists) {
    z3::expr_vector quant_vars(context);
    for(auto& bd_var : exists.get_vars()) {
        // push symbol to symbol table
        Sy2CPP::SymbolDescriptor symbol(bd_var.first, bd_var.second, Sy2CPP::BinderKind::QUANTIFIER);
        this->symbolTable.push_symbol_stack(symbol);

        // push symbol to var/expression map
        z3::expr cst = this->get_constant(bd_var.first, bd_var.second);
        quant_vars.push_back(cst);
        this->push_bd_var_stack(symbol, cst);
    }

    // With all variables on stack recurse into subterm.
    auto sub_term = std::any_cast<z3::expr>(exists.get_term()->accept(*this));

    // remove symbols from symbol table
    this->symbolTable.pop_symbol_stack(exists.get_vars().size());
    // remove symbols from var/expression map
    this->pop_bd_var_stack(exists.get_vars().size());
    return z3::exists(quant_vars, sub_term);

}

std::any SyGuSZ3SolverReprBuilder::visitForallTerm(Sy2CPP::ForallTerm &forall) {
    z3::expr_vector quant_vars(context);
    for(auto& bd_var : forall.get_vars()) {
        // push symbol to symbol table
        Sy2CPP::SymbolDescriptor symbol(bd_var.first, bd_var.second, Sy2CPP::BinderKind::QUANTIFIER);
        this->symbolTable.push_symbol_stack(symbol);

        // push symbol to var/expression map
        z3::expr cst = this->get_constant(bd_var.first, bd_var.second);
        quant_vars.push_back(cst);
        this->push_bd_var_stack(symbol, cst);
    }

    // With all variables on stack recurse into subterm.
    auto sub_term = std::any_cast<z3::expr>(forall.get_term()->accept(*this));

    // remove symbols from symbol table
    this->symbolTable.pop_symbol_stack(forall.get_vars().size());
    // remove symbols from var/expression map
    this->pop_bd_var_stack(forall.get_vars().size());
    return z3::forall(quant_vars, sub_term);
}

std::any SyGuSZ3SolverReprBuilder::visitLetTerm(Sy2CPP::LetTerm &let) {
    z3::expr_vector term_mappings(context);
    for (auto& bd_var : let.get_var_bindings()) {
        // push symbol to symbol table
        Sy2CPP::SymbolDescriptor symbol(std::get<0>(bd_var), std::get<1>(bd_var), Sy2CPP::BinderKind::LET);
        this->symbolTable.push_symbol_stack(symbol);

        // push symbol to var/expression map
        auto bd_expr = std::any_cast<z3::expr>(std::get<2>(bd_var)->accept(*this));
        term_mappings.push_back(bd_expr);
        this->push_bd_var_stack(symbol, bd_expr);
    }

    // With all vars on stack recurse into subterm
    auto sub_term = std::any_cast<z3::expr>(let.get_term()->accept(*this));

    // clean stacks
    this->symbolTable.pop_symbol_stack(let.get_var_bindings().size());
    this->pop_bd_var_stack(let.get_var_bindings().size());
    return sub_term;
}

std::any SyGuSZ3SolverReprBuilder::visitAssumeCmd(Sy2CPP::AssumeCmd &assumeCmd) {
    auto alpha = std::any_cast<z3::expr>(assumeCmd.get_term()->accept(*this));
    this->add_assumption(alpha);
    return {};
}

std::any SyGuSZ3SolverReprBuilder::visitConstraintCmd(Sy2CPP::ConstraintCmd &constr) {
    auto psi = std::any_cast<z3::expr>(constr.get_term()->accept(*this));
    this->constraints.push_back(psi);
    return {};
}

std::any SyGuSZ3SolverReprBuilder::visitDeclareVarCmd(Sy2CPP::DeclareVarCmd &declare_var_cmd) {
    auto descriptor = this->symbolTable.resolve_symbol_descriptor(declare_var_cmd.get_identifier());
    if (!descriptor) {
        throw Sy2CPP::UnknownSymbol("Symbol table could not resolve symbol " +
                                        to_string(declare_var_cmd.get_identifier()));
    }
    // Declared variables are in global scope, hence they already are on the symbol table stack and don't need to
    // be added again. But we need to add them to the var/term mapping and to the free vars list.
    z3::expr cnst = this->get_constant(declare_var_cmd.get_identifier(), declare_var_cmd.get_sort());
    this->free_variables.push_back(cnst);
    this->push_bd_var_stack(descriptor.value(), cnst);
    return {};
}

std::any SyGuSZ3SolverReprBuilder::visitSetLogic(Sy2CPP::SetLogic &setLogic) {
     this->reset_solver(setLogic.get_logic());
     return {};
}

std::any SyGuSZ3SolverReprBuilder::visitCheckSynthCmd(Sy2CPP::CheckSynthCmd &checkSynthCmd) {
    auto conj = z3::mk_and(this->constraints);
    this->negated_constraints.push_back((!conj).simplify());
    return {};
}

std::any SyGuSZ3SolverReprBuilder::visitDefineFun(Sy2CPP::DefineFunCmd &defineFunCmd) {
    // If this is not a simple identifier we have a problem
    Sy2CPP::SimpleIdentifier id = std::get<0>(defineFunCmd.get_identifier());

    //get range sort
    auto range_sort = std::any_cast<z3::sort>(this->visitEitherSort(defineFunCmd.get_sort()));

    // get argument sorts and vars and push to variable stack
    std::vector<z3::sort> arg_sorts;
    z3::expr_vector arg_vars(context);
    std::vector<Sy2CPP::EitherSort> arg_sy_sorts;
    int index = 0;
    for (auto& s_var : defineFunCmd.get_arguments()) {
        auto sort = std::any_cast<z3::sort>(this->visitEitherSort(s_var.second));
        z3::expr var = context.variable(index, sort);

        arg_sorts.push_back(sort);
        arg_vars.push_back(var);
        arg_sy_sorts.push_back(s_var.second);
        Sy2CPP::SymbolDescriptor descr(s_var.first,s_var.second, Sy2CPP::BinderKind::FUNCTION_ARGUMENT);
        this->symbolTable.push_symbol_stack(descr);
        this->push_bd_var_stack(descr, var);
        ++index;
    }

    auto body = std::any_cast<z3::expr>(defineFunCmd.get_term()->accept(*this));

    //pop stacks
    this->symbolTable.pop_symbol_stack(defineFunCmd.get_arguments().size());
    this->pop_bd_var_stack(defineFunCmd.get_arguments().size());


    // declare signature and define function
    z3::func_decl declaration = context.recfun(id.get_symbol().c_str(), arg_sorts.size(), arg_sorts.data(), range_sort);
    context.recdef(declaration, arg_vars, body);

    Sy2CPP::FunctionDescriptor f_descriptor(id, arg_sy_sorts, defineFunCmd.get_sort(), Sy2CPP::FunctionKind::USER_DEFINED);
    this->add_function_declaration(f_descriptor, declaration);

    return {};
}

std::any SyGuSZ3SolverReprBuilder::visitSynthFunCmd(Sy2CPP::SynthFunCmd &synthFun) {
    // If this is not a simple identifier we have a problem
    Sy2CPP::SimpleIdentifier id = std::get<0>(synthFun.get_identifier());

    //get range sort
    auto range_sort = std::any_cast<z3::sort>(this->visitEitherSort(synthFun.get_sort()));

    // get argument sorts and vars and push to variable stack
    z3::sort_vector arg_sorts(context);
    std::vector<Sy2CPP::EitherSort> arg_sy_sorts;
    std::vector<std::pair<Sy2CPP::SymbolDescriptor, z3::expr>> arg_vars;
    std::vector<z3::expr> ex;
    int index = 0;
    for (auto& s_var : synthFun.get_arguments()) {
        auto sort = std::any_cast<z3::sort>(this->visitEitherSort(s_var.second));
        Sy2CPP::SymbolDescriptor symbol(s_var.first, s_var.second, Sy2CPP::BinderKind::SYNTH_FUN_ARGUMENT);
        arg_sorts.push_back(sort);
        arg_vars.emplace_back(symbol, context.variable(index, sort));
        arg_sy_sorts.push_back(s_var.second);
        index++;
    }

    // declare signature and add it to function declarations and synth fun list
    // We also add the arg_vars list to synth_fun_arguments generate de-Brujin indext functions
    z3::func_decl declaration = context.function(id.get_symbol().c_str(),arg_sorts, range_sort);
    Sy2CPP::FunctionDescriptor f_descriptor(id, arg_sy_sorts, synthFun.get_sort(), Sy2CPP::FunctionKind::SYNTH_FUN);
    this->synth_fun_arguments.insert({f_descriptor, arg_vars});
    this->add_function_declaration(f_descriptor, declaration);
    this->add_synth_fun(f_descriptor);


    return {};
}

std::any SyGuSZ3SolverReprBuilder::visitApplicationTerm(Sy2CPP::ApplicationTerm &application) {
    Sy2CPP::EitherIdentifier id = application.get_identifier();
    std::vector<Sy2CPP::EitherSort> arg_sorts;

    for (auto& x : application.get_arguments()) {
        arg_sorts.push_back(Sy2CPP::TypeInference::infer_and_check_type(this->symbolTable, x.get()));
    }
    //= fplus::transform(
    //           [this](const auto& term){return Sy2CPP::TypeInference::infer_and_check_type(this->symbolTable, term.get());},
    //            application.get_arguments());

    auto descr = this->symbolTable.lookup_or_resolve_function(id, arg_sorts);

    Sy2CPP::FunctionDescriptor fun_descriptor = descr.value();

    // recurse into ast
    z3::expr_vector visited_args(context);
    Sy2CPP::AstToString pr;
    for (auto& arg_sub: application.get_arguments()) {
        auto any = arg_sub->accept(*this);
        visited_args.push_back(std::any_cast<z3::expr>(any));
    }

    // CHECK FOR THEORY FUNCTIONS
    auto expr = create_theory_fun_expr(fun_descriptor, visited_args);
    if (expr) {
        return expr.value();
    }

    // NOT THEORY FUNCTION
    z3::func_decl decl = this->get_function_declaration(fun_descriptor);
    return decl(visited_args);
}

// TODO Find a better way of doing this function. It's ugly, tedious, and not modular.
std::optional<z3::expr>
SyGuSZ3SolverReprBuilder::create_theory_fun_expr(Sy2CPP::FunctionDescriptor& descriptor, z3::expr_vector & args) {
    Sy2CPP::EitherSort bool_sort = Sy2CPP::CoreResolver::get_bool_sort();
    std::initializer_list<Sy2CPP::EitherSort> arg_lst1{bool_sort};
    std::initializer_list<Sy2CPP::EitherSort> arg_lst2{bool_sort, bool_sort};

    //Special operations
    if(descriptor.get_identifier().index() == 0) {
        Sy2CPP::SimpleIdentifier id = std::get<0>(descriptor.get_identifier());
        if (id.get_symbol() == "=") {
           return args[0] == args[1];
        } else if (id.get_symbol() == "distinct") {
            return z3::distinct(args);
        } else if (id.get_symbol() == "ite") {
            return z3::ite(args[0], args[1], args[2]);
        }
    }
    // CoreResolver operators

    // NOT operator
    Sy2CPP::EitherIdentifier notId = Sy2CPP::get_simple_id_from_str("not");
    if (descriptor == Sy2CPP::FunctionDescriptor(notId, arg_lst1, bool_sort, Sy2CPP::FunctionKind::THEORY,false)) {
        return !args[0];
    }

    // => operator
    Sy2CPP::EitherIdentifier implId = Sy2CPP::get_simple_id_from_str("=>");
    if (descriptor == Sy2CPP::FunctionDescriptor(implId, arg_lst2, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return z3::implies(args[0], args[1]);
    }

    // and operator
    Sy2CPP::EitherIdentifier andId = Sy2CPP::get_simple_id_from_str("and");
    if (descriptor == Sy2CPP::FunctionDescriptor(andId, arg_lst1, bool_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        return z3::mk_and(args);
    }

    // Add or operator
    Sy2CPP::EitherIdentifier orId = Sy2CPP::get_simple_id_from_str("or");
    if (descriptor == Sy2CPP::FunctionDescriptor(orId, arg_lst1, bool_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        return z3::mk_or(args);
    }

    // Add xor operator
    Sy2CPP::EitherIdentifier xorId = Sy2CPP::get_simple_id_from_str("xor");
    if (descriptor == Sy2CPP::FunctionDescriptor(xorId, arg_lst1, bool_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        return z3::mk_xor(args);
    }

    /** #############################
    Yixuan
    start
    #################################
    **/

    // BV resolver operations
    Sy2CPP::EitherSort bv_sort = Sy2CPP::BVResolver::get_bv_sort(0);//(bits)

    std::initializer_list<Sy2CPP::EitherSort> arg_list1B{bv_sort};
    std::initializer_list<Sy2CPP::EitherSort> arg_list2B{bv_sort, bv_sort};

    /* Unary */
    // Add bvnot operator
    Sy2CPP::EitherIdentifier bvnot = Sy2CPP::get_simple_id_from_str("bvnot");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvnot, arg_list1B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvnot" << std::endl;
        return ~args[0];
    }

    // Add bvneg operator
    Sy2CPP::EitherIdentifier bvneg = Sy2CPP::get_simple_id_from_str("bvneg");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvneg, arg_list1B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvneg" << std::endl;
        return -args[0];
    }

    /* Binary  not chainable */
    // Add bvurem operator
    Sy2CPP::EitherIdentifier bvurem = Sy2CPP::get_simple_id_from_str("bvurem");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvurem, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvurem" << std::endl;
        return z3::urem(args[0], args[1]);
    }

    // Add bvsrem operator
    Sy2CPP::EitherIdentifier bvsrem = Sy2CPP::get_simple_id_from_str("bvsrem");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsrem, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvsrem" << std::endl;
        return z3::srem(args[0], args[1]);
    }

    // Add bvsmod operator
    Sy2CPP::EitherIdentifier bvsmod = Sy2CPP::get_simple_id_from_str("bvsmod");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsmod, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvsmod" << std::endl;
        return z3::smod(args[0], args[1]);
    }

    // Add bvshl operator
    Sy2CPP::EitherIdentifier bvshl = Sy2CPP::get_simple_id_from_str("bvshl");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvshl, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvshl" << std::endl;
        return z3::shl(args[0], args[1]);
    }
 
    // Add bvlshr operator
    Sy2CPP::EitherIdentifier bvlshr = Sy2CPP::get_simple_id_from_str("bvlshr");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvlshr, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvlshr" << std::endl;
        return z3::lshr(args[0], args[1]);
    }

    // Add bvashr operator
    Sy2CPP::EitherIdentifier bvashr = Sy2CPP::get_simple_id_from_str("bvashr");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvashr, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvashr" << std::endl;
        return z3::ashr(args[0], args[1]);
    }

    /* Arithmetic chainable */
    // Add bvand operator
    Sy2CPP::EitherIdentifier bvand = Sy2CPP::get_simple_id_from_str("bvand");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvand, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvand" << std::endl;
        return z3::operator&(args[0], args[1]);
    }

    // Add bvor operator
    Sy2CPP::EitherIdentifier bvor = Sy2CPP::get_simple_id_from_str("bvor");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvor, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvor" << std::endl;
        return z3::operator|(args[0], args[1]);
    }

    // Add bvnand operator
    Sy2CPP::EitherIdentifier bvnand = Sy2CPP::get_simple_id_from_str("bvnand");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvnand, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvnand" << std::endl;
        return ~(z3::operator&(args[0], args[1]));
    }

    // Add bvnor operator
    Sy2CPP::EitherIdentifier bvnor = Sy2CPP::get_simple_id_from_str("bvnor");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvnor, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvnor" << std::endl;
        return ~(z3::operator|(args[0], args[1]));
    }

    // Add bvxor operator
    Sy2CPP::EitherIdentifier bvxor = Sy2CPP::get_simple_id_from_str("bvxor");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvxor, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvxor" << std::endl;
        return z3::operator^(args[0], args[1]);
    }

    // Add bvxnor operator
    Sy2CPP::EitherIdentifier bvxnor = Sy2CPP::get_simple_id_from_str("bvxnor");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvxnor, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvxnor" << std::endl;
        return ~(z3::operator^(args[0], args[1]));
    }

    // Add bvadd operator
    Sy2CPP::EitherIdentifier bvadd = Sy2CPP::get_simple_id_from_str("bvadd");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvadd, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvadd" << std::endl;
        return z3::operator+(args[0], args[1]);
    }

    // Add bvsub operator
    Sy2CPP::EitherIdentifier bvsub = Sy2CPP::get_simple_id_from_str("bvsub");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsub, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvsub" << std::endl;
        return z3::operator-(args[0], args[1]);
    }

    // Add bvmul operator
    Sy2CPP::EitherIdentifier bvmul = Sy2CPP::get_simple_id_from_str("bvmul");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvmul, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvmul" << std::endl;
        return z3::operator*(args[0], args[1]);
    }

    // Add bvudiv operator
    Sy2CPP::EitherIdentifier bvudiv = Sy2CPP::get_simple_id_from_str("bvudiv");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvudiv, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvudiv" << std::endl;
        return z3::udiv(args[0], args[1]);
    }

    // Add bvsdiv operator
    Sy2CPP::EitherIdentifier bvsdiv = Sy2CPP::get_simple_id_from_str("bvsdiv");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsdiv, arg_list2B, bv_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        std::cout << "bvsdiv" << std::endl;
        return z3::operator/(args[0], args[1]);
    }

    /* Comparison */
    // Add bvult operator
    Sy2CPP::EitherIdentifier bvult = Sy2CPP::get_simple_id_from_str("bvult");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvult, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvult" << std::endl;
        return z3::ult(args[0], args[1]);
    }

    // Add bvule operator
    Sy2CPP::EitherIdentifier bvule = Sy2CPP::get_simple_id_from_str("bvule");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvule, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvule" << std::endl;
        return z3::ule(args[0], args[1]);
    }

    // Add bvugt operator
    Sy2CPP::EitherIdentifier bvugt = Sy2CPP::get_simple_id_from_str("bvugt");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvugt, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvugt" << std::endl;
        return z3::ugt(args[0], args[1]);
    }

    // Add bvuge operator
    Sy2CPP::EitherIdentifier bvuge = Sy2CPP::get_simple_id_from_str("bvuge");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvuge, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvuge" << std::endl;
        return z3::uge(args[0], args[1]);
    }

    // Add bvslt operator
    Sy2CPP::EitherIdentifier bvslt = Sy2CPP::get_simple_id_from_str("bvslt");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvslt, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvslt" << std::endl;
        return z3::slt(args[0], args[1]);
    }

    // Add bvsle operator
    Sy2CPP::EitherIdentifier bvsle = Sy2CPP::get_simple_id_from_str("bvsle");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsle, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvsle" << std::endl;
        return z3::sle(args[0], args[1]);
    }

    // Add bvsgt operator
    Sy2CPP::EitherIdentifier bvsgt = Sy2CPP::get_simple_id_from_str("bvsgt");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsgt, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvsgt" << std::endl;
        return z3::sgt(args[0], args[1]);
    }

    // Add bvsge operator
    Sy2CPP::EitherIdentifier bvsge = Sy2CPP::get_simple_id_from_str("bvsge");
    if (descriptor == Sy2CPP::FunctionDescriptor(bvsge, arg_list2B, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        std::cout << "bvsge" << std::endl;
        return z3::sge(args[0], args[1]);
    }

    /* #############################
    *Yixuan
    *end
    *###############################
    */


    //LIA resolver operations
    Sy2CPP::EitherSort int_sort = Sy2CPP::LIAResolver::get_int_sort();
    std::initializer_list<Sy2CPP::EitherSort> arg_list1I{int_sort};
    std::initializer_list<Sy2CPP::EitherSort> arg_list2I{int_sort, int_sort};

    Sy2CPP::EitherIdentifier uminus = Sy2CPP::get_simple_id_from_str("-");
    if (descriptor == Sy2CPP::FunctionDescriptor(uminus, arg_list1I, int_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return -args[0];
    }

    // Add - operator
    Sy2CPP::EitherIdentifier minus = Sy2CPP::get_simple_id_from_str("-");
    if (descriptor == Sy2CPP::FunctionDescriptor(minus, arg_list2I, int_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return args[0] - args[1];
    }

    // Add abs operator
    Sy2CPP::EitherIdentifier abs = Sy2CPP::get_simple_id_from_str("abs");
    if (descriptor == Sy2CPP::FunctionDescriptor(abs, arg_list1I, int_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return z3::abs(args[0]);
    }

    // Add mod  operator
    Sy2CPP::EitherIdentifier mod = Sy2CPP::get_simple_id_from_str("mod");
    if (descriptor == Sy2CPP::FunctionDescriptor(mod, arg_list2I, int_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return z3::mod(args[0], args[1]);
    }

    // Add + operator
    Sy2CPP::EitherIdentifier plus = Sy2CPP::get_simple_id_from_str("+");
    if (descriptor == Sy2CPP::FunctionDescriptor(plus, arg_list1I, int_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        z3::expr res = args[0] + args[1] ;
        for (int i = 2; i < args.size(); ++i) {
            res = res + args[i];
        }
        return res;
    }

    // Add * operator
    Sy2CPP::EitherIdentifier times = Sy2CPP::get_simple_id_from_str("*");
    if (descriptor == Sy2CPP::FunctionDescriptor(times, arg_list1I, int_sort, Sy2CPP::FunctionKind::THEORY, true)) {
        z3::expr res = args[0] * args[1] ;
        for (int i = 2; i < args.size(); ++i) {
            res = res * args[i];
        }
        return res;
    }

    // Add div operator
    Sy2CPP::EitherIdentifier div = Sy2CPP::get_simple_id_from_str("div");
    if (descriptor == Sy2CPP::FunctionDescriptor(div, arg_list2I, int_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return args[0] / args[1];
    }

    // Add < operator
    Sy2CPP::EitherIdentifier less = Sy2CPP::get_simple_id_from_str("<");
    if (descriptor == Sy2CPP::FunctionDescriptor(less, arg_list2I, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return args[0] < args [1];
    }

    // Add <= operator
    Sy2CPP::EitherIdentifier leq = Sy2CPP::get_simple_id_from_str("<=");
    if (descriptor == Sy2CPP::FunctionDescriptor(leq, arg_list2I, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return args[0] <= args[1];
    }

    // Add > operator
    Sy2CPP::EitherIdentifier ge = Sy2CPP::get_simple_id_from_str(">");
    if (descriptor == Sy2CPP::FunctionDescriptor(ge, arg_list2I, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return args[0] > args[1];
    }

    // Add >= operator
    Sy2CPP::EitherIdentifier geq = Sy2CPP::get_simple_id_from_str(">=");
    if (descriptor == Sy2CPP::FunctionDescriptor(geq, arg_list2I, bool_sort, Sy2CPP::FunctionKind::THEORY, false)) {
        return args[0] >= args[1];
    }

    return std::nullopt;
}

z3::check_result
SyGuSZ3SolverReprBuilder::check_candidate(Sy2CPP::FunctionDescriptor& descr, Sy2CPP::Term* term ){
    //Generate expression that is to be checked for unsat (i.e. negated constraints)
    z3::expr neg_constr = this->negated_constraints[0]; //For now, we only support one check synth command
    z3::expr_vector synth_expressions(context);
    z3::func_decl_vector synth_decls(context);
    auto vars = this->synth_fun_arguments.at(descr);
    for (auto& indexed_var : vars) {
        this->push_bd_var_stack(indexed_var.first, indexed_var.second);
        this->symbolTable.push_symbol_stack(indexed_var.first);
    }

    // with pushed var stack we generate the correct function term and add term and corresponding declaration to
    // the vectors. After that we pop vars from stack again
    auto function_term = std::any_cast<z3::expr>(term->accept(*this));
    synth_expressions.push_back(function_term);
    synth_decls.push_back(this->get_function_declaration(descr));
    this->pop_bd_var_stack(vars.size());
    this->symbolTable.pop_symbol_stack(vars.size());

    neg_constr = neg_constr.substitute(synth_decls, synth_expressions);
    std::optional<z3::model> cegis_res = check_cegis_previous_models(neg_constr);
    if (cegis_res) { // one of the previous models was correct
        return z3::sat;
    }

    // remove previous constraints if there are any
    solver.reset();
    solver.add(neg_constr);

    z3::check_result res = solver.check(assumptions);
    if (res == z3::sat) {  // add to CEGIS
        this->cegis_models.push_back(solver.get_model());
    }

    return res;
}

//TODO, do we handle assumptions correctly, I don't think so. (Note, that this does not inhibit the soundness of this procedure as B ==> A -> B), but it may not be very efficient.
std::optional<z3::model> SyGuSZ3SolverReprBuilder::check_cegis_previous_models(const z3::expr& expr) {
    for (const auto& model : cegis_models) {
        z3::expr e_cpy = expr;
        z3::expr_vector substs(context);
        for (const auto & free_var : free_variables) {
            substs.push_back(model.eval(free_var));
        }
        e_cpy = e_cpy.substitute(free_variables, substs).simplify();
        if (e_cpy.is_true()) {
            return {model};
        }
    }
    return std::nullopt;
}
