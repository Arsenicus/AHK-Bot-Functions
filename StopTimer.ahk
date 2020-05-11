;Written By Arekusei and AHK community

;Add this code to where check needs to be done in your script

;if (A_TickCount > ET){
;    MsgBox DONE
;    SetTimer, Stopwatch, Off
;}

#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

Loop, 59
    var := var A_Index "|"

Gui, Margin, 0 0
Gui, Add, Text, x5 y20 w60 h20 Center, Hour
Gui, Add, Text, xp+60 yp w50 h20 Center, Minute
Gui, Add, Text, xp+60 yp w60 h20 Center, Second
Gui, Add, ComboBox, x15 y40 w50 h20 va1 r20, 0||%var%
Gui, Add, ComboBox, xp+60 y40 w50 h20 va2 r20, 0||%var%
Gui, Add, ComboBox, xp+60 y40 w50 h20 va3 r20, 0||%var%

Gui, Add, Button, x5 yp+40 gStart, Start
Gui, Add, Text, xp+50 yp w200 h20 vDisplay, Time: 00:00:00

Gui, Add, GroupBox, x5 y5 w200 h70, Set Time:



Gui, Show, w210 h150, Set Timer
Return

Start:
Gui, Submit, Nohide
ST := A_TickCount
Time := (a1*3600)+(a2*60)+a3
ET := ST + (Time * 1000)
SetTimer, Stopwatch, 100

return

StopWatch:
GuiControl, , Display, % ToDigital(A_TickCount - ST) 
if (A_TickCount > ET){
    MsgBox DONE
    SetTimer, Stopwatch, Off
}
Return


ToDigital(currentTime) {
    ;ms := Mod(currentTime, 1000)
    s  := Mod(Floor(currentTime / 1000), 60)
    m  := Mod(Floor(currentTime / (1000 * 60)), 60)
    h  := Floor(currentTime / (1000 * 60 * 60))
    return Format("Time: {:02d}:{:02d}:{:02d}", h, m, s)
}

GuiEscape:
GuiClose:
    ExitApp
