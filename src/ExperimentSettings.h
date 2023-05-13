//
// Created by julian on 13.05.23.
//

#ifndef FASTPHYSER_EXPERIMENTSETTINGS_H
#define FASTPHYSER_EXPERIMENTSETTINGS_H

#include <boost/program_options.hpp>

#include <random>
#include <utility>


class ExperimentSettings {

    boost::program_options::variables_map program_options;


    std::random_device rd; // obtain a random number from hardware
    std::mt19937 gen; // seed the generator

public:

    explicit ExperimentSettings(boost::program_options::variables_map po): program_options(std::move(po)) {
        if (program_options.count("seed")) {
            gen = std::mt19937(program_options["seed"].as<int>());
        } else {
            gen = std::mt19937(rd());
        }
    }

    std::mt19937& get_random_generator() {return this->gen;}

    boost::program_options::variables_map& get_variable_map() {return this->program_options;}


};


#endif //FASTPHYSER_EXPERIMENTSETTINGS_H
