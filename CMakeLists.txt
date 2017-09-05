# ┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─
# ├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐
# ┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴
# A Powerful General Purpose Framework
# More information in: https://aurora-fw.github.io/
#
# Copyright (C) 2017 Aurora Framework, All rights reserved.
#
# This file is part of the Aurora Framework. This framework is free
# software; you can redistribute it and/or modify it under the terms of
# the GNU Lesser General Public License version 3 as published by the
# Free Software Foundation and appearing in the file LICENSE included in
# the packaging of this file. Please review the following information to
# ensure the GNU Lesser General Public License version 3 requirements
# will be met: https://www.gnu.org/licenses/lgpl-3.0.html.

cmake_minimum_required(VERSION 3.1.0 FATAL_ERROR)
project (aurorafw)

#Greetings
message(STATUS "Starting framework build system...")
message("┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─")
message("├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐")
message("┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴")
message("A Powerful General Purpose Framework")
message("More information in: https://aurora-fw.github.io/\n")

#General Flags
if (NOT CONFIGURED_ONCE)
    #Add flag for AFW_PREFIX
    add_definitions(-DAURORA_IS_COMPILING)
    #C++ 17 Standard Revision
    set_property(GLOBAL PROPERTY CXX_STANDARD 17)
    set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED ON)
    #Add custom flags to the CXX compiler
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Og -g3 -Wall -Wextra -Wformat -pedantic -Wchkp -Wdouble-promotion -std=c++17")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -g0 -Werror -std=c++17")

    #Aurora specific flags
    set(AURORAFW_ROOT_DIR ${CMAKE_SOURCE_DIR})
    set(AURORAFW_BUILD_DIR ${AURORAFW_ROOT_DIR}/build)
    set(AURORAFW_MODULES_DIR ${AURORAFW_ROOT_DIR}/modules)
    set(AURORAFW_APPS_DIR ${AURORAFW_ROOT_DIR}/apps)

    #Define output directory
    if(CMAKE_BUILD_TYPE MATCHES Debug)
        set(LIBRARY_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin/dbg)
        set(EXECUTABLE_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin/dbg)
    else()
        set(LIBRARY_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin)
        set(EXECUTABLE_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin)
    endif()
endif()

#Add Global Aurora include directory
include_directories(${AURORAFW_BUILD_DIR}/include)

# Modules
set(AURORAFW_MODULE_MATH_DIR ${AURORAFW_MODULES_DIR}/math)
include(${AURORAFW_MODULE_MATH_DIR}/module.cmake AURORAFW_MODULE_MATH_DIR)
set(AURORAFW_MODULE_CRYPTO_DIR ${AURORAFW_MODULES_DIR}/crypto)
include(${AURORAFW_MODULE_CRYPTO_DIR}/module.cmake AURORAFW_MODULE_CRYPTO_DIR)
set(AURORAFW_MODULE_TLIB_DIR ${AURORAFW_MODULES_DIR}/tlib)
include(${AURORAFW_MODULE_TLIB_DIR}/module.cmake AURORAFW_MODULE_TLIB_DIR)
set(AURORAFW_MODULE_IO_DIR ${AURORAFW_MODULES_DIR}/io)
include(${AURORAFW_MODULE_IO_DIR}/module.cmake AURORAFW_MODULE_IO_DIR)
set(AURORAFW_MODULE_CLI_DIR ${AURORAFW_MODULES_DIR}/cli)
include(${AURORAFW_MODULE_CLI_DIR}/module.cmake AURORAFW_MODULE_CLI_DIR)
set(AURORAFW_MODULE_GUI_DIR ${AURORAFW_MODULES_DIR}/gui)
include(${AURORAFW_MODULE_GUI_DIR}/module.cmake AURORAFW_MODULE_GUI_DIR)
set(AURORAFW_MODULE_CORE_DIR ${AURORAFW_MODULES_DIR}/core)
include(${AURORAFW_MODULE_CORE_DIR}/module.cmake AURORAFW_MODULE_CORE_DIR)
set(AURORAFW_MODULE_AUDIO_DIR ${AURORAFW_MODULES_DIR}/audio)
include(${AURORAFW_MODULE_AUDIO_DIR}/module.cmake AURORAFW_MODULE_AUDIO_DIR)

