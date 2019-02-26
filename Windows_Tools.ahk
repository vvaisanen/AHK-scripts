;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WinGravity.ahk
;; Window gravities for Windows/Autohotkey
;; Copyright (C) 2012  Florian Bruhin / The Compiler <me@the-compiler.org>
;;
;; wingravity is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; wingravity is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with wingravity.  If not, see <http://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This tools allows you to efficiently manage windows using your keyboard
;; under Microsoft Windows.
;;
;; The "subtle" window manager calls this gravities, hence the name.
;;
;; Windows + Arrow keys is mapped like this:
;;
;;                 +----+
;;                 |####| Up: maximize
;;                 |####|
;;                 |####|
;;            +----+----+----+4
;; Left:      |##  |    |  ##|
;; use left   |##  |    |  ##| right: use right half of the screen
;; half of    |##  |    |  ##|
;; the screen +----+----+----+
;;                  Down: restore or minimize
;;
;; Windows + Numpad keys is mapped like this:
;; (screen divided in halfs/quarters)
;; +----+ +----+ +----+
;; |77  | |8888| |  99|
;; |77  | |8888| |  99|
;; |    | |    | |    |
;; |    | |    | |    |
;; +----+ +----+ +----+
;; |44  | |5555| |  66|
;; |44  | |5555| |  66|
;; |44  | |5555| |  66|
;; |44  | |5555| |  66|
;; +----+ +----+ +----+
;; |    | |    | |    |
;; |    | |    | |    |
;; |11  | |2222| |  33|
;; |11  | |2222| |  33|
;; +----+ +----+ +----+
;; 0: Restore/Minimize
;;
;; Windows + Ctrl + Numpad keys is mapped like this:
;; (screen divided in thirds)
;; +---+ +---+ +---+
;; |7  | | 8 | |  9|
;; |   | |   | |   |
;; |   | |   | |   |
;; +---+ +---+ +---+
;; |   | |   | |   |
;; |4  | | 5 | |  6|
;; |   | |   | |   |
;; +---+ +---+ +---+
;; |   | |   | |   |
;; |   | |   | |   |
;; |1  | | 2 | |  3|
;; +---+ +---+ +---+
;; 0: Restore/Minimize


; Skips the gentle method of activating a window and goes straight to the forceful method.
#WinActivateForce
; Don't display a tray icon
; #NoTrayIcon

; Things to do before moving a window
MoveInit:
  WinGet, maximized, MinMax, A
  if (maximized)
	WinRestore, A
  SysGet, Scr, MonitorWorkArea
return

; Restore or minimize a window
RestoreOrMinimize:
  WinGet, maximized, MinMax, A
  if (maximized)
    WinRestore, A
  else
    WinMinimize, A
return
; Arrow keys
#down::
  GoSub, RestoreOrMinimize
  return
#up::
  WinMaximize, A
return
#left::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/2.0,ScrBottom
return
#right::
  GoSub, MoveInit
  WinMove,A,,ScrRight/2.0,ScrTop,ScrRight/2.0,ScrBottom
return


#^Numpad0::
  GoSub, RestoreOrMinimize
return
#^Numpad1::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/5.0,ScrBottom
return
#^Numpad2::
  GoSub, MoveInit
  WinMove,A,,ScrRight/5.0,ScrTop,ScrRight/5.0*3,ScrBottom
return
#^Numpad3::
  GoSub, MoveInit
  WinMove,A,,ScrRight/5.0*4,ScrTop,ScrRight/5.0,ScrBottom
return
#^Numpad4::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/4.0,ScrBottom
return
#^Numpad5::
  GoSub, MoveInit
  WinMove,A,,ScrRight/4.0,ScrTop,ScrRight/4.0*2,ScrBottom
return
#^Numpad6::
  GoSub, MoveInit
  WinMove,A,,ScrRight/4.0*3,ScrTop,ScrRight/4.0,ScrBottom
return
#^Numpad7::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/3.0,ScrBottom
return
#^Numpad8::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0,ScrTop,ScrRight/3.0,ScrBottom
return
#^Numpad9::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0*2,ScrTop,ScrRight/3.0,ScrBottom
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WindowTopBarHider

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MouseAccelToggle


WhatIsIt?:
    SPI_GETMOUSE(accel, low, high)
    MsgBox Mouse acceleration settings-`n  accel:`t%accel%`n  low:`t%low%`n  high:`t%high%
return

#^¨::    ; Enable acceleration.
#^'::    ; Disable acceleration.
    SPI_SETMOUSE(A_ThisHotkey="#^¨") ; i.e. 1 if #^¨, 0 otherwise.
    gosub WhatIsIt?
return


; Get mouse acceleration level and low/high thresholds.
; Returns true on success and false on failure.
SPI_GETMOUSE(ByRef accel, ByRef low="", ByRef high="")
{
    VarSetCapacity(vValue, 12)
    if !DllCall("SystemParametersInfo", "uint", 3, "uint", 0, "uint", &vValue, "uint", 0)
        return false ; Fail.
    low := NumGet(vValue, 0)
    high := NumGet(vValue, 4)
    accel := NumGet(vValue, 8)
    return true
}

