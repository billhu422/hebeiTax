#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

#Include ../utils.ahk
#include log4ahk.ahk
;OutputDebug, %A_Now%: Because the window "%TargetWindowTitle%" did not exist, the process was aborted.
ListVars
engine:= New log4ahk

a:="123132123123"

ListVars a
log:=engine.getLogger()
log.debug("debug Message")
log.info("info message")
 