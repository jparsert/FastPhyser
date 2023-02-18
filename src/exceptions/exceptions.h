//
// Created by julian on 02.02.23.
//

#ifndef FASTPHYSER_EXCEPTIONS_H
#define FASTPHYSER_EXCEPTIONS_H


#include <string>

class ForbiddenState : std::exception {

private:
    std::string message;

public:
    explicit ForbiddenState(std::string msg) : message{std::move(msg)}{}

    std::string what() {return message;}
};


class XGBoostException : std::exception {

private:
    std::string message;

public:
    explicit XGBoostException(std::string msg) : message{std::move(msg)}{}

    std::string what() {return message;}
};

#endif //FASTPHYSER_EXCEPTIONS_H
