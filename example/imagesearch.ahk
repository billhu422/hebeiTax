CoordMode,Pixel,Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight,.\mycomputer.bmp
if ErrorLevel = 2
    MsgBox Could not conduct the search.
else if ErrorLevel = 1
    MsgBox Icon could not be found on the screen.
else
    MsgBox The icon was found at %FoundX%x%FoundY%.
	CoordMode,Mouse,Screen
	MouseMove,FoundX,FoundY,10
   