# -*- CMake -*-
# ┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─ | Powerful, Scalable and Cross Platform Framework
# ├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐ | @author Luís Ferreira
# ┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴ | @license GNU Public License v3
#  Copyright (c) 2016 - Luís Ferreira. All right reserved
#  More information in: https://github.com/ljmf00/ (Github Page)

# Set minimum version of cmake required to build this project
cmake_minimum_required (VERSION 2.8)
project (aurorafw)

message("┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─ | Powerful, Scalable and Cross Platform Framework")
message("├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐ | @author Luís Ferreira")
message("┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴ | @license GNU Public License v3")
#message(STATUS "Aurora Framework is building...")

# Check for dependencies
find_package(PkgConfig REQUIRED)
find_package(glfw3 3.2 REQUIRED)
find_package(OpenGL REQUIRED)
find_package(GLEW REQUIRED)
find_package(OpenAL REQUIRED)
find_package(Vulkan)
find_package(CUDA)

pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

if (NOT CONFIGURED_ONCE)
    add_definitions(-DAURORA_IS_COMPILING)
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -Wextra -std=c++14")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -Wall -Wextra -std=c++14")
    set(ROOT_DIR .)
    if(CMAKE_BUILD_TYPE MATCHES Debug)
        set(LIBRARY_OUTPUT_PATH ${ROOT_DIR}/bin/dbg)
        set(EXECUTABLE_OUTPUT_PATH ${ROOT_DIR}/bin/dbg)
    else()
        set(LIBRARY_OUTPUT_PATH ${ROOT_DIR}/bin)
        set(EXECUTABLE_OUTPUT_PATH ${ROOT_DIR}/bin)
    endif()
endif()

if(CUDA_FOUND)
    add_definitions(-DAURORA_NVIDIA_CUDA_FOUND)
endif()
if(OPENGL_FOUND)
    add_definitions(-DAURORA_OPENGL_FOUND)
endif()
if(OPENGL_XMESA_FOUND)
    add_definitions(-DAURORA_OPENGL_XMESA_FOUND)
endif()
if(OPENGL_GLU_FOUND)
    add_definitions(-DAURORA_OPENGL_GLU_FOUND)
endif()
if(Vulkan_FOUND)
    add_definitions(-DAURORA_VULKAN_FOUND)
endif()

include_directories(${ROOT_DIR}/build/include)
include_directories(${GTK3_INCLUDE_DIRS} ${OPENGL_INCLUDE_DIRS} ${GLEW_INCLUDE_DIRS})

link_directories(${GTK3_LIBRARY_DIRS})
add_definitions(${GTK3_CFLAGS_OTHER})
