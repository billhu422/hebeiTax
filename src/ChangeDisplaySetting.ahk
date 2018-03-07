#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

#Include ../lib/utils.ahk
#Include ../lib/DisplaySetting.ahk
#Include ../lib/AutoHotkey-JSON/JSON.ahk

/**
* Method: GoStandardDisplaySetting
*     修改屏幕分辨率为标准分辨率，分辨率（standardResolution）的配置在../config.json中
* Syntax:
*     str := GoStandardDisplaySetting()
* Parameter(s):
*     str        			  [retval] -  成功为0，失败为errorcode
*/
GoStandardDisplaySetting(){
	FileRead, OutputVar, ../config.json
	if not ErrorLevel  ; Successfully loaded.
	{
		parsed := JSON.Load(OutputVar)
		X := parsed.standardResolution.X
		Y := parsed.standardResolution.Y
		ChangeDisplaySettings(X "|" Y)
	}
	else{
		return %A_LastError%
	}
	
	return 0
}

/**
* Method: RecoverDisplaySetting
*     恢复为客户舒适的分辨率，分辨率（confortableResolution）的配置在../config.json中
* Syntax:
*     str := RecoverDisplaySetting()
* Parameter(s):
*     str        			  [retval] -  成功为0，失败为errorcode
*/

RecoverDisplaySetting(){
	FileRead, OutputVar, ../config.json
	if not ErrorLevel  ; Successfully loaded.
	{
		parsed := JSON.Load(OutputVar)
		X := parsed.confortableResolution.X
		Y := parsed.confortableResolution.Y
		ChangeDisplaySettings(X "|" Y)
	}
	else{
		return %A_LastError%
	}
	
	return 0
}

;example
;GoStandardDisplaySetting()
;Sleep 5000
;RecoverDisplaySetting()
