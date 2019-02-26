#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;-Caption
LWIN & LButton::
WinSet, Style, -0xC00000, A
return
;

;+Caption
LWIN & RButton::
WinSet, Style, +0xC00000, A
return
;