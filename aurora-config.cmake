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

#Greetings
message("┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─")
message("├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐")
message("┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴")
message("A Powerful General Purpose Framework")
message("More information in: https://aurora-fw.github.io/\n")

option(AURORA_PRECOMPILE_HEADERS "Enable precompilation of headers" OFF)

option(AURORA_FORCE_STDLIB "Force compilation with standard libraries" OFF)
option(AURORA_FORCE_NO_STDLIB "Force compilation without standard libraries" OFF)
option(AURORA_STDLIB_CC "Compile with C standard library" ON)
option(AURORA_STDLIB_CXX "Compile with C++ standard template library" ON)
option(AURORA_PCH "Enable experimental feature: Pre-compiled headers" OFF)

#General Flags
if (NOT CONFIGURED_ONCE)
	if(CMAKE_GENERATOR MATCHES "Ninja")
		set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fdiagnostics-color")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fdiagnostics-color")
	endif()
	#Add flag for AFW_EXPORT
	if(AURORA_FORCE_STDLIB)
		add_definitions(-DAFW__FORCE_STDLIB)
	elseif(AURORA_FORCE_NO_STDLIB)
		add_definitions(-nostartfiles -nodefaultlibs -nostdlib -DAFW__FORCE_NO_STDLIB)
	endif()
	if(AURORA_STDLIB_CXX)
		add_definitions(-DAFW__FORCE_STDLIB_CXX)
	else()
		set(CMAKE_CXX_COMPILER ${CMAKE_C_COMPILER})
		add_definitions(-DAFW__FORCE_NO_STDLIB_CXX)
	endif()
	if(AURORA_STDLIB_CC)
		add_definitions(-DAFW__FORCE_STDLIB_CC)
	else()
		add_definitions(-nostdlib -DAFW__FORCE_NO_STDLIB_CC)
	endif()

	add_definitions(-DAFW__COMPILING)
	#C++ 17 Standard Revision
	set_property(GLOBAL PROPERTY CXX_STANDARD 17)
	set_property(GLOBAL PROPERTY CXX_STANDARD_REQUIRED ON)
	if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
		#Add custom flags to the CXX compiler
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Og -g3 -Wall -Wextra -Wformat -pedantic -Wdouble-promotion -std=c++17")
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -g0 -Werror -std=c++17")
	elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
		#Add custom flags to the CXX compiler
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Og -g3 -Wall -Wextra -Wformat -pedantic -Wdouble-promotion -std=c++1z")
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -g0 -Werror -std=c++1z")
	endif()
	#Aurora specific flags
	set(AURORAFW_ROOT_DIR ${CMAKE_SOURCE_DIR})

	#Define output directory
	if(CMAKE_BUILD_TYPE MATCHES Debug)
		set(LIBRARY_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin/dbg)
		set(EXECUTABLE_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin/dbg)
	else()
		set(LIBRARY_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin)
		set(EXECUTABLE_OUTPUT_PATH ${AURORAFW_ROOT_DIR}/bin)
	endif()
endif()

# Variable:
# PCHSupport_FOUND
#
# Macro:
# ADD_PRECOMPILED_HEADER
IF(CMAKE_COMPILER_IS_GNUCXX)
EXEC_PROGRAM(
	${CMAKE_CXX_COMPILER}
	ARGS			--version
	OUTPUT_VARIABLE _compiler_output)
STRING(REGEX REPLACE ".* ([0-9]\\.[0-9]\\.[0-9]) .*" "\\1"
	   gcc_compiler_version ${_compiler_output})
#MESSAGE("GCC Version: ${gcc_compiler_version}")
IF(gcc_compiler_version MATCHES "4\\.[0-9]\\.[0-9]")
	SET(PCHSupport_FOUND TRUE)
ELSE(gcc_compiler_version MATCHES "4\\.[0-9]\\.[0-9]")
	IF(gcc_compiler_version MATCHES "3\\.4\\.[0-9]")
		SET(PCHSupport_FOUND TRUE)
	ENDIF(gcc_compiler_version MATCHES "3\\.4\\.[0-9]")
