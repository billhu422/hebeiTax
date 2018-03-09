#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

consoleWrite(contents){
	FileAppend %contents% `n, *
}

ImageSearchWait(ByRef X,ByRef Y,imagePath:="",waitSeconds:=1){
	Loop {
		consoleWrite(waitSeconds)
    	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,%imagePath%
		consoleWrite(imagePath)
		consoleWrite(ErrorLevel)
		consoleWrite(FoundX)
		consoleWrite(FoundY)
		
		if ErrorLevel = 2
			MsgBox Could not conduct the search.
			break
		
		if (ErrorLevel = 0 && FoundX<>"" && FoundY<>"")
			MsgBox 找到
			break
		
		Sleep 1000
		waitSeconds--
	} Until ErrorLevel=0
	X:=FoundX
	Y:=FoundY
}

test(n:=1){
		Loop {
		consoleWrite(n)
		
		Sleep 1000
		n--
	} Until n=0
}

;test(10)