;Written By Arekusei and AHK community
;Version 1.2

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Loop, 59
    var := var A_Index "|"

Gui, Margin, 0 0
Gui, Add, Text, x5 y20 w50 h20 Center, Hour
Gui, Add, Text, xp+40 yp w50 h20 Center, Min
Gui, Add, Text, xp+40 yp w50 h20 Center, Sec
Gui, Add, ComboBox, x15 y40 w35 h20 va1 r20, 0||%var%
Gui, Add, ComboBox, xp+40 y40 w35 h20 va2 r20, 0||%var%
Gui, Add, ComboBox, xp+40 y40 w35 h20 va3 r20, 0||%var%

Gui, Add, Button, xp+40 y39 w35 h23 gStart, Start
Gui, Add, Text, x5 y100 w200 h20 vDisplay, Time: 00:00:00
Gui, Add, Text, x5 y120 w200 h20 vDisplay2, Time: 00:00:00

Gui, Add, GroupBox, x5 y5 w180 h70 -Theme,

Gui, Show, w190 h150, Set Timer
Return

Start:
    Gui, Submit, Nohide
    ST := A_TickCount
    Time := (a1*3600)+(a2*60)+a3
    ET := ST + (Time * 1000)
    SetTimer, Stopwatch, 100
return

StopWatch:

GuiControl, , Display, % ToDigital(A_TickCount - ST)         ;Time count up
GuiControl, , Display2, % ToDigital(ET - (A_TickCount-1000)) ;Time count down

if (A_TickCount > ET){
    MsgBox DONE
    SetTimer, Stopwatch, Off
}
Return


ToDigital(currentTime) {
    s  := Mod(Floor(currentTime / 1000), 60)
    m  := Mod(Floor(currentTime / (1000 * 60)), 60)
    h  := Floor(currentTime / (1000 * 60 * 60))
    return Format("Time: {:02d}:{:02d}:{:02d}", h, m, s)
}

GuiEscape:
GuiClose:
    ExitApp
