//
// Created by julian on 07.02.23.
//

#ifndef FASTPHYSER_UTILITIES_H
#define FASTPHYSER_UTILITIES_H


#include <iostream>
#include <vector>
#include <algorithm>
#include <iterator>
#include <stdexcept>
#include <tuple>
#include <random>
#include <filesystem>

#include "constants.h"


template<typename T>
void concat(std::vector<T>& A, const std::vector<T>& B) {
    A.insert(A.end(), B.begin(), B.end());
}

template<typename T>
std::vector<T> concat_copy(const std::initializer_list<std::vector<T>>& lst) {
    std::vector<T> res;
    for (const auto& e: lst) {
        res.insert(res.end(),e.begin(), e.end());
    }

    return res;
}



// Hash function and constants taken from
// https://stackoverflow.com/questions/20511347/a-good-hash-function-for-a-vector/72073933#72073933
template<typename T>
std::size_t hash_vector(const std::vector<T>& vec) {
    std::size_t seed = vec.size();
    for(const auto& el : vec) {
        size_t x = std::hash<T>{}(el);
        x = ((x >> 16) ^ x) * 0x45d9f3b;
        x = ((x >> 16) ^ x) * 0x45d9f3b;
        x = (x >> 16) ^ x;
        seed ^= x + 0x9e3779b9 + (seed << 6) + (seed >> 2);
    }
    return seed;
}


// Hash function and constants taken from
//  https://stackoverflow.com/questions/2590677/how-do-i-combine-hash-values-in-c0x
template <typename T, typename... Rest>
void hash_combine(std::size_t& seed, const T& v, const Rest&... rest)
{
    seed ^= std::hash<T>{}(v) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
    (hash_combine(seed, rest), ...);
}

template <typename T, typename... Rest>
size_t hash_combine(const T& v, const Rest&... rest)
{
    size_t seed = 0;
    seed ^= std::hash<T>{}(v) + 0x9e3779b9 + (seed << 6) + (seed >> 2);
    (hash_combine(seed, rest), ...);

    return seed;
}


template<typename Container, typename F>
auto arg_max(Container const & c, F && pred) -> decltype(*std::begin(c))
{
    if ( std::begin(c) == std::end(c) ) {
        throw std::invalid_argument("empty container is not allowed.");
    }

    typedef decltype(*std::begin(c)) V;
    auto cmp = [&](V a, V b){ return pred(a) < pred(b); };
    return *std::max_element(std::begin(c), std::end(c), cmp);
}

/**
 * Argmax with random tie break (rtb)
 */
template<typename T, typename Compare>
T max_element_rtb(std::vector<T> cont, Compare pred)
{
    if (cont.empty()){
        throw std::invalid_argument("empty container is not allowed.");
    }

    auto cmp = [&](T a, T b){ return pred(a) < pred(b); };
    T max = *std::max_element(std::begin(cont), std::end(cont), cmp);

    std::vector<int> res;
    for (int i = 0 ; i < cont.size(); ++i) {
        if (pred(cont[i]) == pred(max)){
            res.push_back(i);
        }
    }

    std::random_device rd; // obtain a random number from hardware
    std::mt19937 gen(rd()); // seed the generator
    std::uniform_int_distribution<> distr(0, static_cast<int>(res.size()-1)); // define the range

    return cont[res[distr(gen)]];
}


std::vector<std::string> files_with_suffix_in_dirs(const std::vector<std::string>& dir, const std::string& suffix);


std::string pad_right(std::string const& str, size_t s, char padding = ' ');


std::string pad_left(std::string const& str, size_t s, char padding = ' ');

std::string get_compiled_git_hash();


std::string get_current_timestamp_as_string();
#endif //FASTPHYSER_UTILITIES_H
