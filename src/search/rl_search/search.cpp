//
// Created by julian on 13.02.23.
//

#include "search.h"

float calc_uct(float target_val, int source_visits, int target_visits, float policy) {
    float mean_value = target_val/static_cast<float>(target_visits);
    float tmp = std::sqrt(std::log(static_cast<float>(source_visits)) / std::max(static_cast<float>(target_visits), 1.0f));
    return mean_value + 2.0f * policy * tmp;
}