cmake_minimum_required(VERSION 3.28)

project(TEST1 VERSION 1.0)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

include_directories(${PROJECT_SOURCE_DIR}/include)

file(GLOB SOURCES "src/*.cpp")
add_executable(TEST1 ${SOURCES})

if(CMAKE_BUILD_TYPE MATCHES debug)
    message(STATUS "Debug build: adding debug flags")
    add_compile_options(-Wall -Wextra -g)
elseif(CMAKE_BUILD_TYPE MATCHES Release)
    message(STATUS "Release build: adding optimization flags")
    add_compile_options(-O3)
endif()