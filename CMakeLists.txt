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

cmake_minimum_required(VERSION 3.3 FATAL_ERROR)
project (aurorafw)

message(STATUS "Starting framework build system...")

include(${CMAKE_SOURCE_DIR}/build/aurora-config.cmake)

if (NOT CONFIGURED_ONCE)
	set(AURORAFW_BUILD_DIR ${AURORAFW_ROOT_DIR}/build)
	set(AURORAFW_MODULES_DIR ${AURORAFW_ROOT_DIR}/modules)
	set(AURORAFW_APPS_DIR ${AURORAFW_ROOT_DIR}/apps)
endif()

option(AURORA_BUILD_TEST_APPS "Enable builds for test apps" OFF)
option(AURORA_TARGET_DOCUMENTATION "Enable documentation target" ON)
option(AURORA_DOCUMENTATION_AUTO "Enable automatic documentation building" ON)

# Modules
set(AURORAFW_MODULE_STDL_DIR ${AURORAFW_MODULES_DIR}/stdl)
include(${AURORAFW_MODULE_STDL_DIR}/module.cmake)
set(AURORAFW_MODULE_CORE_DIR ${AURORAFW_MODULES_DIR}/core)
include(${AURORAFW_MODULE_CORE_DIR}/module.cmake)
set(AURORAFW_MODULE_MATH_DIR ${AURORAFW_MODULES_DIR}/math)
include(${AURORAFW_MODULE_MATH_DIR}/module.cmake)
set(AURORAFW_MODULE_CRYPTO_DIR ${AURORAFW_MODULES_DIR}/crypto)
include(${AURORAFW_MODULE_CRYPTO_DIR}/module.cmake)
set(AURORAFW_MODULE_IO_DIR ${AURORAFW_MODULES_DIR}/io)
include(${AURORAFW_MODULE_IO_DIR}/module.cmake)
set(AURORAFW_MODULE_CLI_DIR ${AURORAFW_MODULES_DIR}/cli)
include(${AURORAFW_MODULE_CLI_DIR}/module.cmake)
set(AURORAFW_MODULE_GUI_DIR ${AURORAFW_MODULES_DIR}/gui)
include(${AURORAFW_MODULE_GUI_DIR}/module.cmake)
set(AURORAFW_MODULE_AUDIO_DIR ${AURORAFW_MODULES_DIR}/audio)
include(${AURORAFW_MODULE_AUDIO_DIR}/module.cmake)
set(AURORAFW_MODULE_NETSOCKS_DIR ${AURORAFW_MODULES_DIR}/netsocks)
include(${AURORAFW_MODULE_NETSOCKS_DIR}/module.cmake)
set(AURORAFW_MODULE_IMAGE_DIR ${AURORAFW_MODULES_DIR}/image)
include(${AURORAFW_MODULE_IMAGE_DIR}/module.cmake)

#Graphics Engine
set(AURORAFW_MODULE_GENGINE_CORE_DIR ${AURORAFW_MODULES_DIR}/gengine/core)
include(${AURORAFW_MODULE_GENGINE_CORE_DIR}/module.cmake)
set(AURORAFW_MODULE_GENGINE_OPENGL_DIR ${AURORAFW_MODULES_DIR}/gengine/opengl)
include(${AURORAFW_MODULE_GENGINE_OPENGL_DIR}/module.cmake)
set(AURORAFW_MODULE_GENGINE_VULKAN_DIR ${AURORAFW_MODULES_DIR}/gengine/vulkan)
include(${AURORAFW_MODULE_GENGINE_VULKAN_DIR}/module.cmake)
set(AURORAFW_MODULE_GENGINE_DIRECT3D_DIR ${AURORAFW_MODULES_DIR}/gengine/direct3d)
include(${AURORAFW_MODULE_GENGINE_DIRECT3D_DIR}/module.cmake)

