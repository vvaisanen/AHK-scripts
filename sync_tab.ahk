F12::
   WinGetActiveTitle, Title
   MsgBox, The active window is "%Title%".
return

Tab::

SetTitleMatchMode, 2
IfWinActive, Chrome ; Replace 'SafariTitle' by the title of the safari windows
{

        IfWinExist, Excel
        {	

                WinActivate ; Automatically uses the window found above.
				Send {Down}
				WinActivate, Chrome
				Send {Tab}
        }
}

return
