#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory. IDK WHATS UP WITH THIS
;SetKeyDelay [, 1000, 100, Play] IDK WHATS UP WITH THIS

; Set esc to ESCAPE KEY. For escape, panic situations, you know?
Esc::ExitApp
#PrintScreen::
ControlClick, OK, WindowTitle
Return


#!^R::Reload
Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
Return