#Graphics Engine
set(AURORAFW_MODULE_GENGINE_CORE_DIR ${AURORAFW_MODULES_DIR}/gengine/core)
include(${AURORAFW_MODULE_GENGINE_CORE_DIR}/module.cmake AURORAFW_MODULE_GENGINE_CORE_DIR)
set(AURORAFW_MODULE_GENGINE_OPENGL_DIR ${AURORAFW_MODULES_DIR}/gengine/opengl)
include(${AURORAFW_MODULE_GENGINE_OPENGL_DIR}/module.cmake AURORAFW_MODULE_GENGINE_OPENGL_DIR)
set(AURORAFW_MODULE_GENGINE_VULKAN_DIR ${AURORAFW_MODULES_DIR}/gengine/vulkan)
include(${AURORAFW_MODULE_GENGINE_VULKAN_DIR}/module.cmake AURORAFW_MODULE_GENGINE_VULKAN_DIR)
set(AURORAFW_MODULE_GENGINE_DIRECT3D_DIR ${AURORAFW_MODULES_DIR}/gengine/direct3d)
include(${AURORAFW_MODULE_GENGINE_DIRECT3D_DIR}/module.cmake AURORAFW_MODULE_GENGINE_DIRECT3D_DIR)

#Test Apps
if((CMAKE_BUILD_TYPE MATCHES Debug) OR (AURORA_BUILD_TEST_APPS))
    set(AURORAFW_APP_TESTS_TLIB_DIR ${AURORAFW_APPS_DIR}/tests/tlib)
    include(${AURORAFW_APP_TESTS_TLIB_DIR}/app.cmake AURORAFW_APP_TESTS_TLIB_DIR)
    set(AURORAFW_APP_TESTS_GUI_DIR ${AURORAFW_APPS_DIR}/tests/gui)
    include(${AURORAFW_APP_TESTS_GUI_DIR}/app.cmake AURORAFW_APP_TESTS_GUI_DIR)
    set(AURORAFW_APP_TESTS_GENGINE_DIR ${AURORAFW_APPS_DIR}/tests/gengine)
    include(${AURORAFW_APP_TESTS_GENGINE_DIR}/app.cmake AURORAFW_APP_TESTS_GENGINE_DIR)
    set(AURORAFW_APP_TESTS_CRYPTO_DIR ${AURORAFW_APPS_DIR}/tests/crypto)
    include(${AURORAFW_APP_TESTS_CRYPTO_DIR}/app.cmake AURORAFW_APP_TESTS_CRYPTO_DIR)
    set(AURORAFW_APP_TESTS_CLI_DIR ${AURORAFW_APPS_DIR}/tests/cli)
    include(${AURORAFW_APP_TESTS_CLI_DIR}/app.cmake AURORAFW_APP_TESTS_CLI_DIR)
    set(AURORAFW_APP_TESTS_MATH_DIR ${AURORAFW_APPS_DIR}/tests/math)
    include(${AURORAFW_APP_TESTS_MATH_DIR}/app.cmake AURORAFW_APP_TESTS_MATH_DIR)
endif()

#Doxygen specific configuration
FIND_PACKAGE(Doxygen)
IF (DOXYGEN_FOUND)
    SET(DOXYGEN_INPUT ${AURORAFW_ROOT_DIR}/docs/Doxyfile)
    SET(DOXYGEN_OUTPUT ${AURORAFW_ROOT_DIR}/docs/)

    ADD_CUSTOM_TARGET(documentation
                      COMMAND ${CMAKE_COMMAND} -E echo_append "Building Documentation..."
                      COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
                      COMMAND ${CMAKE_COMMAND} -E echo "Done."
                      WORKING_DIRECTORY ${DOXYGEN_OUTPUT})
ENDIF (DOXYGEN_FOUND)

message(STATUS "Build system loaded")
