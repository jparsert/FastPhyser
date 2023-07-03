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



template<class FeatureGenerator>
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
                       std::optional<PolicyFunction*> pol,
                       std::optional<ValueFunction*> val,
                       std::chrono::seconds timeout,
                       boost::program_options::variables_map vm,
                       int iteration) :
            problem{path},
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
        this->specification_features = FeatureGenerator::get_specification_features(ast.get());

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

    static std::string  get_feature_generator_name() {return FeatureGenerator::get_name();}

};




template<class FeatureGenerator>
bool AZ_Prefetch<FeatureGenerator>::start_search() {

    this->start_time = std::chrono::steady_clock::now();

    // needed to make prefetching work since we need a parent node to find children (easier this way)
    VertDescr phantom_root = boost::add_vertex(graph);
    // real root node
    VertDescr active_node = boost::add_vertex(MCNode{false,false,0,0,tree_generator->get_root()->copy()}, graph);
    path.push_back(phantom_root);
    boost::add_edge(phantom_root, active_node, this->graph);

    // not in the original but for resolving dead ends in our case
    std::set<VertDescr> dead_ends;
    for (int i = 0; i < NUM_BIG_STEPS; ++i) {
        this->path.push_back(active_node);
        bool success = this->rollout(active_node);
        if (success) {
            return true;
        }
        auto d = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now()-start_time);
        if (d > this->timeout) {
            this->timed_out = true;
            return false;
        }

        path.push_back(active_node);

        auto range = boost::adjacent_vertices(active_node, graph);
        std::vector<VertDescr> next_non_leafs;
        for (const auto& vert : boost::make_iterator_range(range)) {
            if (!this->tree_generator->is_leaf(graph[vert].term.get())  and !dead_ends.contains(vert)) {
                next_non_leafs.push_back(vert);
            }
        }

        if (next_non_leafs.empty()) {// backtrack excluding dead_ends
            dead_ends.insert(active_node);
            active_node = path[std::max(static_cast<int>(path.size()-3),0)];
        } else {
            VertDescr next_one = max_element_rtb(next_non_leafs,
                                                 [this](const VertDescr &vtx) { return graph[vtx].visit_count; }, random_generator);
            active_node = next_one;
        }

    }

    return false;

}


template<class FeatureGenerator>
bool AZ_Prefetch<FeatureGenerator>::rollout(const VertDescr& root) {

    // do MC simluations with a decay depending on depths
    for (int i = 0; i < std::max(500, static_cast<int>(MCTS_SIMULATIONS * std::pow(ROLLOUT_DECAY_BASE, this->path.size()))); ++i) {
        VertDescr current_node = root;
        std::vector<VertDescr> sub_path;
        sub_path.push_back(current_node);

        // search until first not expanded node/or leaf node (leaf nodes are not expanded)
        while (graph[current_node].is_expanded) {
            current_node = this->get_best_successor_by_uct(current_node);
            sub_path.push_back(current_node);
        }
        // current_node is now the first non-expanded node

        auto d = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now()-start_time);
        if (d > this->timeout) {
            this->timed_out = true;
            return false;
        }


        if (tree_generator->is_leaf(graph[current_node].term.get())) {  // leaf node
            auto res = verifier->check_candidate(verifier->get_synth_funs()[0], graph[current_node].term.get());
            if (res == z3::unsat) {
                this->path.insert(path.end(), sub_path.begin(), sub_path.end());
                this->solution = tree_generator->get_term_as_solution(graph[current_node].term.get());
                return true;
            } else {
                // Propagate value 0 back
                // leaf nodes are not expanded so that the call to get_best_successor_by_uct does not fail.
                graph[current_node].total_value = 0;
            }
        } else { // in case it's not a terminal (i.e. leaf) node

            if (! graph[current_node].valid_value) { // Data has not been fetched yet.
                // should also work for the root node
                VertDescr parent = sub_path.size() > 1 ? sub_path[sub_path.size() - 2] : path[path.size() - 2];
                this->query_guidance_data(parent);
            }
            graph[current_node].is_expanded = true;
        }
        this->back_propagate(sub_path, graph[current_node].total_value);
    }
    return false;
}

template<class FeatureGenerator>
void AZ_Prefetch<FeatureGenerator>::back_propagate(const std::vector<VertDescr> &_path, const float& _value) {
    if (_path.empty()) {
        return;
    }
    // update value and visit count for all along path except end
    for (auto i = 0; i < _path.size() - 1; ++i) {
        graph[_path[i]].visit_count += 1;
        graph[_path[i]].total_value += _value;
    }
    // update visit count for the last one, the value was already set in expansion
    graph[_path[_path.size() - 1]].visit_count += 1;
}

template<class FeatureGenerator>
bool AZ_Prefetch<FeatureGenerator>::update_policy_function() {
    return false;
}

template<class FeatureGenerator>
bool AZ_Prefetch<FeatureGenerator>::update_value_function() {
    return false;
}

template<class FeatureGenerator>
std::vector<float> AZ_Prefetch<FeatureGenerator>::multi_policy(const std::vector<EdgeDescr>& edges) {

    if (edges.empty()) {
        return {};
    }

    if (this->policy == nullptr or !this->policy.value()->can_predict()) { // default policy
        return std::vector<float>(edges.size(), 1.0);

    }

    std::vector<float> feats;
    size_t cols = FeatureGenerator::get_spec_feature_dim() +
            FeatureGenerator::get_candidate_feature_dim() +
            FeatureGenerator::get_candidate_feature_dim();

    auto last_src = boost::source(edges[0], this->graph);
    auto last_src_term = FeatureGenerator::get_candidate_features(graph[last_src].term.get());

    for (const auto &e: edges) {
        VertDescr src = boost::source(e, this->graph);
        VertDescr dest = boost::target(e, this->graph);

        if (src != last_src) {
            last_src = src;
            last_src_term = FeatureGenerator::get_candidate_features(graph[last_src].term.get());
        }

        auto snd_term = FeatureGenerator::get_candidate_features(graph[dest].term.get());
        concat(feats, this->specification_features);
        concat(feats, last_src_term);
        concat(feats, snd_term);
    }

    return policy.value()->predict(feats, edges.size(), cols);
}

