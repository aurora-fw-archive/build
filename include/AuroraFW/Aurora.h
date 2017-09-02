/****************************************************************************
** ┌─┐┬ ┬┬─┐┌─┐┬─┐┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┬ ┬┌─┐┬─┐┬┌─
** ├─┤│ │├┬┘│ │├┬┘├─┤  ├┤ ├┬┘├─┤│││├┤ ││││ │├┬┘├┴┐
** ┴ ┴└─┘┴└─└─┘┴└─┴ ┴  └  ┴└─┴ ┴┴ ┴└─┘└┴┘└─┘┴└─┴ ┴
** A Powerful General Purpose Framework
** More information in: https://aurora-fw.github.io/
**
** Copyright (C) 2017 Aurora Framework, All rights reserved.
**
** This file is part of the Aurora Framework. This framework is free
** software; you can redistribute it and/or modify it under the terms of
** the GNU Lesser General Public License version 3 as published by the
** Free Software Foundation and appearing in the file LICENSE included in
** the packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
****************************************************************************/

#ifndef AURORAFW_AURORA_H
#define AURORAFW_AURORA_H

#include <AuroraFW/Global.h>

// Core
#include <AuroraFW/Core/Application.h>
#include <AuroraFW/Core/Debug.h>

// Crypto
#include <AuroraFW/Crypto/AES.h>

// GUI
#include <AuroraFW/GUI/Window.h>
#include <AuroraFW/GUI/Label.h>
#include <AuroraFW/GUI/Button.h>
#include <AuroraFW/GUI/Layout.h>
#include <AuroraFW/GUI/Application.h>

// Shell
#include <AuroraFW/CLI/Log.h>
#include <AuroraFW/CLI/Color.h>
#include <AuroraFW/CLI/Output.h>
#include <AuroraFW/CLI/Input.h>

// Lib
#include <AuroraFW/TLib/Target.h>
#include <AuroraFW/TLib/Type.h>
#include <AuroraFW/TLib/Endian.h>
#include <AuroraFW/TLib/String.h>

// Information
#include <AuroraFW/Info/RAM.h>
#include <AuroraFW/Info/OS.h>

//GEngine
#include <AuroraFW/GEngine/Application.h>
#include <AuroraFW/GEngine/Window.h>
#include <AuroraFW/GEngine/API.h>
#include <AuroraFW/GEngine/OpenGL.h>

//Math
#include <AuroraFW/Math/Vector2D.h>
#include <AuroraFW/Math/Vector3D.h>
#include <AuroraFW/Math/Vector4D.h>

//#include <AuroraFW/Info/GPU.h>
//#include <AuroraFW/Info/CPU.h>
//#include <AuroraFW/Info/System.h>

// Headers for cross-compiler

//#include <AuroraFW/Cross/System/IO.h>
//#include <AuroraFW/Cross/Video/VGA.h>


#endif // AURORAFW_AURORA_H
