cmake_minimum_required(VERSION 3.22.1)

include(FetchContent)
include(ExternalProject)

project(FastPhyser)

set(CMAKE_CXX_STANDARD 20)


# Make sure we have the right version of z3

FetchContent_Declare(z3
        OVERRIDE_FIND_PACKAGE
        GIT_REPOSITORY https://github.com/Z3Prover/z3
        GIT_TAG        z3-4.12.1 # z3-4.12.1
)
FetchContent_MakeAvailable(z3)

# probably not necessary
#find_package(z3 REQUIRED)

#functional plus is a library for functional programming idioms in c++
FetchContent_Declare(functional_plus
        GIT_REPOSITORY https://github.com/Dobiasd/FunctionalPlus
        GIT_TAG c644862
)
FetchContent_MakeAvailable(functional_plus)


FetchContent_Declare(taskflow
        GIT_REPOSITORY https://github.com/taskflow/taskflow
        GIT_TAG v3.5.0
        )
FetchContent_MakeAvailable(taskflow)


#oneTBB
find_package(TBB REQUIRED)



#xgboost
find_package(xgboost REQUIRED)

# Boost libraries
set(Boost_USE_STATIC_LIBS        ON)  # only find static libs
set(Boost_USE_DEBUG_LIBS         OFF) # ignore debug libs and
set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)
find_package(Boost COMPONENTS graph REQUIRED)
find_package(Boost COMPONENTS program_options REQUIRED)

# progress bars
FetchContent_Declare(Sy2CPP
        GIT_REPOSITORY https://github.com/jparsert/Sy2CPP
        GIT_TAG main
)
FetchContent_MakeAvailable(Sy2CPP)
# Make sure sy2pp is installed

find_library(Sy2CPP sy2cpp REQUIRED)


####### NICE GRAPHICS
FetchContent_Declare(ftxui
        GIT_REPOSITORY https://github.com/ArthurSonzogni/ftxui
        GIT_TAG v3.0.0
        )

FetchContent_GetProperties(ftxui)
if(NOT ftxui_POPULATED)
    FetchContent_Populate(ftxui)
    add_subdirectory(${ftxui_SOURCE_DIR} ${ftxui_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()


# JSON Library to write experiment results
FetchContent_Declare(json
        URL https://github.com/nlohmann/json/releases/download/v3.11.2/json.tar.xz
        DOWNLOAD_EXTRACT_TIMESTAMP true
        )
FetchContent_MakeAvailable(json)

#######################################################
####### SO THAT WE CAN REFER TO GIT HASH IN C++ #######
# Get the current working branch
execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_BRANCH
        OUTPUT_STRIP_TRAILING_WHITESPACE)

# Get the latest commit hash
execute_process(
        COMMAND git rev-parse HEAD
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_COMMIT_HASH
        OUTPUT_STRIP_TRAILING_WHITESPACE)


set(sources
        src/verification/smt_problem_builder.cpp
        src/data_structures/UnorderedStack.cpp
        src/data_structures/UnorderedStack.h
        src/candidate_tree.cpp
        src/exceptions/exceptions.cpp
        src/search/BalancedBDMonteCarlo.cpp
        src/utilities.cpp
        src/DefaultLearningManager.cpp
        src/Policy.cpp
        src/Value.cpp
        src/Features.cpp
        src/search/search.cpp src/Policy.cpp
        src/ParallelLearningManager.cpp
        src/statistics.cpp
        src/search/AlphaZero.cpp
        src/strategies.cpp
        src/BGLHelper.cpp
        src/ExperimentSettings.cpp)

set(headers
        src/verification/smt_problem_builder.h
        src/candidate_tree.h
        src/exceptions/exceptions.h
        src/search/BalancedBDMonteCarlo.h
        src/utilities.h
        src/constants.h src/DefaultLearningManager.h
        src/Policy.h
        src/Value.h
        src/Features.h
        src/search/search.h
        src/ParallelLearningManager.h
        src/statistics.h
        src/search/AlphaZero.h
        src/BGLHelper.h
        src/strategies.h
        src/ExperimentSettings.h)


add_executable(FastPhyser src/main.cpp ${sources} ${headers})


target_compile_definitions(${PROJECT_NAME} PRIVATE
        "-DGIT_COMMIT_HASH=\"${GIT_COMMIT_HASH}\"")

# add required runtime library
include_directories(
        ${Boost_INCLUDE_DIRS}
        ${progressbar_SOURCE_DIR}/single_include
        ${taskflow_SOURCE_DIR}
        ${z3_SOURCE_DIR}/src/api/c++
        ${z3_SOURCE_DIR}/src/api)


#link_directories(${z3_BINARY_DIR})

target_link_libraries(FastPhyser PRIVATE
        sy2cpp
        libz3
        FunctionalPlus::fplus
        ${Boost_LIBRARIES}
        xgboost::xgboost
        ftxui::screen
        ftxui::dom
        ftxui::component
        TBB::tbb
        nlohmann_json::nlohmann_json
        )

#include_directories(${z3_SOURCE_DIR}/src/)
#include_directories(${z3_SOURCE_DIR}/src/api/c++)