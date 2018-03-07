#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#Include ../lib/utils.ahk
#Include ../lib/DisplaySetting.ahk
#Include ../lib/AutoHotkey-JSON/JSON.ahk
;example
StartNationalTaxUI()
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
		
	parsed := JSON.Load(OutputVar)
	fullPath := parsed.nationalTax.path
	Run,%fullPath%

	
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