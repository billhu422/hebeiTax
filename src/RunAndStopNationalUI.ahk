﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#Include ../lib/utils.ahk
#Include ../lib/DisplaySetting.ahk
#Include ../lib/AutoHotkey-JSON/JSON.ahk

if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ;ExitApp
}
StartNationalTaxUI()
;ForceStopNationalTaxUI()
;test2()

/**
* Method: StartNationalTaxUI
*     启动河北国税客户端软件，并进入国税报税页面
* Syntax:
*     str := StartNationalTaxUI(applicationFullPath)
* Parameter(s):
*     str        			  [retval] -  成功为0，失败为errorcode
*     applicationFullPath    [in] - 河北客户端软件的全路径
*/

StartNationalTaxUI(){
	FileRead, OutputVar, ../config.json
	if  ErrorLevel  {
		return %A_LastError%
	}
		
	;1. 启动国税软件
	parsed := JSON.Load(OutputVar)
	fullPath := parsed.nationalTax.path
	Run,%fullPath%
	
    WinWaitActive, ahk_class TfrmSubBrowser, ,20
	if ErrorLevel
	{
		MsgBox, "等待国税软件启动超过20秒" 
		return %A_LastError%
	}
	
	Sleep 3000
	
	;2.进入申报模块
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\res\national\loginout\1.申报纳税.bmp")
	consoleWrite(FoundX)
	consoleWrite(FoundY)
	CoordMode,Mouse,Screen
	MouseMove,FoundX+40,FoundY+30,50
	MouseClick,left,,,1
	
	;2.1 录入河北CA的密码
	Sleep 10000
	a := WinExist("A")
	consoleWrite(a)
	WinGetClass, class1, A
	consoleWrite(class1)
	if (class1 = "Tfrm_Login")
	{
		WinActivate
		WinWaitActive,ahk_class %class1%,,20
		if ErrorLevel
		{
			MsgBox, "等待PIN码框启动超过20秒" 
			return %A_LastError%
		}
		Send {1 down}{1 up}
		Send {2 down}{2 up}
		Send {3 down}{3 up}
		Send {4 down}{4 up}
		Send {5 down}{5 up}
		Send {6 down}{6 up}
		
		Sleep 100
		Send {Enter}
	}
	;3.确认核定和发票信息入库
	WinWaitActive, ahk_class Tfrm_DispResult, ,20
	if ErrorLevel
	{
		MsgBox, "等待核定信息入库和更新发票信息超过20秒" 
		return %A_LastError%
	}
	send {Enter}
	;4.最大化办税系统主页面
     WinMaximize,ahk_class Tfrm_MainFrame
	
	Sleep 5000
	;4.申报表填写与编辑
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\res\national\loginout\2.申报表填写与编辑.bmp")
	CoordMode,Mouse,Screen
	MouseMove,FoundX+40,FoundY+30,50
	MouseClick,left,,,1

	return 0
	
}

/**
* Method: StopNationalTaxUI
*     关闭河北国税客户端软件
* Syntax:
*     str := StopNationalTaxUI(password)
* Parameter(s):
*     str         [retval] -  成功为0，失败为errorcode
*     password    [in] - 	  关闭时需要决定是否备份数据，如果密码为"0",则不需要备份，否则备份数据
*/


ForceStopNationalTaxUI(){

	;kill 河北联通CA证书助手
	hwnd_handle := WinExist("河北国税网上办税系统")
	WinGet, wpid,PID,ahk_id %hwnd_handle%
    Run, taskkill /f /pid %wpid%,,,
	
	;kill 河北CA证书助手
	hwnd_handle := WinExist("亿企惠税2.0")
	WinGet, wpid,PID,ahk_id %hwnd_handle%
    Run, taskkill /f /pid %wpid%,,,
	
	return 0
}

test2()
{
	     WinMaximize,ahk_class Tfrm_MainFrame
}
