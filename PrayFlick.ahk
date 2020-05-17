#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetBatchLines -1

;X to toggle on/Off

x::SetTimer, prayFlick, % (toggle := !toggle) ? 1 : "Off"


prayFlick:
    click
    Random, sleep1, 505, 515 
    Sleep sleep1
    Random, sleep2, 595, 605
    click
    Sleep sleep2 - sleep1 
return

esc::ExitApp