#Test Apps
if((CMAKE_BUILD_TYPE MATCHES Debug) OR (AURORA_BUILD_TEST_APPS))
	set(AURORAFW_APP_TESTS_AUDIO_DIR ${AURORAFW_APPS_DIR}/tests/audio)
	include(${AURORAFW_APP_TESTS_AUDIO_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_STDL_DIR ${AURORAFW_APPS_DIR}/tests/tlib)
	include(${AURORAFW_APP_TESTS_STDL_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_GUI_DIR ${AURORAFW_APPS_DIR}/tests/gui)
	include(${AURORAFW_APP_TESTS_GUI_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_GENGINE_DIR ${AURORAFW_APPS_DIR}/tests/gengine)
	include(${AURORAFW_APP_TESTS_GENGINE_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_CRYPTO_DIR ${AURORAFW_APPS_DIR}/tests/crypto)
	include(${AURORAFW_APP_TESTS_CRYPTO_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_CLI_DIR ${AURORAFW_APPS_DIR}/tests/cli)
	include(${AURORAFW_APP_TESTS_CLI_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_MATH_DIR ${AURORAFW_APPS_DIR}/tests/math)
	include(${AURORAFW_APP_TESTS_MATH_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_NETSOCKS_DIR ${AURORAFW_APPS_DIR}/tests/netsocks)
	include(${AURORAFW_APP_TESTS_NETSOCKS_DIR}/app.cmake)
	set(AURORAFW_APP_TESTS_IMAGE_DIR ${AURORAFW_APPS_DIR}/tests/image)
	include(${AURORAFW_APP_TESTS_IMAGE_DIR}/app.cmake)
endif()

#Doxygen specific configuration
if(AURORA_TARGET_DOCUMENTATION)
	FIND_PACKAGE(Doxygen)
	IF (DOXYGEN_FOUND)
		SET(DOXYGEN_INPUT ${AURORAFW_ROOT_DIR}/docs/Doxyfile)
		SET(DOXYGEN_DIR ${AURORAFW_ROOT_DIR}/docs)
		set(DOXYGEN_OUTPUT "${DOXYGEN_DIR}/.out_html;${DOXYGEN_DIR}/.out_xml;${DOXYGEN_DIR}/.out_latex;${DOXYGEN_DIR}/.out_docbook;${DOXYGEN_DIR}/.out_man;${DOXYGEN_DIR}/.out_rtf")
		file(GLOB_RECURSE DOXYGEN_DEPENDS ${AURORAFW_MODULES_DIR}
			*.cpp *.c *.h *.hpp *.md)

		if(AURORA_DOCUMENTATION_AUTO)
			ADD_CUSTOM_COMMAND(OUTPUT ${DOXYGEN_OUTPUT}
							COMMENT "Building Documentation"
							COMMAND ${CMAKE_COMMAND} -E echo_append "Building Documentation..."
							COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
							COMMAND ${CMAKE_COMMAND} -E echo "Done."
							WORKING_DIRECTORY ${DOXYGEN_DIR}
							DEPENDS ${DOXYGEN_DEPENDS})

			ADD_CUSTOM_TARGET(doxygen ALL
							WORKING_DIRECTORY ${DOXYGEN_DIR}
							DEPENDS ${DOXYGEN_OUTPUT})
		endif()

		ADD_CUSTOM_TARGET(documentation
						COMMENT "Building Documentation"
						COMMAND ${CMAKE_COMMAND} -E echo_append "Building Documentation..."
						COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_INPUT}
						COMMAND ${CMAKE_COMMAND} -E echo "Done."
						WORKING_DIRECTORY ${DOXYGEN_DIR})
		
		ADD_CUSTOM_TARGET(clean-docs COMMAND rm -rf "${DOXYGEN_DIR}/.out_*/*")
		ADD_CUSTOM_TARGET(clear COMMAND ${CMAKE_BUILD_TOOL} clean)
		add_dependencies(clear clean-docs)
	ENDIF (DOXYGEN_FOUND)
endif()

message(STATUS "Build system loaded")
