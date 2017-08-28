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
    set(MODULES_DIR ${ROOT_DIR}/modules)
    set(APPS_DIR ${ROOT_DIR}/apps)
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
set(MODULE_IO_DIR ${MODULES_DIR}/io)
include(${MODULE_IO_DIR}/module.cmake MODULE_IO_DIR)
set(MODULE_CLI_DIR ${MODULES_DIR}/cli)
include(${MODULE_CLI_DIR}/module.cmake MODULE_CLI_DIR)
set(MODULE_GUI_DIR ${MODULES_DIR}/gui)
include(${MODULE_GUI_DIR}/module.cmake MODULE_GUI_DIR)
set(MODULE_CORE_DIR ${MODULES_DIR}/core)
include(${MODULE_CORE_DIR}/module.cmake MODULE_CORE_DIR)
set(MODULE_AUDIO_DIR ${MODULES_DIR}/audio)
include(${MODULE_AUDIO_DIR}/module.cmake MODULE_AUDIO_DIR)

#Graphics Engine
set(MODULE_GENGINE_CORE_DIR ${MODULES_DIR}/gengine/core)
include(${MODULE_GENGINE_CORE_DIR}/module.cmake MODULE_GENGINE_CORE_DIR)
set(MODULE_GENGINE_OPENGL_DIR ${MODULES_DIR}/gengine/opengl)
include(${MODULE_GENGINE_OPENGL_DIR}/module.cmake MODULE_GENGINE_OPENGL_DIR)
set(MODULE_GENGINE_VULKAN_DIR ${MODULES_DIR}/gengine/vulkan)
include(${MODULE_GENGINE_VULKAN_DIR}/module.cmake MODULE_GENGINE_VULKAN_DIR)
set(MODULE_GENGINE_DIRECT3D_DIR ${MODULES_DIR}/gengine/direct3d)
include(${MODULE_GENGINE_DIRECT3D_DIR}/module.cmake MODULE_GENGINE_DIRECT3D_DIR)

if(CMAKE_BUILD_TYPE MATCHES Debug)
    set(APP_TESTS_TLIB_DIR ${APPS_DIR}/tests/tlib)
    include(${APP_TESTS_TLIB_DIR}/app.cmake APP_TESTS_TLIB_DIR)
    set(APP_TESTS_GUI_DIR ${APPS_DIR}/tests/gui)
    include(${APP_TESTS_GUI_DIR}/app.cmake APP_TESTS_GUI_DIR)
    set(APP_TESTS_GENGINE_DIR ${APPS_DIR}/tests/gengine)
    include(${APP_TESTS_GENGINE_DIR}/app.cmake APP_TESTS_GENGINE_DIR)
    set(APP_TESTS_CRYPTO_DIR ${APPS_DIR}/tests/crypto)
    include(${APP_TESTS_CRYPTO_DIR}/app.cmake APP_TESTS_CRYPTO_DIR)
    set(APP_TESTS_CLI_DIR ${APPS_DIR}/tests/cli)
    include(${APP_TESTS_CLI_DIR}/app.cmake APP_TESTS_CLI_DIR)
endif()

message(STATUS "Build system loaded")
