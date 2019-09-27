#Persistent
Random, randsleep , 200 , 500  
SetTimer, PressTheKey, %randsleep%   ; call press the key  between 10 and 15 seconds
Return



PressTheKey:

IfWinExist, PS4-järjestelmän etäkäyttö
    WinActivate ; grab PS4 as the active window in case it loses focus
else
    Return

Send {Enter down}  ; Press down the Enter key.
Random, rand2, 1001, 1347
Sleep,  %rand2% ; hold the Enter key down for at least  1sec. Neccesary for ps4 remote play to register
Send {Enter up}  ; Release Enter key.
Return



Esc::ExitApp