#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetKeyDelay [, 1000, 100, Play]
Esc::ExitApp
PrintScreen::
loop, 437
		{
		Send ^c
		Sleep 300 
		Send !{Tab}
		Sleep 300
		Send ^v
		Sleep 300
		Send {Tab}
		Sleep 300
		Send !{Tab}
		Sleep 300
		Send {Down}
		Sleep 300
		}
Return