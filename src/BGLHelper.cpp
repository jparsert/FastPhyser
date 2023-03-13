//
// Created by julian on 09.03.23.
//

#include "BGLHelper.h"


std::size_t get_child_visits_sum(Graph& g, VertDescr& vert) {
    auto range = boost::make_iterator_range(boost::adjacent_vertices(vert, g));
    std::size_t size = 0;
    for (VertDescr v : range) {
        size += g[v].visit_count;
    }
    return size;
}