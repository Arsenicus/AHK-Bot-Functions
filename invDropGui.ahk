;Made By Arekusei#3363
;v2.0

;------Drop Modes--------------------------------------------
; 1 - From Left to Right
; 2 - From Top to Bottom
; 3 - Zig-Zag
; 
;      Usage Example

; n - inventory slot number
; m - Drop mode 1-3
; inv_select(n,m)
; inv_selec(28,1) will get last inventory slot coordinates. Can be Wrong with different modes

;---------GUI is Extra, Look at 
;
; Alt+1 to move gui, make sure rs window is active
; Alt+2 to Show/Hide Gui
;
; Alt+w to drop whole inventory or selected part
; 
;------------------------------------------------------------


;!!!!!!!!      REPLACE MouseMove function with your own in "inv_select" !!!!!!!!!!

;Testing In paint will need to set CoordMode to Window for it to be correct

#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
CoordMode, Mouse, Client
SendMode Input
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

Global Array := [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

WinGetPos XN, YN, , , A
xn:=xn+567
yn:=yn+240
Gui,1: +hwndHGUI
Gui,1: +LastFound +AlwaysOnTop -Caption +ToolWindow 
Gui,1:Margin, 0, 0
Loop 28
{
n:=A_Index -1
x := (Mod(n, 4) * 42)
y := n // 4 * 36

    
Gui,1:Add,Progress, x%x%  y%y% w32 h32 -Smooth hWnd%n% vBAR%n% cFF7200, 100
;Gui,1:Add,Text, cBlack x%x%  y%y% w42 h36 +0x200 +Center +BackgroundTrans , % n +1

}
Gui,1:Show, x%xn% y%yn% w158 h248 NA, InvDrop
WinSet, Transparent, 125


Return

#If !WinActive("InvDrop")
!1::
WinGetPos XN, YN, , , A
xn:=xn+567
yn:=yn+240
WinMove InvDrop,, xn,yn
Return
#if

!2::
toggle := !toggle
If toggle
	Gui,1: Hide
else
	Gui,1: Show
return

~LButton::
#If WinActive("InvDrop")
MouseGetPos, , , HWIN, HCTRL, 2
GuiControlGet, VarName, %HWIN%:Name, %HCTRL%
;ToolTip Control %HCTRL% is v%VarName%
if (Array[SubStr(VarName,4)+1]==0){
    GuiControl, % "+c" SubStr("0x00000D", 3) , % VarName
    Array[SubStr(VarName,4)+1] :=1
} else {
    GuiControl, % "+c" SubStr("0xFF7200", 3) , % VarName
    Array[SubStr(VarName,4)+1] :=0
}
varname:=0  
return
#if


;-----------------Example Of Dropping Selected Slot
!q::
KeyWait, Shift

inv_select(1)
inv_select(2)

Return

;---------------To drop whole inventory or Specific Slots if selected from GUI
!w::
i:=1
Loop 28
{

    if (Array[i]==0)
        {
            inv_select(i,1)
            i++
        }
    Else if (Array[i]==1)
        {
            i++
        }

}

Return


inv_select(n,m:=1) {

    n:= n - 1, v:=15 ;15-16 middle of inventory slot, can be wrong outside RuneLite Client
    ;xn:=0, yn:=0
    ;WinGetPos XN, YN, , , A
    ;---------------DROP MODE----------
    
    If (m=1){
        x := (Mod(n, 4) * 42)  + 567 + v
        y := n // 4 * 36 + 240 + v    
    }
	if (m=2){
        x := n // 7 * 42  + 567 + v
        y := (Mod(n, 7) * 36)  + 240 + v     
    }
    if (m=3){
        if (n<14){
            x := (Mod(n, 2) * 42) + 567 + v
            y := n // 2 * 36  + 240 + v   
        } else {
            x := (Mod(n, 2) * 42)  + 567 + v + 84
            y := n // 2 * 36  
        }
  
    }
    
    ; if (n<14){
        ; x := (Mod(n, 2) * 42) + XN + 567 + 15
        ; y := n // 2 * 36 + YN + 240 + 15   
        ; ToolTip % n + 1
    ; } else {
        ; x := (Mod(n, 2) * 42) + XN + 567 + 15 + 84
        ; y := n // 2 * 36 + YN
        ; ToolTip % n + 1
    ; }
    
    
    

    ;|---------Your Mouse Function Here --------|
    ;Example
    ;
	MouseMove, x, y, 0
    ;MoveMouse(600, 400, 0.5)
    ;ETC
    
    ;sleep 100 ;sleep between clicks
    SendEvent {LShift Down}
    Click
    sleep 100
    SendEvent {LShift Up}
}

~+esc::
~esc::
SendEvent {LShift Up}
ExitApp
