#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

#Include ../lib/utils.ahk
#Include ../lib/DisplaySetting.ahk
#Include ../lib/AutoHotkey-JSON/JSON.ahk

if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ;ExitApp
}

;example
StartLocalTaxUI()
;Sleep 10000
;ForceStopNationalTaxUI()
/**
* Method: StartLocalTaxUI
*     启动河北地税客户端软件，并进入地税报税页面
* Syntax:
*     str := StartLocalTaxUI()
* Parameter(s):
*     str        			  [retval] -  成功为0，失败为errorcode
*/
StartLocalTaxUI(){
	FileRead, OutputVar, ../config.json
	if  ErrorLevel  {
		return %A_LastError%
	}
	
	;1. 启动国税软件
	parsed := JSON.Load(OutputVar)
	fullPath := parsed.localTax.path
	Run,%fullPath%
	
	;2.等待并确认欢迎页面
    WinWaitActive, ahk_class THuiyunCodeForm, ,20
	if ErrorLevel
	{
		MsgBox, "等待欢迎页面启动超过20秒" 
		return %A_LastError%
	}
	
	;3.点击我已关注
	Sleep 2000
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\res\local\loginout\1.我已关注.bmp",10000)
	;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,..\res\local\loginout\1.我已关注.bmp
	consoleWrite(FoundX)
	consoleWrite(FoundY)
	Sleep 100
	CoordMode,Mouse,Screen
	MouseMove,FoundX+40,FoundY+25,5
	MouseClick,left,,,1
	
	;4.点击CA登录
	Sleep 2000
	WinWaitActive, ahk_class TSignInForm, ,20
	if ErrorLevel
	{
		MsgBox, "等待地税登录框软件启动超过20秒" 
		return %A_LastError%
	}
	
	CoordMode,Pixel,Screen  
	ImageSearchWait(FoundX,FoundY,"..\res\local\loginout\2.CA登录.bmp")
	;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,..\res\local\loginout\2.CA登录.bmp
	
	CoordMode,Mouse,Screen
	MouseMove,FoundX+10,FoundY+10,5
	MouseClick,left,,,1
	
	;5.等待识别CA
	Sleep 5000
	CoordMode,Pixel,Screen 
	ImageSearchWait(FoundX,FoundY,"..\res\local\loginout\3.登录.bmp",20)
	;ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,..\res\local\loginout\3.登录.bmp
	consoleWrite(FoundX)
	consoleWrite(FoundY)
	CoordMode,Mouse,Screen
	MouseMove,FoundX+163,FoundY+75,5
	MouseClick,left,,,1	

	;录入并验证PIN码
	Sleep 1000
	WinWaitActive, ahk_class #32770, ,20
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
	Send {7 down}{7 up}
	Send {8 down}{8 up}
	
	Sleep 100
	Send {Enter}
	
	;关闭通知框
	WinWaitActive, ahk_class TKitSkinFormFrame, ,3
	if ErrorLevel=0
	{
			WinClose,ahk_class TKitSkinFormFrame
	}
}



ForceStopNationalTaxUI(){

	;kill 河北联通CA证书助手
	hwnd_handle := WinExist("河北地税电子税务局客户端")
	WinGet, wpid,PID,ahk_id %hwnd_handle%
    Run, taskkill /f /pid %wpid%,,,
	
	return 0
}

