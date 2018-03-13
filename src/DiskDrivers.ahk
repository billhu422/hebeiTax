#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#Include ../lib/utils.ahk

;example
ret := isExsitCADiskDriver()
consoleWrite(ret)

;ret2 := DiskDrivers()
;consoleWrite(ret2)
;test3()

/**
* Method: DiskDrivers()
*     获取硬盘驱动器名称列表
* Syntax:
*     str := DiskDrivers()
* Parameter(s):
*     str        			  [retval] -  驱动器名称拼接的连续字符串
*/



DiskDrivers(){
	DriveGet, list, list
	return list
}


/**
* Method: isExsitCADiskDriver()
*     获取硬盘驱动器名称列表
* Syntax:
*     str := isExsitCADiskDriver()
* Parameter(s):
*     str        			  [retval] -  存在CA驱动器=0  不存在CA驱动器=1
*/
isExsitCADiskDriver(){
	DriveGet, list, list
	pos := 1
	count := StrLen(list)
	Loop,%count%
	{
		folder := SubStr(list, pos++ , 1)
		path := folder ":\"
		DriveGet, label, label, %path%
		;consoleWrite(label)
		if( label = "携税宝")
		{
			return 0
		}
	}
	MsgBox,"没有检测到CA驱动"
	return 1
}


test3(){
	FileSelectFolder, folder, , 3, Pick a drive to analyze:
		if folder =
			return
		DriveGet, list, list
		DriveGet, cap, capacity, %folder%
		DriveSpaceFree, free, %folder%
		DriveGet, fs, fs, %folder%
		DriveGet, label, label, %folder%
		consoleWrite(folder)
		DriveGet, serial, serial, %folder%
		DriveGet, type, type, %folder%
		DriveGet, status, status, %folder%
		MsgBox All Drives: %list%`nSelected Drive: %folder%`nDrive Type: %type%`nStatus: %status%`nCapacity: %cap% M`nFree Space: %free% M`nFilesystem: %fs%`nVolume Label: %label%`nSerial Number: %serial%
}