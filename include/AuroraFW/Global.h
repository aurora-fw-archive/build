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

#ifndef AURORAFW_GLOBAL_H
#define AURORAFW_GLOBAL_H

#include <AuroraFW/TLib/Type.h>
#include <AuroraFW/TLib/Target/Platform.h>

#ifndef AURORAFW_
#define AURORAFW_
#endif // AURORAFW_

#ifdef AFW_TARGET_PLATFORM_WINDOWS
	#ifdef AURORAFW_IS_COMPILING
		#define AFW_PREFIX __declspec(dllexport)
	#else
		#define AFW_PREFIX __declspec(dllimport)
	#endif //AURORAFW_IS_COMPILING
#else
	#define AFW_PREFIX
#endif //AFW_TARGET_PLATFORM_WINDOWS

#endif // AURORAFW_GLOBAL_H
