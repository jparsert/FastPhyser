//
// Created by julian on 20.06.23.
//

#ifndef FASTPHYSER_AZ_PREFETCH_H
#define FASTPHYSER_AZ_PREFETCH_H

#include <Sy2CPP.h>
#include "../verification/smt_problem_builder.h"
#include "../candidate_tree.h"

#include <unordered_map>

#include <iostream>                  // for std::cout
#include <algorithm>                 // for std::for_each
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>
#include "search.h"
#include "../guidance/Value.h"
#include "../guidance/Policy.h"
#include "../Features.h"
#include "../BGLHelper.h"
#include <boost/graph/lookup_edge.hpp>
#include <boost/program_options.hpp>

#include <chrono>

#include "search.h"

class AZ_Prefetch : public AbstractSearch {


private:
    std::string problem;
    std::shared_ptr<Sy2CPP::Problem> ast;
    std::shared_ptr<Sy2CPP::SymbolTable> symbol_table;

    std::shared_ptr<SyGuSZ3SolverReprBuilder> verifier;
    std::shared_ptr<CandidateTreeGenerator> tree_generator;

    std::vector<float> specification_features;

    Graph graph;
    std::vector<VertDescr> path;


    // objects for learning
    std::optional<AbstractFeatureGenerator*> features;
    std::optional<PolicyFunction*> policy;
    std::optional<ValueFunction*> value;

    Sy2CPP::SyGuSSolution solution = std::nullopt;

    // search timeout etc.
    std::chrono::time_point<std::chrono::steady_clock, std::chrono::nanoseconds> start_time;
    bool timed_out = false;

    //maximum search time
    std::chrono::seconds timeout;


    boost::program_options::variables_map arg_map;

    // (pseudo) Random number generator
    std::mt19937 random_generator;


    /**
     * Does rollouts from node
     * @param node
     * @return true if solution was found.
    */
    bool rollout(const VertDescr& node);

    std::vector<float> multi_policy(const std::vector<EdgeDescr>& edges);

    std::vector<float> multi_value(const std::vector<VertDescr>& successors);

    float uct(const VertDescr& source, const VertDescr& target) const;

    void back_propagate(const std::vector<VertDescr>& path, const float& value);

    VertDescr get_best_successor_by_uct(const VertDescr& node) const;

    void query_guidance_data(const VertDescr& i);

public:

    explicit AZ_Prefetch(const std::string& path,
                       std::optional<AbstractFeatureGenerator*> features,
                       std::optional<PolicyFunction*> pol,
                       std::optional<ValueFunction*> val,
                       std::chrono::seconds timeout,
                       boost::program_options::variables_map vm,
                       int iteration) :
            problem{path},
            features{features},
            policy{pol},
            value{val},
            timeout{timeout},
            arg_map{std::move(vm)}
    {
        auto pair = Sy2CPP::get_ast_and_symbol_table_from_file(path);
        ast = pair.first;
        symbol_table = pair.second;

        verifier = SyGuSZ3SolverReprBuilder::build(*ast, *symbol_table);
        tree_generator = CandidateTreeGenerator::build(*ast, *symbol_table);

        // init rng generator
        if (arg_map.count("seed")) {
            random_generator = std::mt19937(arg_map["seed"].as<int>() + iteration);
        } else {
            std::random_device rd; // obtain a random number from hardware
            random_generator = std::mt19937(rd()); // seed the generator
        }

        // Generate static features from specification
        if (features) {
            this->specification_features = features.value()->get_specification_features(ast.get());
        }
    }

    bool start_search() override;

    bool update_policy_function() override;

    bool update_value_function() override;

    std::vector<std::pair<std::vector<float>, float>> get_value_data() override;

    std::vector<std::pair<std::vector<float>, float>> get_policy_data() override;

    [[nodiscard]] Sy2CPP::SyGuSSolution get_solution() const override;

    [[nodiscard]] std::string get_problem() const override {return problem;}

    [[nodiscard]] bool search_timed_out() const override  {return timed_out;}

    [[nodiscard]] unsigned long get_graph_size() const override;

    static std::string  get_search_name() {return "AlphaZeroPrefetch";}


};


#endif //FASTPHYSER_AZ_PREFETCH_H
