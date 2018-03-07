#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

consoleWrite(contents){
	FileAppend %contents% `n, *
}