ENDIF(gcc_compiler_version MATCHES "4\\.[0-9]\\.[0-9]")
ENDIF(CMAKE_COMPILER_IS_GNUCXX)

MACRO(ADD_PRECOMPILED_HEADER _targetName _input )

IF(NOT CMAKE_BUILD_TYPE)
	MESSAGE(FATAL_ERROR 
		"This is the ADD_PRECOMPILED_HEADER macro. "
		"You must set CMAKE_BUILD_TYPE!"
	)
ENDIF(NOT CMAKE_BUILD_TYPE)

foreach(_input_file ${_input})
GET_FILENAME_COMPONENT(_name ${_input_file} NAME)
GET_FILENAME_COMPONENT(_path ${_input_file} PATH)
get_filename_component(_result ${_path} ABSOLUTE)
string(REPLACE "${CMAKE_SOURCE_DIR}/" "" _relative_path "${_path}")
SET(_outdir "${CMAKE_SOURCE_DIR}/CMakeFiles/${_targetName}.dir/pch/${_relative_path}")
SET(_output "${_outdir}/${_name}.gch")

list(APPEND _output_list ${_output})
string(CONCAT _output_list_include "-include ${_output} ")

MAKE_DIRECTORY(${_outdir})

STRING(TOUPPER "CMAKE_CXX_FLAGS_${CMAKE_BUILD_TYPE}" _flags_var_name)
SET(_compile_FLAGS ${${_flags_var_name}})

GET_DIRECTORY_PROPERTY(_directory_flags INCLUDE_DIRECTORIES)

SET(_CMAKE_CURRENT_BINARY_DIR_included_before_path FALSE)
FOREACH(item ${_directory_flags})
	IF(${item} STREQUAL ${_path} AND NOT _CMAKE_CURRENT_BINARY_DIR_included_before_path )
		MESSAGE(FATAL_ERROR 
			"This is the ADD_PRECOMPILED_HEADER macro. "
			"CMAKE_CURREN_BINARY_DIR has to mentioned at INCLUDE_DIRECTORIES's argument list before ${_path}, where ${_name} is located"
		)	
	ENDIF(${item} STREQUAL ${_path} AND NOT _CMAKE_CURRENT_BINARY_DIR_included_before_path )

	IF(${item} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
		SET(_CMAKE_CURRENT_BINARY_DIR_included_before_path TRUE)
	ENDIF(${item} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})

	LIST(APPEND _compile_FLAGS "-I${item}")
ENDFOREACH(item)

GET_DIRECTORY_PROPERTY(_directory_flags DEFINITIONS)
LIST(APPEND _compile_FLAGS ${_directory_flags})

SEPARATE_ARGUMENTS(_compile_FLAGS)
#MESSAGE("_compiler_FLAGS: ${_compiler_FLAGS}")
#message("COMMAND ${CMAKE_CXX_COMPILER}	${_compile_FLAGS} -x c++-header -o ${_output} ${_input_file}")

ADD_CUSTOM_COMMAND(
	OUTPUT ${_output}
	COMMAND ${CMAKE_CXX_COMPILER}
			${_compile_FLAGS} -DAFW__PHC
			-x c++-header
			-o ${_output}
			${_input_file}
	DEPENDS ${_input_file} ${_outdir}
)
endforeach(_input_file)

ADD_CUSTOM_TARGET(${_targetName}_gch
	DEPENDS	${_output_list}
)
ADD_DEPENDENCIES(${_targetName} ${_targetName}_gch )
SET_TARGET_PROPERTIES(${_targetName}
	PROPERTIES
		COMPILE_FLAGS "-I${CMAKE_SOURCE_DIR}/CMakeFiles/${_targetName}.dir/pch -Winvalid-pch"
)

ENDMACRO(ADD_PRECOMPILED_HEADER)