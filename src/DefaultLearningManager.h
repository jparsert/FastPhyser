//
// Created by julian on 13.02.23.
//

#ifndef FASTPHYSER_DEFAULTLEARNINGMANAGER_H
#define FASTPHYSER_DEFAULTLEARNINGMANAGER_H


#include "search/search.h"
#include "Features.h"
#include <memory>
#include <utility>
#include <vector>
#include "guidance/Policy.h"
#include "guidance/Value.h"
#include <optional>
#include <iostream>
#include <boost/program_options.hpp>

/**
 * Could use SFINAE but let's just do ducktyping for now
 * @tparam Search
 */
template<class Search>
class DefaultLearningManager {

    AbstractFeatureGenerator* features;
    PolicyFunction* policy;
    ValueFunction* value;

    int RL_Iterations = 20;

    boost::program_options::variables_map args;

public:
    explicit DefaultLearningManager(AbstractFeatureGenerator* features,
                                    PolicyFunction* pol,
                                    ValueFunction* val,
                                    boost::program_options::variables_map arguments):
            features{features},
            policy{pol},
            value{val},
            args{std::move(arguments)}
    {}



public:

    /**
     * Should probably return some statistics
     */
    void start(std::vector<std::string>& problems);


};



template<class Search>
void DefaultLearningManager<Search>::start(std::vector<std::string>& problems) {

    std::cout << "logging" << std::endl;

    std::vector<std::pair<std::vector<float>,float>> policy_data;
    std::vector<std::pair<std::vector<float>,float>> value_data;


    for (int iteration = 0; iteration < RL_Iterations; ++iteration) {

        std::cout << "###################### ITERATION " << iteration+1 << "/"<<RL_Iterations << " ######################" << std::endl;



        std::vector<std::string> successful;
        std::vector<std::string> not_successful;

        for (auto& problem : problems) {
            std::cout << problem << std::endl;
            Search s(problem, features, policy, value);
            bool res = s.start_search();

            if (res) { // successful search
                successful.push_back(problem);
                //std::cout << "Solution found: " << problem << std::endl;

                //Training data

            } else {
                not_successful.push_back(problem);
                //std::cout << "fail :" << problem << std::endl;
            }

            for (auto& pair : s.get_policy_data()) {
                std::vector<float> tmp;
                for (auto x : pair.first) {
                    tmp.emplace_back(x);
                }
                policy_data.emplace_back(tmp, pair.second);
            }

            for (auto& pair : s.get_value_data()) {
                value_data.emplace_back(pair);
            }


        }

        std::cout << "Training Data: " << "Value Data: " << value_data.size() << "\t" << "Policy Data: " << policy_data.size() << std::endl;

        std::cout << "Solved: " << successful.size() << std::endl;
        std::cout << "Failed: " << not_successful.size() << std::endl;
        std::cout << "Total: " << problems.size() << std::endl;

        // add new training data and train if we have iterations left
        if (iteration < this->RL_Iterations - 1) {
            if (policy) {
                policy->train(policy_data, args, iteration);
            }

            if (value) {
                value->train(value_data, args, iteration);
            }
        }



    }

}


#endif //FASTPHYSER_DEFAULTLEARNINGMANAGER_H