; Set mouse acceleration level and low/high thresholds.
; Supplies standard default values for low/high if omitted.
; fWinIni:  0 or one of the following values:
;           1 to update the user profile
;           2 to notify applications
;           3 to do both.
; Returns true on success and false on failure.
SPI_SETMOUSE(accel, low="", high="", fWinIni=0)
{
    VarSetCapacity(vValue, 12)
    , NumPut(accel
    , NumPut(high!="" ? high : accel ? 10 : 0
    , NumPut(low!="" ? low : accel ? 6 : 0, vValue)))
    return 0!=DllCall("SystemParametersInfo", "uint", 4, "uint", 0, "uint", &vValue, "uint", 0)
}
return
;



;BEGIN INSTANT APPLICATION SWITCHER SCRIPTS;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#^Q::switchToExcel()
;!#^E::closeAllExcels()

#^E::switchToExplorer()
!#^E::closeAllExplorers()

#^W::switchToWord()
;!#^E::closeAllExcels()

#^Z::switchToChrome()
;!#^E::closeAllExcels()

#^A::switchToOutlook()
;!#^E::closeAllExcels()

#^S::switchToOneNote()
;!#^E::closeAllExcels()



; This is a script that will always go to The last explorer window you had open.
; If explorer is already active, it will go to the NEXT last Explorer window you had open.

switchToExplorer(){
IfWinNotExist, ahk_class CabinetWClass
	Run, explorer.exe
GroupAdd, taranexplorers, ahk_class CabinetWClass
if WinActive("ahk_exe explorer.exe")
	GroupActivate, taranexplorers, r
else
	WinActivate ahk_class CabinetWClass ;you have to use WinActivatebottom if you didn't create a window group.
}

closeAllExplorers()
{
WinClose,ahk_group taranexplorers
}




switchToWord()
{
Process, Exist, WINWORD.EXE	
;Next line is just for error handling
;msgbox errorLevel `n%errorLevel%

	If errorLevel = 0
	{
		objWord := ComObjCreate("Word.Application")
		objWord.Visible := True
		objWord.RecentFiles(1).open

	}
	else
	{
	GroupAdd, taranwords, ahk_class OpusApp
	if WinActive("ahk_class OpusApp")
		GroupActivate, taranwords, r
	else
		WinActivate ahk_class OpusApp
	}
}

switchToExcel()
{
Process, Exist, EXCEL.EXE
;Next line is just for error handling
;msgbox errorLevel `n%errorLevel%
	If errorLevel = 0
		{
		objExcel := ComObjCreate("Excel.Application")
		objExcel.Visible := True
		objExcel.RecentFiles(1).open
 		}
	else
	{
	GroupAdd, taranwords2, ahk_class XLMAIN
	if WinActive("ahk_class XLMAIN")
		GroupActivate, taranwords2, r
	else
		WinActivate ahk_class XLMAIN
	}
}


switchToChrome()
{
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe

if WinActive("ahk_exe chrome.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe chrome.exe
}


switchToOutlook()
{
IfWinNotExist, ahk_exe outlook.exe
	Run outlook.exe
if WinActive("ahk_exe outlook.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe outlook.exe
}


switchToOneNote()
{
IfWinNotExist, ahk_exe onenote.exe
	Run, onenote.exe
	
if WinActive("ahk_exe onenote.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe outlook.exe
}


; VILJAMIs Outlook macrostuff

#IfWinActive, ahk_class rctrl_renwnd32
#^1::FlagToday()
#^2::FlagTomorrow()
#^3::Flag3Days()
#^4::FlagNextWeek()
#^§::UnFlag()

FlagToday()
{
	Send ^+G
	Send {Tab}
	Send {Tab}
	Send {Return}
	Sendinput ^{tab}
	Send {Return}
	Send {Tab}
	Send {Return}
	Send {Return}
	Send {Return}
}


FlagTomorrow()
{
	Send ^+G
	Send {Tab}
	Send {Tab}
	Send {Return}
	Sendinput ^{tab}
	Send {Return}
	Send {Tab}
	Send {Return}
	Send {Right}
	Send {Return}
	Send {Return}
}

Flag3Days()
{
	Send ^+G
	Send {Tab}
	Send {Tab}
	Send {Return}
	Sendinput ^{tab}
	Send {Return}
	Send {Tab}
	Send {Return}
	loop, 3 
		Send {Right}
	Send {Return}
	Send {Return}
}


FlagNextWeek()
{
	Send ^+G
	Send {Tab}
	Send {Tab}
	Send {Return}
	Sendinput ^{tab}
	Send {Return}
	Send {Tab}
	Send {Return}
	loop, 7
		Send {Right}
	Send {Return}
	Send {Return}
}

UnFlag()
{
	Send ^+G
	loop, 7
		Send {Tab}
	Send {Return}
}

#IfWinActive