;Made by Arekusei#3363
;Version 0.1
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
CoordMode, Mouse, Screen
#MaxThreadsPerHotkey 10

;------------------GUI----------------------

Gui Add, Text, x11 y8 w77 h13, Mouse Button
Gui Add, DropDownList, x11 y29 w74 vWhichBTN, Left||Right
Gui Add, Text, x94 y8 w109 h13, Mouse Coordinates
Gui Add, Edit, x93 y29 w50 h21 vxPos, 0
Gui Add, UpDown,Range0-1000 0x80,0
Gui Add, Edit, x153 y29 w50 h21 vyPos, 0
Gui Add, UpDown,Range0-1000 0x80,0
Gui Add, Button, x211 y28 w50 h23 gGetPos, SET
Gui Add, Text, x12 y68 w77 h13, Click Interval
Gui Add, Edit, x12 y89 w70 h21 vInterval, 1
Gui Add, UpDown,Range0-1000 0x80, 1
Gui Add, DropDownList, x93 y89 w82 AltSubmit vTimeUnit,Second(s)||Milisecond(s)
Gui Add, Button, x4 y118 w181 h30 gClickerSubmit HWNDSubmit, Start [F1]
Gui Add, CheckBox, x276 y26 w91 h23 Checked vState gAlwaysOnTop, Always On Top
Gui Add, CheckBox, x276 y84 w84 h23 vClickForever, Click Forever
Gui Add, Text, x198 y68 w77 h13, Amount: 
Gui Add, Edit, x197 y86 w70 h21 vAmount, 1
Gui Add, UpDown,Range0-1000 0x80,1

Gui Add, Edit, x197 y123 w70 h21 vAddRandom, 1
Gui Add, UpDown,Range0-1000 0x80, 0
Gui Add, Text, x276 y121 w81 h23 +0x200, Add Random ms
Gui Add, GroupBox, x189 y113 w187 h35 -Theme

Gui Add, GroupBox, x5 y0 w261 h58 -Theme
Gui Add, GroupBox, x5 y56 w180 h61 -Theme
Gui Add, GroupBox, x189 y56 w187 h61 -Theme
Gui Add, GroupBox, x270 y0 w106 h58 -Theme
Gui Add, Text, x276 y9 w95 h13 +0x200, By Arekusei  v0.1
;Gui Add, Link, x276 y9 w95 h13, <a href="https://discord.gg/bRaz5gpaAt">By Arekusei v0.1</a>
Gui +AlwaysOnTop

Gui Show, w384 h156 , AutoClicker v0.1
Hotkey,F1,ClickerSubmit


Global ClickerToggle := 0
Return

;---------------GUI SUBMIT---------------

;F1::
ClickerSubmit:

    
    ClickerToggle := !ClickerToggle
    ;MsgBox % ClickerToggle
    if(!ClickerToggle){
        return
    }

    Gui, Submit , NoHide 
    GuiControl,,% Submit, % ClickerToggle ? "Stop [F1]" : "Start [F1]"
    Gosub Clicker
Return



Clicker:

    vCount := 0
    if(!ClickForever){
        GuiControl,,% Submit, % ClickerToggle ? "Stop [F1]" : "Start [F1]"
        While(ClickerToggle && Amount > vCount){
            MouseClick, % WhichBTN, % xPos, % yPos, , 0
            vCount++
            vSleep := (TimeUnit = 1) ? Interval * 1000 : Interval
            Sleep % vSleep + random(0,AddRandom)
        }

        ClickerToggle := !ClickerToggle
        GuiControl,,% Submit, % ClickerToggle ? "Stop [F1]" : "Start [F1]"
        
    } else {
    
        while(ClickerToggle){ 
            MouseClick, % WhichBTN, % xPos, % yPos, , 0
            vSleep := (TimeUnit = 1) ? Interval * 1000 : Interval
            Sleep % vSleep + random(0,AddRandom)
        }
        ;ClickerToggle := !ClickerToggle
        GuiControl,,% Submit, % ClickerToggle ? "Stop [F1]" : "Start [F1]"
    }
    
Return


GetPos:
    SetTimer, Tooltip, 50
    KeyWait, Ctrl, D	
    MouseGetPos, xPos, yPos 
    Gui, Show
    GuiControl, , xPos, % xPos
    GuiControl, , yPos, % yPos
    SetTimer, Tooltip, OFF
    ToolTip
Return

Tooltip:
    ToolTip,Move your cursor to the position you want to set `nand then press " ctrl " `n(The control key on your keyboard)
Return

AlwaysOnTop:
    Gui Submit, NoHide
	if(State=1)
		Gui,+Alwaysontop
	else
		Gui,-AlwaysOnTop
	return	

random(min, max) {
    random, out, % min, % max
    return out
}


;----------GUI SPECIFIC LABELS----------

GuiEscape:
GuiClose:
    ExitApp
Return
