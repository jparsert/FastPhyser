//
// Created by julian on 27.02.23.
//

#ifndef FASTPHYSER_BGLHELPER_H
#define FASTPHYSER_BGLHELPER_H

#include "Sy2CPP.h"
#include <boost/graph/graph_traits.hpp>
#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/lookup_edge.hpp>



struct MCNode {
    bool is_expanded;
    bool valid_value;
    int visit_count;
    float total_value;
    Sy2CPP::TermPtr term;
};

struct MCEdge {
    float policy;
};

using Graph = boost::adjacency_list<boost::vecS, boost::vecS, boost::directedS, MCNode, MCEdge>;
using VertDescr = boost::graph_traits<Graph>::vertex_descriptor;
using EdgeDescr = boost::graph_traits<Graph>::edge_descriptor;

/**
 * Get the sum of the children's visits counts
 */
std::size_t get_child_visits_sum(const Graph& g, const VertDescr& vert);


/**
 * All siblings of the current node (including the current node)
 * */
//std::vector<VertDescr> get_siblings(VertDescr current_node);

#endif //FASTPHYSER_BGLHELPER_H
