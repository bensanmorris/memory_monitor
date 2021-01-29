cmake_minimum_required(VERSION 3.5)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
include(FetchContent)

project(memory_test LANGUAGES CXX)

enable_testing()
FetchContent_Declare(googletest
    GIT_REPOSITORY https://github.com/google/googletest
)
FetchContent_MakeAvailable(googletest)
add_executable(memory_test test.cpp)
target_link_libraries(memory_test gtest gtest_main)
add_test(memory_test memory_test)

