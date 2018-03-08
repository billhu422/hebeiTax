#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

consoleWrite(contents){
	FileAppend %contents% `n, *
}

ImageSearchWait(ByRef X,ByRef Y,imagePath:="",waitSeconds:=1){
	Loop {
    	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,%imagePath%
		if ErrorLevel = 2
			MsgBox Could not conduct the search.
			break
		Sleep 1000
		waitSeconds--
	} Until ErrorLevel=1 
	X:=FoundX
	Y:=FoundY
}

