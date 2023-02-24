cmake_minimum_required(VERSION 3.24)

include(FetchContent)
include(ExternalProject)

project(FastPhyser)

set(CMAKE_CXX_STANDARD 20)


# Make sure we have the right version of z3

FetchContent_Declare(z3
        OVERRIDE_FIND_PACKAGE
        GIT_REPOSITORY https://github.com/Z3Prover/z3
        GIT_TAG        3012293c35eadbfd73e5b94adbe50b0cc44ffb83 # z3-4.12.1
)
FetchContent_MakeAvailable(z3)

# probably not necessary
#find_package(z3 REQUIRED)

#functional plus is a library for functional programming idioms in c++
FetchContent_Declare(functional_plus
        GIT_REPOSITORY https://github.com/Dobiasd/FunctionalPlus.git
        GIT_TAG master
)
FetchContent_MakeAvailable(functional_plus)


# progress bars
FetchContent_Declare(progressBar
        GIT_REPOSITORY https://github.com/p-ranav/indicators
        GIT_TAG 6432875
        )
FetchContent_MakeAvailable(progressBar)

# progress bars
FetchContent_Declare(taskflow
        GIT_REPOSITORY git@github.com:taskflow/taskflow
        GIT_TAG v3.5.0

        )
FetchContent_MakeAvailable(taskflow)




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
        GIT_REPOSITORY git@github.com:jparsert/Sy2CPP
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
        src/statistics.cpp)

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
        src/statistics.h)


add_executable(FastPhyser src/main.cpp ${sources} ${headers})


target_compile_definitions(${PROJECT_NAME} PRIVATE
        "-DGIT_COMMIT_HASH=\"${GIT_COMMIT_HASH}\"")

# add required runtime library
include_directories(${Boost_INCLUDE_DIRS} ${progressbar_SOURCE_DIR}/single_include ${taskflow_SOURCE_DIR})

target_link_libraries(FastPhyser PRIVATE
        sy2cpp
        z3
        FunctionalPlus::fplus
        ${Boost_LIBRARIES}
        xgboost::xgboost
        PRIVATE ftxui::screen
        PRIVATE ftxui::dom
        PRIVATE ftxui::component)

#include_directories(${z3_SOURCE_DIR}/src/)
#include_directories(${z3_SOURCE_DIR}/src/api/c++)