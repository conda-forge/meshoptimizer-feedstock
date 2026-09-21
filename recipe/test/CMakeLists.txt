cmake_minimum_required(VERSION 3.15)
project(test_meshoptimizer LANGUAGES CXX)

find_package(meshoptimizer CONFIG REQUIRED)

add_executable(test_meshoptimizer main.cpp)
target_link_libraries(test_meshoptimizer PRIVATE meshoptimizer::meshoptimizer)
