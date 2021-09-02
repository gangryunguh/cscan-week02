cmake_minimum_required(VERSION 2.8)
project(cscan C)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_FLAGS "-g -O0")
set(CMAKE_BUILD_TYPE Debug)

find_package(FLEX)

FLEX_TARGET(cscan cscan.l ${CMAKE_CURRENT_BINARY_DIR}/cscan.yy.c)
include_directories(${CMAKE_CURRENT_BINARY_DIR})

add_executable(cscan ${FLEX_cscan_OUTPUTS})