# SmartMouseMovement


EXAMPLES
- xs = xStart position  ys = yStart position
- xe = xEnd position    ye = yEnd position
- minWait - maxWait is mouse speed, the higher the slower. Use around 0.01 up to 3 rec


```autohotkey

humanWindMouse(xs, ys, xe, ye, gravity, wind, minWait, maxWait, targetArea)

Smooth movement: humanWindMouse(100, 200, 310, 310, 22, 10, 0.4 , 0.2, 50)
w::
humanWindMouse(100, 200, 310, 310, 11, 10, 0.1 , 0.2, 22)
return

q::
humanWindMouse(200, 200, 1200, 400, 11, 5, 0.1 , 0.2, 33)
return
```

