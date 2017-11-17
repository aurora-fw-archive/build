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

message(STATUS "Loading framework build system...")

# Set specific framework build variable
set(AURORAFW_IS_BUILDING true)

# Master include
set(CMAKE_MODULE_AURORAFW_DIR ${CMAKE_SOURCE_DIR}/cmake/aurora)
include(${CMAKE_MODULE_AURORAFW_DIR}/module.cmake)

# Options
option(AURORA_BUILD_TEST_APPS "Enable builds for test apps" OFF)

if(CMAKE_BUILD_TYPE MATCHES Debug)
	AURORA_ADD_CMAKE_MODULE("FreeImage" CMAKE ${AURORAFW_ROOT_DIR}/cmake/freeimage)
	AURORA_ADD_CMAKE_MODULE("PortAudio" CMAKE ${AURORAFW_ROOT_DIR}/cmake/portaudio)
	AURORA_ADD_CMAKE_MODULE("sndfile" CMAKE ${AURORAFW_ROOT_DIR}/cmake/sndfile)
endif()

# Modules
AURORA_ADD_CMAKE_MODULE("STDL" MODULE)
AURORA_ADD_CMAKE_MODULE("Core" MODULE)
AURORA_ADD_CMAKE_MODULE("Math" MODULE)
AURORA_ADD_CMAKE_MODULE("Crypto" MODULE)
AURORA_ADD_CMAKE_MODULE("IO" MODULE)
AURORA_ADD_CMAKE_MODULE("CLI" MODULE)
AURORA_ADD_CMAKE_MODULE("GUI" MODULE)
AURORA_ADD_CMAKE_MODULE("Audio" MODULE)
AURORA_ADD_CMAKE_MODULE("NetSocks" MODULE)
AURORA_ADD_CMAKE_MODULE("Image" MODULE)
AURORA_ADD_CMAKE_MODULE("GEngine Core" MODULE)
AURORA_ADD_CMAKE_MODULE("GEngine OpenGL" MODULE)
AURORA_ADD_CMAKE_MODULE("GEngine Vulkan" MODULE)
AURORA_ADD_CMAKE_MODULE("GEngine Direct3D" MODULE)
#AURORA_ADD_CMAKE_MODULE("GEngine Shaders" MODULE)

# Apps
if((CMAKE_BUILD_TYPE MATCHES Debug) OR (AURORA_BUILD_TEST_APPS))
	# Test Apps
	#AURORA_ADD_CMAKE_MODULE("Tests STDL" APP)
	AURORA_ADD_CMAKE_MODULE("Tests GUI" APP)
	AURORA_ADD_CMAKE_MODULE("Tests GEngine" APP)
	AURORA_ADD_CMAKE_MODULE("Tests Crypto" APP)
	AURORA_ADD_CMAKE_MODULE("Tests CLI" APP)
	AURORA_ADD_CMAKE_MODULE("Tests Math" APP)
	AURORA_ADD_CMAKE_MODULE("Tests NetSocks" APP)
	AURORA_ADD_CMAKE_MODULE("Tests Image" APP)
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