template<class FeatureGenerator>
std::vector<float> AZ_Prefetch<FeatureGenerator>::multi_value(const std::vector<VertDescr>& nodes) {
    if (this->value == nullptr or !this->value.value()->can_predict()) { // default value
        std::vector<float> res;

        for (auto &x: nodes) {
            res.push_back(static_cast<float>(std::pow(0.95f,
                                                      this->tree_generator->count_non_terminals(graph[x].term.get()))));
        }
        return res;
    }
    if (nodes.empty()) {
        return {};
    }

    std::vector<float> feats;
    size_t cols = FeatureGenerator::get_spec_feature_dim() +
            FeatureGenerator::get_candidate_feature_dim();

    for (const auto& term: nodes) {
        concat(feats, this->specification_features);
        auto snd_term =FeatureGenerator::get_candidate_features(graph[term].term.get());
        concat(feats, snd_term);
    }
    assert(cols == feats.size()/nodes.size());
    return value.value()->predict(feats, nodes.size(), cols);
}


template<class FeatureGenerator>
float AZ_Prefetch<FeatureGenerator>::uct(const VertDescr& source, const VertDescr& target) const {
    auto [edge, flag] = boost::lookup_edge(source, target, graph);
    return calc_uct(graph[target].total_value, graph[source].visit_count, graph[target].visit_count, graph[edge].policy);
}

template<class FeatureGenerator>
VertDescr AZ_Prefetch<FeatureGenerator>::get_best_successor_by_uct(const VertDescr& node) const {
    auto range = boost::adjacent_vertices(node, graph);
    VertDescr best = arg_max(boost::make_iterator_range(range), [this, &node](const auto& vtx){return this->uct(node, vtx);});
    return best;
}

template<class FeatureGenerator>
std::vector<std::pair<std::vector<float>, float>> AZ_Prefetch<FeatureGenerator>::get_policy_data() {
    std::vector<std::pair<std::vector<float>, float>> data;

    if (!this->policy) {
        return {};
    }

    if (!this->solution) {
        return {};
    }

    for (int i = 2; i < this->path.size()-1; ++i) { // start at 2 to discard root node and phantom root
        auto fst_term = FeatureGenerator::get_candidate_features(graph[path[i]].term.get());
        auto snd_term = FeatureGenerator::get_candidate_features(graph[path[i+1]].term.get());
        auto fts = concat_copy({this->specification_features, fst_term, snd_term});
        data.emplace_back(fts, static_cast<float>(graph[path[i]].visit_count)/std::max(static_cast<float>(get_child_visits_sum(graph, path[i])), 1.0f));
    }

    return data;
}

template<class FeatureGenerator>
std::vector<std::pair<std::vector<float>, float>> AZ_Prefetch<FeatureGenerator>::get_value_data() {
    std::vector<std::pair<std::vector<float>, float>> data;

    if (!this->value.has_value()) {
        return {};
    }

    for (int i = 2; i < this->path.size(); ++i) { // start at 2 to discard root node and phantom root
        auto fst_term = FeatureGenerator::get_candidate_features(graph[path[i]].term.get());
        auto fts = concat_copy({this->specification_features, fst_term});
        if (this->solution) {
            data.emplace_back(fts, std::pow(0.90,this->path.size() - i));
        } else {
            data.emplace_back(fts, 0);
        }
    }

    return data;
}

template<class FeatureGenerator>
Sy2CPP::SyGuSSolution AZ_Prefetch<FeatureGenerator>::get_solution() const {
    return this->solution;
}

template<class FeatureGenerator>
unsigned long AZ_Prefetch<FeatureGenerator>::get_graph_size() const {
    return boost::num_vertices(graph);
}

template<class FeatureGenerator>
void AZ_Prefetch<FeatureGenerator>::query_guidance_data(const VertDescr& parent) {

    auto range = boost::make_iterator_range(boost::adjacent_vertices(parent, graph));

    std::vector<EdgeDescr> new_edges;
    std::vector<VertDescr> new_vertices;

    for (const VertDescr& child : range) {
        std::vector<Sy2CPP::TermPtr> successors = tree_generator->generate_leftmost_product_terms(
                graph[child].term.get());
        for (auto &successor: successors) {
            VertDescr vid = boost::add_vertex(MCNode{false, false, 0, 0.0, successor}, graph);
            auto [eid, flag] = boost::add_edge(child, vid, this->graph);
            if (!flag) {
                std::cout << "Edge could not be added" << std::endl;
            }
            new_edges.push_back(eid);
            new_vertices.push_back(vid);
        }
        graph[child].valid_value = true; // this means that the siblings' values/policies have been fetched.
    }

    // add all policies and values
    auto policies = this->multi_policy(new_edges);
    auto values = this->multi_value(new_vertices);

    for (int k = 0; k < policies.size(); ++k) {
        graph[new_edges[k]] = MCEdge{policies[k]};
        graph[new_vertices[k]].total_value = values[k];
    }
}


#endif //FASTPHYSER_AZ_PREFETCH_H
