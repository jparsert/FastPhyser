#include "AZ_Prefetch.h"

#include <cmath>
#include "../constants.h"

#include "AstPrinter.h"


bool AZ_Prefetch::start_search() {

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

bool AZ_Prefetch::rollout(const VertDescr& root) {

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

void AZ_Prefetch::back_propagate(const std::vector<VertDescr> &_path, const float& _value) {
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

bool AZ_Prefetch::update_policy_function() {
    return false;
}

bool AZ_Prefetch::update_value_function() {
    return false;
}

std::vector<float> AZ_Prefetch::multi_policy(const std::vector<EdgeDescr>& edges) {

    if (edges.empty()) {
        return {};
    }

    if (this->policy == nullptr or !this->policy.value()->can_predict()) { // default policy
        return std::vector<float>(edges.size(), 1.0);

    }

    std::vector<float> feats;
    size_t cols = this->features.value()->get_spec_feature_dim() +
                  this->features.value()->get_candidate_feature_dim() +
                  this->features.value()->get_candidate_feature_dim();

    auto last_src = boost::source(edges[0], this->graph);
    auto last_src_term = this->features.value()->get_candidate_features(graph[last_src].term.get());

    for (const auto &e: edges) {
        VertDescr src = boost::source(e, this->graph);
        VertDescr dest = boost::target(e, this->graph);

        if (src != last_src) {
            last_src = src;
            last_src_term = this->features.value()->get_candidate_features(graph[last_src].term.get());
        }

        auto snd_term = this->features.value()->get_candidate_features(graph[dest].term.get());
        concat(feats, this->specification_features);
        concat(feats, last_src_term);
        concat(feats, snd_term);
    }

    return policy.value()->predict(feats, edges.size(), cols);
}

std::vector<float> AZ_Prefetch::multi_value(const std::vector<VertDescr>& nodes) {
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
    size_t cols = this->features.value()->get_spec_feature_dim() +
                  this->features.value()->get_candidate_feature_dim();

    for (const auto& term: nodes) {
        concat(feats, this->specification_features);
        auto snd_term = this->features.value()->get_candidate_features(graph[term].term.get());
        concat(feats, snd_term);
    }
    assert(cols == feats.size()/nodes.size());
    return value.value()->predict(feats, nodes.size(), cols);
}


float AZ_Prefetch::uct(const VertDescr& source, const VertDescr& target) const {
    auto [edge, flag] = boost::lookup_edge(source, target, graph);
    return calc_uct(graph[target].total_value, graph[source].visit_count, graph[target].visit_count, graph[edge].policy);
}

VertDescr AZ_Prefetch::get_best_successor_by_uct(const VertDescr& node) const {
    auto range = boost::adjacent_vertices(node, graph);
    VertDescr best = arg_max(boost::make_iterator_range(range), [this, &node](const auto& vtx){return this->uct(node, vtx);});
    return best;
}

std::vector<std::pair<std::vector<float>, float>> AZ_Prefetch::get_policy_data() {
    std::vector<std::pair<std::vector<float>, float>> data;

    if (!this->features or !this->policy) {
        return {};
    }

    if (!this->solution) {
        return {};
    }

    for (int i = 2; i < this->path.size()-1; ++i) { // start at 2 to discard root node and phantom root
        auto fst_term = this->features.value()->get_candidate_features(graph[path[i]].term.get());
        auto snd_term = this->features.value()->get_candidate_features(graph[path[i+1]].term.get());
        auto fts = concat_copy({this->specification_features, fst_term, snd_term});
        data.emplace_back(fts, static_cast<float>(graph[path[i]].visit_count)/std::max(static_cast<float>(get_child_visits_sum(graph, path[i])), 1.0f));
    }

    return data;
}

std::vector<std::pair<std::vector<float>, float>> AZ_Prefetch::get_value_data() {
    std::vector<std::pair<std::vector<float>, float>> data;

    if (!this->features.has_value() or !this->value.has_value()) {
        return {};
    }

    for (int i = 2; i < this->path.size(); ++i) { // start at 2 to discard root node and phantom root
        auto fst_term = this->features.value()->get_candidate_features(graph[path[i]].term.get());
        auto fts = concat_copy({this->specification_features, fst_term});
        if (this->solution) {
            data.emplace_back(fts, std::pow(0.90,this->path.size() - i));
        } else {
            data.emplace_back(fts, 0);
        }
    }

    return data;
}

Sy2CPP::SyGuSSolution AZ_Prefetch::get_solution() const {
    return this->solution;
}

unsigned long AZ_Prefetch::get_graph_size() const {
    return boost::num_vertices(graph);
}

void AZ_Prefetch::query_guidance_data(const VertDescr& parent) {

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

