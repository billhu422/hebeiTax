#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

consoleWrite(contents){
	FileAppend %contents% `n, *
}




ImageSearchWait(ByRef X,ByRef Y,imagePath:="",waitMicrosecond :=1000){
	TIMEOUT := waitSeconds
	time_loopStart := A_tickCount
	SLEEP_AFTER_EACH_IMAGESEARCH := 300
	loop {
		ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,%imagePath%
		;~ if(FoundX = "")
		;~ {
			;~ MsgBox,"FoundX 为空"
			;~ return
		;~ }
		if (ErrorLevel = 0 and FoundX<> "" and FoundY<>"")
		{
			X:=FoundX
			Y:=FoundY
			break
		}
		else if ErrorLevel = 2
		{
			MsgBox,"不能执行ImageSearch操作"
			break
		}
		if(A_tickCount - time_loopStart > TIMEOUT)
			break   ; time is up, no image found in time
		Sleep, %SLEEP_AFTER_EACH_IMAGESEARCH%
	}
}

test(n:=1,x:=3){
		Loop {
		consoleWrite(n)
		if(x = 1){
			MsgBox, "x=1"
			break
		}
		else if(x = 2){
			MsgBox,"x=2"
		    break
		}
			
		
		Sleep 1000
		n--
	} Until n=0
}


;test(10,3)