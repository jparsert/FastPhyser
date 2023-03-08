//
// Created by julian on 06.02.23.
//

#include "BalancedBDMonteCarlo.h"
#include "Sy2CPP/AstPrinter.h"
#include "search.h"

bool BalancedBDMonteCarlo::start_search() {

    this->start_time = std::chrono::steady_clock::now();


    VertDescr active_node = this->path[0]; // this is the root node
    std::set<VertDescr> dead_ends;
    for (int i = 0; i < NUM_BIG_STEPS; ++i) {

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
            //std::cout << "\t term: " << Sy2CPP::AstToString::to_string(*graph[vert].term) <<
            //" visits: " << graph[vert].visit_count << " avg. val: " << graph[vert].total_value/static_cast<float>(graph[vert].visit_count) << " uct: " << this->uct(active_node, vert)  << std::endl;
            if (!this->tree_generator->is_leaf(graph[vert].term.get())  and !dead_ends.contains(vert)) {
                next_non_leafs.push_back(vert);
            }
        }

        if (next_non_leafs.empty()) {// backtrack
            //std::cout << "We hit a dead end: " << Sy2CPP::AstToString::to_string(*graph[active_node].term) << std::endl;
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

bool BalancedBDMonteCarlo::rollout(VertDescr node) {
    // Maybe first visit all successors

    for (int i = 0; i < NUM_SMALL_STEPS_BREADTH; ++i) {
        VertDescr current_node = node;
        std::vector<VertDescr> sub_path;

        for (int j = 0; j < NUM_SMALL_STEPS_DEPTH; ++j) {
            auto d = std::chrono::duration_cast<std::chrono::seconds>(std::chrono::steady_clock::now()-start_time);
            if (d > this->timeout) {
                this->timed_out = true;
                return false;
            }
            //increase visit count and sub_path
            sub_path.push_back(current_node);

            if (tree_generator->is_leaf(graph[current_node].term.get())) {
                auto res = verifier->check_candidate(verifier->get_synth_funs()[0], graph[current_node].term.get());

                if (res == z3::unsat) {
                    //std::cout << "Success" << std::endl;
                    this->path.insert(path.end(), sub_path.begin(), sub_path.end());
                    this->solution = tree_generator->get_term_as_solution(graph[current_node].term.get());
                    //std::cout << Sy2CPP::to_string(this->solution);
                    return true;
                } else {
                    graph[current_node].total_value = 0;
                    break;
                }
            }

            // not a leaf node, check if we already expanded this node
            if (!graph[current_node].is_expanded) {
                std::vector<Sy2CPP::TermPtr> successors =
                        tree_generator->generate_leftmost_product_terms(graph[current_node].term.get());

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

            // Choose next node!
            auto range = boost::adjacent_vertices(current_node, graph);
            VertDescr best = arg_max(boost::make_iterator_range(range), [this, &current_node](const auto& vtx){return this->uct(current_node, vtx);});
            current_node = best;
        }
        // back_propagate
        this->back_propagate(sub_path, graph[current_node].total_value);

    }
    return false;
}

std::vector<float> BalancedBDMonteCarlo::multi_policy(VertDescr vtx, const std::vector<VertDescr>& successors) {

    if (this->policy == nullptr or !this->policy.value()->can_predict()) { // default policy
        std::vector<float> res;
        for (auto &x: successors) {
            res.push_back(1.0);
        }
        return res;
    }
    std::vector<float> feats;

    std::vector<float> fst_term = this->features.value()->get_candidate_features(graph[vtx].term.get());
    for (const auto& suc: successors) {
        auto snd_term = this->features.value()->get_candidate_features(graph[suc].term.get());
        concat<float>(feats, this->specification_features);
        concat<float>(feats, fst_term);
        concat<float>(feats, snd_term);
    }

    assert(specification_features.size() + fst_term.size() + fst_term.size() == feats.size()/successors.size());
    return policy.value()->predict(feats, successors.size(), feats.size()/successors.size());
}


std::vector<float> BalancedBDMonteCarlo::multi_value(const std::vector<VertDescr>& nodes) {
    if (this->value == nullptr or !this->value.value()->can_predict()) { // default value
        std::vector<float> res;

        for (auto &x: nodes) {
            res.push_back(static_cast<float>(std::pow(0.95f,
                                                      this->tree_generator->count_non_terminals(graph[x].term.get()))));
        }
        return res;
    }

    std::vector<float> feats;

    for (const auto& term: nodes) {
        auto term_fts = this->features.value()->get_candidate_features(graph[term].term.get());
        concat<float>(feats, specification_features);
        concat<float>(feats, term_fts);
    }

    return policy.value()->predict(feats, nodes.size(), feats.size()/nodes.size());
}


float BalancedBDMonteCarlo::uct(VertDescr source, VertDescr target) {
    auto [edge, flag] = boost::lookup_edge(source, target, graph);
    return calc_uct(graph[target].total_value, graph[source].visit_count, graph[target].visit_count, graph[edge].policy);
}


void BalancedBDMonteCarlo::back_propagate(const std::vector<VertDescr>& propagation_path, float _value) {
    for (const auto& vtx : propagation_path) {
        graph[vtx].visit_count += 1;
        graph[vtx].total_value += _value;
    }
}


bool BalancedBDMonteCarlo::update_policy_function() {
    return true;
}


bool BalancedBDMonteCarlo::update_value_function() {
    return true;
}


std::vector<std::pair<std::vector<float>, float>> BalancedBDMonteCarlo::get_policy_data() {
    std::vector<std::pair<std::vector<float>, float>> data;

    if (!this->features or !this->policy) {
        return {};
    }

    if (!this->solution) {
        return {};
    }

    for (int i = 1; i < this->path.size()-1; ++i) {
        auto fst_term = this->features.value()->get_candidate_features(graph[path[i]].term.get());
        auto snd_term = this->features.value()->get_candidate_features(graph[path[i+1]].term.get());
        auto fts = concat_copy({this->specification_features, fst_term, snd_term});
        if (this->solution) {
            data.emplace_back(fts, std::pow(0.95,this->path.size() - i));
        } else {
            data.emplace_back(fts, 0);
        }

    }

    return data;
}


std::vector<std::pair<std::vector<float>, float>> BalancedBDMonteCarlo::get_value_data() {
    std::vector<std::pair<std::vector<float>, float>> data;

    if (!this->features.has_value() or !this->value.has_value()) {
        return {};
    }

    for (int i = 1; i < this->path.size(); ++i) {

        auto fst_term = this->features.value()->get_candidate_features(graph[path[i]].term.get());
        auto fts = concat_copy({this->specification_features, fst_term});
        if (this->solution) {
            data.emplace_back(fts, std::pow(0.95,this->path.size() - i));
        } else {
            data.emplace_back(fts, 0);
        }
    }

    return data;
}

Sy2CPP::SyGuSSolution BalancedBDMonteCarlo::get_solution() const {
    return this->solution;
}

std::string BalancedBDMonteCarlo::get_problem() const {
    return this->problem;
}

unsigned long BalancedBDMonteCarlo::get_graph_size() const {
    return boost::num_vertices(graph);
}

