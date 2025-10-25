cmake_minimum_required(VERSION 3.10)
project(chronos LANGUAGES CXX)

set(CMAKE_CXX_STAANDARD 20)
add_compile_options(-Wsign-conversion)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


# TEST SUITE
add_subdirectory(lib/Catch2)
add_executable(${CMAKE_PROJECT_NAME}-test tests/test.cpp)
target_link_libraries(${CMAKE_PROJECT_NAME}-test PRIVATE Catch2::Catch2WithMain)
