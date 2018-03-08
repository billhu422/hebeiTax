#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

#Include ../lib/utils.ahk
#Include ../lib/AutoHotkey-JSON/JSON.ahk

;example
consoleWrite(RunCAS())
;consoleWrite(StopCAs())
;consoleWrite(CAsIsRunning())
if not A_IsAdmin
{
        Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
}

/**
* Method: CAsIsRunning()
*     检测所有的CA驱动是否已经运行，CADriver的配置在../config.json中
* Syntax:
*     str := CAsIsRunning()
* Parameter(s):
*     str        			  [retval] -  未运行=0，程序1运行=1，程序2运行=2
*/

CAsIsRunning(){
	 retValue := 0
	hwnd_handle1 := WinExist("河北联通CA证书助手")
	if hwnd_handle1 {
		retValue := retValue + 1
	}
	
	;kill 河北CA证书助手
	hwnd_handle2 := WinExist("ahk_class #32770")
	if hwnd_handle2 {
		retValue := retValue + 1
	}
	
	return retValue
}


/**
* Method: RunCAs()
*     启动所有CA Drivers，CADriver的配置在../config.json中
* Syntax:
*     str := RunCAs()
* Parameter(s):
*     str        			  [retval] -  已运行=0，有未运行的CA=1，失败为errorcode
*/
RunCAs(){
	FileRead, OutputVar, ../config.json
	if  ErrorLevel 
	{
		return %A_LastError%
	}
	parsed := JSON.Load(OutputVar)
	;consoleWrite(parsed.CADrivers[1].name)
	;consoleWrite(parsed.CADrivers[1].path)
	;consoleWrite(parsed.CADrivers[2].name)
	;consoleWrite(parsed.CADrivers[2].path)
	path1 := parsed.CADrivers[1].path
	path2 := parsed.CADrivers[2].path
	Run, %path1%
	WinWaitActive, 河北联通CA证书助手, , 10
	if ErrorLevel
	{
		MsgBox, WinWait timed out for 河北联通CA证书助手
		return %A_LastError%
	}
	else
		WinMinimize ,ahk_class SINGLE_INSTANCE_APP_CERT ; minimize the window found by WinWaitActive.  无效
	
	Run, %path2%
	WinWaitActive, ahk_class #32770, , 10
	if ErrorLevel
	{
		MsgBox, WinWait timed out for 河北CA数字证书助手
		return %A_LastError%
	}
	else
		Sleep 3000
		WinMinimize, ahk_class #32770 ; minimize the window found by WinWaitActive.
	
	WinMinimizeAll
	return 0
}



/**
* Method: StopCAs()
*     停止所有CA Drivers，CADriver的配置在../config.json中
* Syntax:
*     str := StopCAs()
* Parameter(s):
*     str        			  [retval] -  都停止=0，有运行的CA=1，失败为errorcode
*/

StopCAs(){
	;kill 河北联通CA证书助手
	
	hwnd_handle := WinExist("河北联通CA证书助手")
	WinKill , ahk_id str
	
	WinGet, wpid,PID,ahk_id %hwnd_handle%
    Run, taskkill /f /pid %wpid%,,,
	
	;kill 河北CA证书助手
	hwnd_handle := WinExist("ahk_class #32770")
	WinKill , ahk_id str
	
	WinGet, wpid,PID,ahk_id %hwnd_handle%
    Run, taskkill /f /pid %wpid%,,,
	
	return 0
}


