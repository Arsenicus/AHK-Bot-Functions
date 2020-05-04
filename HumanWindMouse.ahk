#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode Mouse, Client
SetMouseDelay -1
SetBatchLines, -1
;Version 1.0
;Original script By: Flight
;Converted into ahk By: Arekusei


humanWindMouse(xs, ys, xe, ye, gravity, wind, targetArea)
{
	
	windX := 0, windY := 0,
	veloX := 0, veloY := 0,
	maxStep := 0
	
	mousespeed := 60
	MSP  := mouseSpeed
	sqrt2:= sqrt(2)
	sqrt3:= sqrt(3)
	sqrt5:= sqrt(5)
	
	TDist := distance(round(xs), round(ys), round(xe), round(ye))
	t := A_TickCount + 10000
	
	Loop {
		
		;if (A_TickCount > t)
		;	break
		
		dist:= hypot(xs - xe, ys - ye)
		wind:= min(wind, dist)
		
		if (dist < 1)
			dist := 1
		
		D := (round((round(TDist)*0.3))/7)
		
		if (D > 25)
			D := 25
		if (D < 5)
			D := 5
		
		rCnc := random(6)
		if (rCnc = 1)
			D := randomRange(2,3)
		
		if (D <= round(dist))
			maxStep := D
		else
			maxStep := round(dist)
		
		
		if (dist >= targetArea) {
			windX:= windX / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
			windY:= windY / sqrt3 + (random(round(wind) * 2 + 1) - wind) / sqrt5
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
		
		;veloMag:= sqrt(veloX * veloX + veloY * veloY)
		
		if (hypot(veloX, veloY) > maxStep){
			randomDist:= maxStep / 2.0 + random(round(maxStep) / 2)
			veloMag:= sqrt(veloX * veloX + veloY * veloY)
			veloX:= (veloX / veloMag) * randomDist
			veloY:= (veloY / veloMag) * randomDist
		}
		
		lastX:= round(xs)
		lastY:= round(ys)
		xs:= xs + veloX
		ys:= ys + veloY
		
		if (lastX <> round(xs)) or (lastY <> round(ys)){
			MouseMove, % round(xs) , % round(ys)
		}
		
			;moveMouse(round(xs), round(ys))
		
		W := (random((round(100/MSP)))*3)
		
		if (W < 5)
			W := 5
		
		W := round(W*0.9)
		;wait(W);
		Sleep % W
		lastdist:= dist
		
		;wait = (int)Math.Round(waitDiff * (step / maxStep) + minWait);
		;double step = Math.hypot(xs - cx, ys - cy);
		;sleep(Math.round((maxWait - minWait) * (step / maxStep) + minWait));
		;waitDiff = maxWait - minWait;
		
	} until (hypot(xs - xe, ys - ye) < 1)
	
	if (round(xe) <> round(xs)) or (round(ye) <> round(ys))
		MouseMove, % round(xe) , % round(ye)
		;MouseMove(round(xe), round(ye));
	
	
	mouseSpeed := MSP
}
	
	
	
hypot(x,y){
	Return Sqrt(x*x + y*y)
}


random(n){
	random, out, 0, n
	return % out
}

randomP(){
	random, out, 0.0, 1.0
	return % out
}

randomRange(x,y){
	random, out, x, y
	return % out
}

distance(x1,y1,x2,y2){
	return % Sqrt((x2 - x1)**2 + (y2 - y1)**2)
}


