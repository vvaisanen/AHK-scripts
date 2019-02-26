F12::
   WinGetActiveTitle, Title
   MsgBox, The active window is "%Title%".
return

WheelDown::
SetTitleMatchMode, 2
IfWinActive, Chrome ; Replace 'SafariTitle' by the title of the safari windows
{
        CoordMode, Mouse, Screen
        WinGet, active_id, ID, A
        IfWinExist, Excel
        {
                Send {WheelDown}
                WinActivate ; Automatically uses the window found above.
                Send {WheelDown}
                Send {WheelDown}
                WinActivate, ahk_id %active_id%
        }
}
Else
{
        Send {WheelDown}
}
return

WheelUp::
SetTitleMatchMode, 2
IfWinActive, Chrome ; Replace 'SafariTitle' by the title of the safari windows
{
        CoordMode, Mouse, Screen
        WinGet, active_id, ID, A
        IfWinExist, Excel
        {
                Send {WheelUp}
                WinActivate ; Automatically uses the window found above.
                Send {WheelUp}
                Send {WheelUp}
                WinActivate, ahk_id %active_id%
        }
        }
        Else
        {
                Send {WheelUp}
        }
return