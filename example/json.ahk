#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn

#Include ../lib/utils.ahk
#Include ../lib/DisplaySetting.ahk
#Include ../lib/AutoHotkey-JSON/JSON.ahk

consoleWrite("abc")

GetDistplayResolution(r_left,r_top,r_right,r_bottom)
MsgBox, Left: %r_left% -- Top: %r_top% -- Right: %r_right% -- Bottom %r_bottom%

FileRead, OutputVar, ../config.json
if not ErrorLevel  ; Successfully loaded.
{
	consoleWrite(OutputVar)
	parsed := JSON.Load(OutputVar)
	Result := IsObject(parsed)
	consoleWrite(Result)
	consoleWrite(parsed.CADrivers[1].name)
	consoleWrite(parsed.CADrivers[1].path)
	consoleWrite(parsed.localTax.path)
	consoleWrite(parsed.nationalTax.path)
	path := parsed.localTax.path
	consoleWrite(FileExist(path))
	Run %path%
	;Run,parsed.localTax.path,"G:\",UseErrorLevel
	;consoleWrite(A_LastError)
	;Run,"C:\\Program Files (x86)\\css\\etax\\startup.exe"
	OutputVar = 
}
