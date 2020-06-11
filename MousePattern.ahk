#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetMouseDelay, -1
SetBatchLines, -1

;Version 1.2
;Original script By: Flight
;Converted into ahk By: Arekusei


MoveMouse(X,Y,Speed:=1){
   
    MousePattern(X, Y, 9, 3,  1.0 * speed,  (1.1 * Speed) + 0.2 , 10 * speed)
    
}

MousePattern(xe, ye, gravity, wind, minWait, maxWait, targetArea)
{
	MouseGetPos xs, ys
    
	windX := 0, windY := 0,veloX := 0, veloY := 0, maxStep := 0,
    ;gravity := 9, wind := 3 
	sqrt2:= sqrt(2), sqrt3:= sqrt(3), sqrt5:= sqrt(5)
	TDist := hypot(xs - xe, ys - ye)
	
	Loop {
		
		dist:= hypot(xs - xe, ys - ye)
		wind:= min(wind, dist)
		waitDiff:= maxWait - minWait
        
		if (dist < 1)
			dist := 1
		
		D := (round((round(TDist)*0.3))/7)
        D := (D>25)?(25):(D<5)?(5):(D)

		
		if (posrandom(6) = 1)
			D := randomRange(2,4)

		maxStep:= (D <= round(dist))?(D):(round(dist))
		
		if (dist >= targetArea) {
			windX:= windX / sqrt3 + (posrandom(round(wind) * 2 + 1) - wind) / sqrt5
			windY:= windY / sqrt3 + (posrandom(round(wind) * 2 + 1) - wind) / sqrt5
		} 
		else 
		{
			windX:= windX / sqrt2
			windY:= windY / sqrt2
		}
		
		veloX:= veloX + windX
		veloY:= veloY + windY
		veloX:= veloX + gravity * (xe - xs) / dist
		veloY:= veloY + gravity * (ye - ys) / dist
		
		
		if (hypot(veloX, veloY) > maxStep){
			randomDist:= maxStep / 2.0 + posrandom(round(maxStep) / 2)
			veloMag:= sqrt(veloX * veloX + veloY * veloY)
			veloX:= (veloX / veloMag) * randomDist
			veloY:= (veloY / veloMag) * randomDist
		}
		
		lastX:= round(xs),
		lastY:= round(ys),       
        xs:= xs + veloX
        ys:= ys + veloY   
        
        dist:= Hypot(xe - xs, ye - ys)

		if (lastX <> round(xs)) or (lastY <> round(ys)){
			MouseMove, % round(xs) , % round(ys)
		}
        step:= Hypot(xs - lastX, ys - lastY)        
        wait:= Round(waitDiff * (step / maxStep) + minWait)
        
        ;dist:= Hypot(xe - lastX, ye - lastY)
        ;sleep % wait
        DllCall("Sleep", "UInt", wait)

	} until (dist < 1)
	
	if (round(xe) <> round(xs)) or (round(ye) <> round(ys))
		MouseMove, % round(xe) , % round(ye)


}
	
	
	
hypot(x,y){
	Return Sqrt(x*x + y*y)
}

posrandom(n){
	random, out, 0, n
	return % out
}

randomRange(x,y){
	random, out, x, y
	return % out
}


esc::ExitApp
