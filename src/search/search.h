//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_SEARCH_H
#define FASTPHYSER_SEARCH_H

#include <vector>
#include <string>
#include <cmath>


float calc_uct(float target_val, int source_visits, int target_visits, float policy);



class AbstractSearch {

public:
    virtual bool start_search() = 0;

    virtual bool update_policy_function() = 0;

    virtual bool update_value_function() = 0;

    virtual std::vector<std::pair<std::vector<float>, float>> get_value_data() = 0;

    virtual std::vector<std::pair<std::vector<float>, float>> get_policy_data() = 0;

    [[nodiscard]] virtual std::string get_name() const = 0;

};


#endif //FASTPHYSER_SEARCH_H
