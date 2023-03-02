//
// Created by julian on 27.02.23.
//

#include "AlphaZero.h"
#include <cmath>


bool AlphaZero::start_search() {

    this->start_time = std::chrono::steady_clock::now();

    // root node
    VertDescr active_node = boost::add_vertex(MCNode{false,0,0,tree_generator->get_root()->copy()}, graph);

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
                                                 [this](const VertDescr &vtx) { return graph[vtx].visit_count; });
            active_node = next_one;
        }

    }
    //std::cout << "Graph Size: " << boost::num_vertices(graph) << std::endl;

    return false;

}

bool AlphaZero::rollout(VertDescr root) {

    // do MC simluations with a decay depending on depths
    for (int i = 0; i < std::max(500, static_cast<int>(MCTS_SIMULATIONS * std::pow(0.9, this->path.size()))); ++i) {
        VertDescr current_node = root;
        std::vector<VertDescr> sub_path;
        sub_path.push_back(current_node);

        // search until first not expanded node
        while (graph[current_node].is_expanded) {
            current_node = this->get_best_successor_by_uct(current_node);
            sub_path.push_back(current_node);
        }
        // current_node is now the first non-expanded node

        if (tree_generator->is_leaf(graph[current_node].term.get())) {  // leaf node
            auto res = verifier->check_candidate(verifier->get_synth_funs()[0], graph[current_node].term.get());

            if (res == z3::unsat) {
                this->path.insert(path.end(), sub_path.begin(), sub_path.end());
                this->solution = tree_generator->get_term_as_solution(graph[current_node].term.get());
                // TODO this->back_propagate(sub_path, 1);
                return true;
            } else {
                // Propagate value 0 back //TODO
                this->back_propagate(sub_path, 0);
            }
        } else { // in case it's not a terminal (i.e. leaf) node
            std::vector<Sy2CPP::TermPtr> successors = tree_generator->generate_leftmost_product_terms(graph[current_node].term.get());

            std::vector<EdgeDescr> edge_indices;
            std::vector<VertDescr> suc_indices;

            for (auto& successor : successors) {
                VertDescr vid = boost::add_vertex(MCNode{false, 0, 0.0, successor}, graph);
                auto [eid, flag] = boost::add_edge(current_node, vid, this->graph);
                if (!flag) {
                    std::cout << "Edge could not be added" << std::endl;
                }
                edge_indices.push_back(eid);
                suc_indices.push_back(vid);
            }

            // add all policies and values
            auto policies = this->multi_policy(current_node, suc_indices);
            auto values = this->multi_value(suc_indices);
            for (int k = 0; k < policies.size(); ++k) {
                graph[edge_indices[k]] = MCEdge{policies[k]};
                graph[suc_indices[k]].total_value = values[k];
            }
            graph[current_node].is_expanded = true;
        }
    }
    return false;
}

void AlphaZero::back_propagate(const std::vector<VertDescr> &_path, float _value) {

}

bool AlphaZero::update_policy_function() {
    return false;
}

bool AlphaZero::update_value_function() {
    return false;
}

std::vector<float> AlphaZero::multi_policy(VertDescr vtx, const std::vector<VertDescr>& successors) {

    if (!this->policy or !this->policy.value()->can_predict()) { // default policy
        std::vector<float> res;
        for (auto &x: successors) {
            res.push_back(1.0);
        }
        return res;
    }
    std::vector<std::vector<float>> feats;

    auto fst_term = this->features.value()->get_candidate_features(graph[vtx].term.get());
    for (const auto& suc: successors) {
        auto snd_term = this->features.value()->get_candidate_features(graph[suc].term.get());
        auto fts = concat_copy({this->specification_features, fst_term, snd_term});
        feats.push_back(fts);
    }

    return policy.value()->predict(feats);
}

std::vector<float> AlphaZero::multi_value(const std::vector<VertDescr>& nodes) {
    if (!this->value or !this->value.value()->can_predict()) { // default value
        std::vector<float> res;

        for (auto &x: nodes) {
            res.push_back(static_cast<float>(std::pow(0.95f,
                                                      this->tree_generator->count_non_terminals(graph[x].term.get()))));
        }
        return res;
    }

    std::vector<std::vector<float>> feats;

    for (const auto& term: nodes) {
        auto snd_term = this->features.value()->get_candidate_features(graph[term].term.get());
        auto fts = concat_copy({this->specification_features, snd_term});
        feats.push_back(fts);
    }

    return value.value()->predict(feats);
}

float AlphaZero::uct(VertDescr source, VertDescr target) {
    auto [edge, flag] = boost::lookup_edge(source, target, graph);
    return calc_uct(graph[target].total_value, graph[source].visit_count, graph[target].visit_count, graph[edge].policy);
}

VertDescr AlphaZero::get_best_successor_by_uct(VertDescr node) {
    auto range = boost::adjacent_vertices(node, graph);
    VertDescr best = arg_max(boost::make_iterator_range(range), [this, &node](const auto& vtx){return this->uct(node, vtx);});
    return best;
}

std::vector<std::pair<std::vector<float>, float>> AlphaZero::get_value_data() {
    return std::vector<std::pair<std::vector<float>, float>>();
}

std::vector<std::pair<std::vector<float>, float>> AlphaZero::get_policy_data() {
    return std::vector<std::pair<std::vector<float>, float>>();
}

