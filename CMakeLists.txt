# -*- CMake -*-
# ┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─ | Powerful, Scalable and Cross Platform Framework
# ├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐ | @author Luís Ferreira
# ┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴ | @license GNU Public License v3
#  Copyright (c) 2016 - Luís Ferreira. All right reserved
#  More information in: https://github.com/ljmf00/ (Github Page)

# Set minimum version of cmake required to build this project
cmake_minimum_required (VERSION 2.8)
project (aurorafw)

message(STATUS "Starting framework build system...")
message("┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─ | Powerful, Scalable and Cross Platform Framework")
message("├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐ | @author Luís Ferreira")
message("┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴ | @license GNU Public License v3")

#General Flags
if (NOT CONFIGURED_ONCE)
    add_definitions(-DAURORA_IS_COMPILING)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Og -g3 -Wall -Wextra -w -std=c++17")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -g0 -std=c++17")
    set(ROOT_DIR ${CMAKE_SOURCE_DIR}/..)
    set(BUILD_DIR ${ROOT_DIR}/build)
    set(MODULES_DIR ${ROOT_DIR}/module)
    if(CMAKE_BUILD_TYPE MATCHES Debug)
        set(LIBRARY_OUTPUT_PATH ${ROOT_DIR}/bin/dbg)
        set(EXECUTABLE_OUTPUT_PATH ${ROOT_DIR}/bin/dbg)
    else()
        set(LIBRARY_OUTPUT_PATH ${ROOT_DIR}/bin)
        set(EXECUTABLE_OUTPUT_PATH ${ROOT_DIR}/bin)
    endif()
endif()

include_directories(${BUILD_DIR}/include)

# Modules
set(MODULE_MATH_DIR ${MODULES_DIR}/math)
include(${MODULE_MATH_DIR}/module.cmake MODULE_MATH_DIR)
set(MODULE_CRYPTO_DIR ${MODULES_DIR}/crypto)
include(${MODULE_CRYPTO_DIR}/module.cmake MODULE_CRYPTO_DIR)
set(MODULE_TLIB_DIR ${MODULES_DIR}/tlib)
include(${MODULE_TLIB_DIR}/module.cmake MODULE_TLIB_DIR)

#Graphics Engine
set(MODULE_GENGINE_CORE_DIR ${MODULES_DIR}/gengine/core)
include(${MODULE_GENGINE_CORE_DIR}/module.cmake MODULE_GENGINE_CORE_DIR)
set(MODULE_GENGINE_OPENGL_DIR ${MODULES_DIR}/gengine/opengl)
include(${MODULE_GENGINE_OPENGL_DIR}/module.cmake MODULE_GENGINE_OPENGL_DIR)
set(MODULE_GENGINE_VULKAN_DIR ${MODULES_DIR}/gengine/vulkan)
include(${MODULE_GENGINE_VULKAN_DIR}/module.cmake MODULE_GENGINE_VULKAN_DIR)

message(STATUS "Build system loaded")
