#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.

#Include ../../../lib/utils.ahk
#Include ../../../lib/AutoHotkey-JSON/JSON.ahk
if !A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ;ExitApp
}


;example
;EnterGeneralSet()
;EnterDeclare()
DeclareAll()
/**
* Method: EnterGeneralSet()
*     进入增值税一般纳税人表套
* Syntax:
*     str := EnterGeneralSet()
* Parameter(s):
*     str        			  [retval] -  成功0，失败errorcode
*/

EnterGeneralSet(){
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\..\..\res\national\vat\general\1.增值税表套.bmp")
	CoordMode,Mouse,Screen
	MouseMove,FoundX+1505,FoundY+10,50
	MouseClick,left,,,1
}



/**
* Method: EnterDeclare()
*     进入申报表发送
* Syntax:
*     str := EnterDeclare()
* Parameter(s):
*     str        			  [retval] -  都停止=0，有运行的CA=1，失败为errorcode
*/
EnterDeclare(){
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\..\..\res\national\vat\general\2.进入申报表发送.bmp")
	CoordMode,Mouse,Screen
	MouseMove,FoundX+50,FoundY+10,50
	MouseClick,left,,,1
}

/**
* Method: DeclareAll()
*     发送所有申报表
* Syntax:
*     str := DeclareAll()
* Parameter(s):
*     str        			  [retval] -  都停止=0，有运行的CA=1，失败为errorcode
*/

DeclareAll(){
	;1.全选
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\..\..\res\national\vat\general\3.全选申报表.bmp")
	CoordMode,Mouse,Screen
	MouseMove,FoundX+28,FoundY+118,50
	MouseClick,left,,,1
	
	;2.申报表发送
	CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
	ImageSearchWait(FoundX,FoundY,"..\..\..\res\national\vat\general\4.发送所有申报表.bmp")
	CoordMode,Mouse,Screen
	MouseMove,FoundX+100,FoundY+50,50
}
