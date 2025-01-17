cmake_minimum_required(VERSION 3.8)
project(plasp CXX)

option(PLASP_BUILD_TESTS "Build unit tests" OFF)
option(PLASP_BUILD_STATIC "Build static binaries" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(GNUInstallDirs)

find_package(Filesystem REQUIRED)
find_package(Threads REQUIRED)

add_library(catch INTERFACE)
target_include_directories(catch
	INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/lib/catch/single_include>"
)

add_library(cxxopts INTERFACE)
target_include_directories(cxxopts
	INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/lib/cxxopts/include>"
)

add_library(variant INTERFACE)
target_include_directories(variant
	INTERFACE "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/lib/variant/include>"
)

if(PLASP_BUILD_STATIC)
	set(CMAKE_EXE_LINKER_FLAGS "-static")
	set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
	set(CMAKE_EXE_LINK_DYNAMIC_C_FLAGS)
	set(CMAKE_EXE_LINK_DYNAMIC_CXX_FLAGS)
endif()

add_subdirectory(lib/tokenize)
add_subdirectory(lib/colorlog)
add_subdirectory(lib/pddl)
add_subdirectory(src)
add_subdirectory(app)
if(PLASP_BUILD_TESTS)
	add_subdirectory(tests)
endif(PLASP_BUILD_TESTS)
