#cs
	The MIT License (MIT)

	Copyright (c) 2014 Perceval FARAMAZ

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
#ce
#AutoIt3Wrapper_Outfile=bin\AHKSecure.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Description=Safely Opening/Editing AHK Scripts
#AutoIt3Wrapper_Res_Fileversion=1.0.1.0
#AutoIt3Wrapper_Res_LegalCopyright=Copyright (C) 2013 - 2014 Perceval FARAMAZ
#AutoIt3Wrapper_Res_Language=1036
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_Field=Compilation Date|%date%
#AutoIt3Wrapper_Res_Field=Compilation Time|%time%
#AutoIt3Wrapper_Res_Field=Email|perfaram@windowslive.com
#AutoIt3Wrapper_Run_AU3Check=n
Opt('MustDeclareVars', 1)

Global $AppName = "AHK Secure Opening"
#include <AHKSecCommon.au3>
_GUI()