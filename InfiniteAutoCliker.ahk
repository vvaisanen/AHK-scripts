PrintScreen::
If (toggle := !toggle)
	SetTimer, Timer, -1
return
 
timer:
while toggle
{
	Click
	Sleep, 200
}
return