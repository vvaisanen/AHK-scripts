;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; WinGravity.ahk
;; Window gravities for Windows/Autohotkey
;; Copyright (C) 2012  Florian Bruhin / The Compiler <me@the-compiler.org>
;;

WS_EX_TOOLWINDOW := 0x00000080
!MButton::WinSet, ExStyle, ^%WS_EX_TOOLWINDOW%, A
^MButton::WinSet, AlwaysOnTop, toggle, A









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


; Disable shitty capslock
Capslock:: Send {*}
!Capslock:: SetCapsLockState Off

!q:: Send !{f4}
!w:: Send ^w
^d:: Send {Del}

;;!^F::ToggleFakeFullscreen()

;;Search like Alfred
!Space:: Send, #s


;; Media control buttons
^!ä::Send      {Media_Play_Pause}
^!Left::Send        {Media_Prev}
^!Right::Send       {Media_Next}
^!Up::Send   		{Volume_Up}
^!Down::Send   		{Volume_Down}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;BEGIN INSTANT APPLICATION SWITCHER SCRIPTS;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



#^Q::switchToExcel()

#^W::switchToWord()

#^S::switchToMSTODO()

#^R::switchToJeeves()

#^T::switchToTeamviewer()

#^A::switchToOutlookOrGOGGalaxy()

#^G::switchToOneNoteOrReminders()

#^F::switchToWhatsApp()

#^D::switchToTeamsOrDiscord()

;#^G::switchToSkype()



#^Z::switchToFireFox()

#^X::switchToChrome()

#^C::switchToHeadSet()


#^F1::desktopMode_MultiMonitorToolx64()
#^F2::tvMode_MultiMonitorToolx64()
; #^F4::enableAllScreens_MultiMonitorToolx64()
#^F5::adjustDesktop_MultiMonitorToolx64()



#^F8::debug()


; NEEXT all the scripts
debug()
{
; Enumerate Query

lookedDevice := "P27q"
for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")
	{
	list := device.name
	
	If InStr(list, lookedDevice, false) > 0
		{
		workComputer := true
		Break
		}
	}

msgBox %workComputer%
}


debug2()
{
; Enumerate Query
for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")
   list = device.name "`n"
MsgBox, %list%
}

debugTEMP()
{
	
	WinGet name, ProcessName, A
    if (name = "ApplicationFrameHost.exe") {
        ControlGet hwnd, Hwnd,, Windows.UI.Core.CoreWindow1, A
        if hwnd {
            WinGet name, ProcessName, ahk_id %hwnd%
        }
    }
    WinClose, ProcessName, ahk_id %hwnd% 
}




desktopMode_MultiMonitorToolx64()
{
if (A_ComputerName = "ViljamiPC") {

	Run, C:\Users\wilzu\Documents\multimonitortool-x64\MultiMonitorTool.exe /LoadConfig "C:\Users\wilzu\Documents\multimonitortool-x64\Desktop.cfg"

	}
else {

	msgbox "Uncofigured setup desktop of desktopMode_MultiMonitorToolx64"
	
	}
}







tvMode_MultiMonitorToolx64()
{
if (A_ComputerName = "ViljamiPC") {

	Run, C:\Users\wilzu\Documents\multimonitortool-x64\MultiMonitorTool.exe /LoadConfig "C:\Users\wilzu\Documents\multimonitortool-x64\TV.cfg"

	}
else {

	msgbox "Uncofigured setup desktop of tvMode_MultiMonitorToolx64"
	
	}
}





enableAllScreens_MultiMonitorToolx64()
{
if (A_ComputerName = "ViljamiPC") {

	msgbox "Uncofigured setup desktop of enableAllScreens_MultiMonitorToolx64"

	}
else {

	msgbox "Uncofigured setup desktop of enableAllScreens_MultiMonitorToolx64"
	
	}
}






adjustDesktop_MultiMonitorToolx64()
{
if (A_ComputerName = "ViljamiPC") {

	IfWinNotExist, ahk_exe discord.exe
		{
		Run, discord.exe
		sleep 1000
		}
		
	Run, C:\Users\wilzu\Documents\multimonitortool-x64\MultiMonitorTool.exe /MoveWindow 2 Process "discord.exe" /WindowLeft 20 /WindowRight 1164 /WindowTop 20 /WindowBottom 1462 /WindowWidth 1164 /WindowHeight 1444
	Run, "C:\Program Files\Rainmeter\Rainmeter.exe" !RefreshApp

	}
else {
	
	
	IfWinNotExist, ahk_exe ApplicationFrameHost.exe
		{
		Run, MSToDo.exe
		Sleep 1000
		}
		
		
	IfWinNotExist, ahk_exe teams.exe
		{
		Run, C:\Users\Viljami.Väisänen\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"
		Sleep 1000
		}
		
		
	lookedDevice := "P27q"
	for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")
		{
		list := device.name
		
		If InStr(list, lookedDevice, false) > 0
			{
			kempele := true
			}
		}
		
	If kempele > 0 Then
		{
			Run, C:\Users\Viljami.Väisänen\Documents\multimonitortool-x64\MultiMonitorTool.exe /MoveWindow 4 Process "Teams.exe" /WindowLeft 10 /WindowRight 1064 /WindowTop 5 /WindowBottom 910 /WindowWidth 1064 /WindowHeight 910
			Run, C:\Users\Viljami.Väisänen\Documents\multimonitortool-x64\MultiMonitorTool.exe /MoveWindow 4 Process "ApplicationFrameHost.exe" /WindowLeft 8 /WindowRight 1070 /WindowTop 930 /WindowBottom 1874 /WindowWidth 1070 /WindowHeight 930

		}
	Else
		{
			Run, C:\Users\Viljami.Väisänen\Documents\multimonitortool-x64\MultiMonitorTool.exe /MoveWindow 3 Process "Teams.exe" /WindowLeft 10 /WindowRight 1164 /WindowTop 5 /WindowBottom 910 /WindowWidth 1164 /WindowHeight 910
			Run, C:\Users\Viljami.Väisänen\Documents\multimonitortool-x64\MultiMonitorTool.exe /MoveWindow 3 Process "ApplicationFrameHost.exe" /WindowLeft 10 /WindowRight 1170 /WindowTop 930 /WindowBottom 1874 /WindowWidth 1170 /WindowHeight 930

		}
	}
	
}







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


switchToOutlookOrGOGGalaxy()
{
if (A_ComputerName = "ViljamiPC") {
	IfWinNotExist, ahk_exe GalaxyClient.exe
		Run, C:\Program Files (x86)\GOG Galaxy\GalaxyClient.exe
		
	if WinActive("ahk_exe GalaxyClient.exe")
		Sendinput ^{tab}
	else
		WinActivate ahk_exe GalaxyClient.exe
	}
else {
IfWinNotExist, ahk_exe outlook.exe
	Run outlook.exe
if WinActive("ahk_exe outlook.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe outlook.exe
	}
}


switchToOneNoteOrReminders()
{
if (A_ComputerName = "ViljamiPC") {
	IfWinNotExist, ahk_exe chrome.exe
		Run, chrome.exe "https://www.icloud.com/reminders/"
		
	if WinActive("ahk_exe chrome.exe")
		Sendinput ^{tab}
	else
		WinActivate ahk_exe chrome.exe
	}
else {
IfWinNotExist, ahk_exe onenote.exe
	Run, onenote.exe
	
if WinActive("ahk_exe onenote.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe onenote.exe
	}
}


switchToJeeves()
{
IfWinNotExist, ahk_exe jvs32client.exe
	{
	Run, C:\jvslocalclientv5\bin64_V51R4\Client\jvs32client.exe "C:\jvslocalclientv5\bin64_V51R4\Client\ThinClientnhkprod_Internet.ini"
	TrayTip , "Jeeves keräilee voimia.", "Jeeves käynnistyy.", 2
	WinWaitActive, "SQL Sisäänkirjoittautuminen"
	WinSetTitle, "SQL Sisaankirjoittautuminen"
	}
if WinActive("ahk_exe jvs32client.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe jvs32client.exe
}


switchToWhatsApp()
{
IfWinNotExist, ahk_exe WhatsApp.exe
	Run, %localappdata%\WhatsApp\WhatsApp.exe
	
if WinActive("ahk_exe WhatsApp.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe WhatsApp.exe
}


switchToSkype()
{
IfWinNotExist, ahk_exe ApplicationFrameHost.exe
	Run, Skype.exe
	
if WinActive("ahk_exe ApplicationFrameHost.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe ApplicationFrameHost.exe
}


switchToTeamsOrDiscord()
{
if (A_ComputerName = "ViljamiPC") {
	IfWinNotExist, ahk_exe discord.exe
		Run, discord.exe
		
	if WinActive("ahk_exe discord.exe")
		Sendinput ^{tab}
	else
		WinActivate ahk_exe discord.exe
	}
else {
	IfWinNotExist, ahk_exe teams.exe
	Run, C:\Users\Viljami.Väisänen\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"

	if WinActive("ahk_exe teams.exe")
	Sendinput ^{tab}
	else
	WinActivate ahk_exe teams.exe
	}
}

switchToMSTODO()
{
IfWinNotExist, ahk_exe ApplicationFrameHost.exe
	Run, MSToDo.exe
	
if WinActive("Microsoft To Do ahk_exe ApplicationFrameHost.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe ApplicationFrameHost.exe
}





;ApplicationFrameHost.exe
; lync.exe


; C:\Users\Viljami.Väisänen\AppData\Local\headset
switchToHeadSet()
{
IfWinNotExist, ahk_exe headset.exe
	Run, %localappdata%\headset\headset.exe
	
if WinActive("ahk_exe headset.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe headset.exe
}

switchToTeamviewer()
{
IfWinNotExist, ahk_exe TeamViewer.exe
	Run, C:\Program Files (x86)\TeamViewer\TeamViewer.exe
	
if WinActive("ahk_exe TeamViewer.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe TeamViewer.exe
}

switchToFireFox()
{
IfWinNotExist, ahk_exe msedge.exe
	Run,  msedge.exe
	
if WinActive("ahk_exe msedge.exe")
	Sendinput ^{tab}
else
	WinActivate ahk_exe msedge.exe
}




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; VILJAMIs Outlook macrostuff


#^1::FlagToday()
#^2::FlagTomorrow()
#^3::FlagFriday()
#^4::FlagNextWeek()
#^§::UnFlagorTrimCharacters()
#^<::LookForAllMailsRelated()


FlagToday()
{
	if WinActive("ahk_exe outlook.exe")
	{
		tm := A_Now
		FormatTime, tm, % tm, dd/MM/yyyy h:mm
		Icon := 0 ;olMarkToday
		Subject := "Hello"
		Outlook := ComObjActive("Outlook.Application")
		Item := Outlook.ActiveExplorer.Selection.Item(1)
		Item.MarkAsTask(0)
		Item.TaskStartDate := tm
		Item.TaskDueDate := tm
		Item.Save
	}
	
	If WinActive("Microsoft To Do ahk_exe ApplicationFrameHost.exe")
	{
		;MsgBox "lol"
		;Send {Return}
		;loop, 6
		;	Send {Tab}
	}
	else
	{
		
	}
Return
}

FlagTomorrow()
{
	if WinActive("ahk_exe outlook.exe")
	{
		tm := A_Now
		tm += 1, Days
		FormatTime, tm, % tm, dd/MM/yyyy h:mm
		Icon := 1 ;olMarkTomorrow
		Subject := "Hello"
		Outlook := ComObjActive("Outlook.Application")
		Item := Outlook.ActiveExplorer.Selection.Item(1)
		Item.MarkAsTask(Icon)
		Item.TaskStartDate := tm
		Item.TaskDueDate := tm
		Item.Save
	
		; We cleanup all the objects afterwards
		Selection:= "" ;
		Item := "" ;
		Outlook := "" ;
		Subject := "" ;
		Icon := "" ;
	}
	else
	{}
Return
}

FlagFriday()
{	
	if WinActive("ahk_exe outlook.exe")
	{
		tm := A_Now
		If A_WDay = 7
			{
			tm += 6, Days
			}
		Else
			{
			tm += 6-A_WDay, Days
			}
		FormatTime, tm, % tm, dd/MM/yyyy h:mm
		Icon := 2 ;olMarkThisWeek
		Subject := "Hello"
		Outlook := ComObjActive("Outlook.Application")
		Item := Outlook.ActiveExplorer.Selection.Item(1)
		Item.MarkAsTask(Icon)
		Item.TaskStartDate := tm
		Item.TaskDueDate := tm
		Item.Save
		
		; We cleanup all the objects afterwards
		Selection:= "" ;
		Item := "" ;
		Outlook := "" ;
		Subject := "" ;
		Icon := "" ;
	}
	else
	{}
Return
}


FlagNextWeek()
{
	if WinActive("ahk_exe outlook.exe")
	{
		
		tm := A_Now
		
		If A_WDay > 2
			{
			tm += 9-A_WDay, Days
			}
		Else
			{
			tm += 2-A_WDay, Days
			}
		
		FormatTime, tm, % tm, dd/MM/yyyy h:mm

		Icon := 3 ;olMarkNextWeek
		Subject := "Hello"
		Outlook := ComObjActive("Outlook.Application")
		Item := Outlook.ActiveExplorer.Selection.Item(1)
		Item.MarkAsTask(Icon)
		Item.TaskStartDate := tm
		Item.TaskDueDate := tm
		Item.Save
		
		; We cleanup all the objects afterwards
		Selection:= "" ;
		Item := "" ;
		Outlook := "" ;
		Subject := "" ;
		Icon := "" ;
	}
	else
	{}
Return
}





UnFlagorTrimCharacters()
{	
	if WinActive("ahk_exe outlook.exe")
	{

		tm := A_Now
		tm += -120, Days|

		FormatTime, tm, % tm, MM/dd/yyyy h:mm
		Icon := 3 ;olMarkNextWeek
		Subject := "Hello"
		Outlook := ComObjActive("Outlook.Application")
		Item := Outlook.ActiveExplorer.Selection.Item(1)
		Item.MarkAsTask(Icon)
		Item.TaskStartDate := tm
		Item.TaskDueDate := tm
	
	
		Icon := 5 olMarkComplete
		Subject := "Hello"
		Outlook := ComObjActive("Outlook.Application")
		Item := Outlook.ActiveExplorer.Selection.Item(1)
		Item.MarkAsTask(Icon)
		
		Item.TaskStartDate := tm
		Item.TaskDueDate := tm
		Item.ClearTaskFlag
		Item.Save
			
				
			; We cleanup all the objects afterwards
		Selection:= "" ;
		Item := "" ;
		Outlook := "" ;
		Subject := "" ;
		Icon := "" ;
	}
	
	
	
	else
	{
	; Jeeves - add points and vice versa for sparepartnumbers
		 StoredClipboard := Clipboard
		 
		If StrLen(StoredClipboard) = 10
		{
		 StringTrimRight, FirstPartOfSpareNumbers, StoredClipboard, 9
		 
		 StringTrimRight, SecondPartOfSpareNumbers, StoredClipboard, 5
		 StringTrimLeft, SecondPartOfSpareNumbers, SecondPartOfSpareNumbers, 1
		 
		 StringTrimRight, ThirdPartOfSpareNumbers, StoredClipboard, 1
		 StringTrimLeft, ThirdPartOfSpareNumbers, ThirdPartOfSpareNumbers, 5
		 
		 StringTrimLeft, FourthPartOfSpareNumbers, StoredClipboard, 9

		PointVariable = .

		ClipBoard :=  FirstPartOfSpareNumbers . PointVariable . SecondPartOfSpareNumbers . PointVariable . ThirdPartOfSpareNumbers . PointVariable . FourthPartOfSpareNumbers
		SoundBeep
		 Return
		}

		If StrLen(StoredClipboard) = 13
		{
		 StoredClipboard := StrReplace(StoredClipboard, ".", "")
		 Clipboard  :=  StoredClipboard
		 SoundBeep
		Return

		SoundBeep
		SoundBeep
		SoundBeep

		}
		Return
	}

}


Return




LookForAllMailsRelated()
{
#IfWinActive ahk_class OutlookGrid1

	Send +{F10}
	loop, 10 
		Send {Tab}
	Send {Return}
	Send {Return}
	
#IfWinActive
}


;;; FAKEFULLSCREENTOGGLE


ToggleFakeFullscreen()
{
CoordMode Screen, Window
static WINDOW_STYLE_UNDECORATED := -0xC40000
static savedInfo := Object()
WinGet, id, ID, A
if (savedInfo[id])
{
inf := savedInfo[id]
WinSet, Style, % inf["style"], ahk_id %id%
WinMove, ahk_id %id%,, % inf["x"], % inf["y"], % inf["width"], % inf["height"]
savedInfo[id] := ""
}
else
{
savedInfo[id] := inf := Object()
WinGet, ltmp, Style, A
inf["style"] := ltmp
WinGetPos, ltmpX, ltmpY, ltmpWidth, ltmpHeight, ahk_id %id%
inf["x"] := ltmpX
inf["y"] := ltmpY
inf["width"] := ltmpWidth
inf["height"] := ltmpHeight
WinSet, Style, %WINDOW_STYLE_UNDECORATED%, ahk_id %id%
mon := GetMonitorActiveWindow()
SysGet, mon, Monitor, %mon%
WinMove, A,, %monLeft%, %monTop%, % monRight-monLeft, % monBottom-monTop
}
}

GetMonitorAtPos(x,y)
{
;; Monitor number at position x,y or -1 if x,y outside monitors.
SysGet monitorCount, MonitorCount
i := 0
while(i < monitorCount)
{
SysGet area, Monitor, %i%
if ( areaLeft <= x && x <= areaRight && areaTop <= y && y <= areaBottom )
{
return i
}
i := i+1
}
return -1
}

GetMonitorActiveWindow(){
;; Get Monitor number at the center position of the Active window.
WinGetPos x,y,width,height, A
return GetMonitorAtPos(x+width/2, y+height/2)
}

#IfWinActive


; Shift + alt + .  TOGGLES HIDDEN FILES 
!+.:: 
; SHGetSetSettings works with structure full of bitfields; allocate space for it
VarSetCapacity(SHELLSTATE, 32, 0)
; get the current value of the show/hide setting and store it in the structure
DllCall("Shell32\SHGetSetSettings", "Ptr", &SHELLSTATE, "UInt", SSF_SHOWALLOBJECTS := 0x0001, "Int", false)
; invert the setting
NumPut(NumGet(SHELLSTATE) ^ (1 << 0), SHELLSTATE,, "Int")
; set the new setting from the value in the structure
DllCall("Shell32\SHGetSetSettings", "Ptr", &SHELLSTATE, "UInt", SSF_SHOWALLOBJECTS, "Int", true)
; get Explorer to send SHCNE_ASSOCCHANGED to all windows, which has the nice side effect of refreshing 'em
DllCall("Shell32\SHChangeNotify", "Int", SHCNE_ASSOCCHANGED := 0x8000000, "UInt", 0, "Ptr", 0, "Ptr", 0)
Return




#!^R::Reload
Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
Return





/**
 * Advanced Window Snap
 * Snaps the Active Window to one of nine different window positions.
 *
 * @author Andrew Moore <andrew+github@awmoore.com>
 * @version 1.0
 */

/**
 * SnapActiveWindow resizes and moves (snaps) the active window to a given position.
 * @param {string} winPlaceVertical   The vertical placement of the active window.
 *                                    Expecting "bottom" or "middle", otherwise assumes
 *                                    "top" placement.
 * @param {string} winPlaceHorizontal The horizontal placement of the active window.
 *                                    Expecting "left" or "right", otherwise assumes
 *                                    window should span the "full" width of the monitor.
 * @param {string} winSizeHeight      The height of the active window in relation to
 *                                    the active monitor's height. Expecting "half" size,
 *                                    otherwise will resize window to a "third".
 */
SnapActiveWindow(winPlaceVertical, winPlaceHorizontal, winSizeHeight) {
    WinGet activeWin, ID, A
    activeMon := GetMonitorIndexFromWindow(activeWin)

    SysGet, MonitorWorkArea, MonitorWorkArea, %activeMon%

    if (winSizeHeight == "half") {
        height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/2
    } else {
        height := (MonitorWorkAreaBottom - MonitorWorkAreaTop)/3
    }

    if (winPlaceHorizontal == "left") {
        posX  := MonitorWorkAreaLeft
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
    } else if (winPlaceHorizontal == "right") {
        posX  := MonitorWorkAreaLeft + (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
        width := (MonitorWorkAreaRight - MonitorWorkAreaLeft)/2
    } else {
        posX  := MonitorWorkAreaLeft
        width := MonitorWorkAreaRight - MonitorWorkAreaLeft
    }

    if (winPlaceVertical == "bottom") {
        posY := MonitorWorkAreaBottom - height
    } else if (winPlaceVertical == "middle") {
        posY := MonitorWorkAreaTop + height
    } else {
        posY := MonitorWorkAreaTop
    }

    WinMove,A,,%posX%,%posY%,%width%,%height%
}



/**
 * GetMonitorIndexFromWindow retrieves the HWND (unique ID) of a given window.
 * @param {Uint} windowHandle
 * @author shinywong
 * @link http://www.autohotkey.com/board/topic/69464-how-to-determine-a-window-is-in-which-monitor/?p=440355
 */
GetMonitorIndexFromWindow(windowHandle) {
    ; Starts with 1.
    monitorIndex := 1

    VarSetCapacity(monitorInfo, 40)
    NumPut(40, monitorInfo)

    if (monitorHandle := DllCall("MonitorFromWindow", "uint", windowHandle, "uint", 0x2))
        && DllCall("GetMonitorInfo", "uint", monitorHandle, "uint", &monitorInfo) {
        monitorLeft   := NumGet(monitorInfo,  4, "Int")
        monitorTop    := NumGet(monitorInfo,  8, "Int")
        monitorRight  := NumGet(monitorInfo, 12, "Int")
        monitorBottom := NumGet(monitorInfo, 16, "Int")
        workLeft      := NumGet(monitorInfo, 20, "Int")
        workTop       := NumGet(monitorInfo, 24, "Int")
        workRight     := NumGet(monitorInfo, 28, "Int")
        workBottom    := NumGet(monitorInfo, 32, "Int")
        isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

        SysGet, monitorCount, MonitorCount

        Loop, %monitorCount% {
            SysGet, tempMon, Monitor, %A_Index%

            ; Compare location to determine the monitor index.
            if ((monitorLeft = tempMonLeft) and (monitorTop = tempMonTop)
                and (monitorRight = tempMonRight) and (monitorBottom = tempMonBottom)) {
                monitorIndex := A_Index
                break
            }
        }
    }

    return %monitorIndex%
}

; Directional Arrow Hotkeys
#!Up::SnapActiveWindow("top","full","half")
#!Down::SnapActiveWindow("bottom","full","half")
^#!Up::SnapActiveWindow("top","full","third")
^#!Down::SnapActiveWindow("bottom","full","third")

; Numberpad Hotkeys (Landscape)
#!Numpad7::SnapActiveWindow("top","left","half")
#!Numpad8::SnapActiveWindow("top","full","half")
#!Numpad9::SnapActiveWindow("top","right","half")
#!Numpad1::SnapActiveWindow("bottom","left","half")
#!Numpad2::SnapActiveWindow("bottom","full","half")
#!Numpad3::SnapActiveWindow("bottom","right","half")

; Numberpad Hotkeys (Portrait)
^#!Numpad8::SnapActiveWindow("top","full","third")
^#!Numpad5::SnapActiveWindow("middle","full","third")
^#!Numpad2::SnapActiveWindow("bottom","full","third")

^!l::
Sleep 1000 ; if you use this with a hotkey, not sleeping will make it so your keyboard input wakes up the monitor immediately
SendMessage 0x112, 0xF170, 2,,Program Manager ; send the monitor into off mode
;wait for a key to be pressed
Input, SingleKey, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause} ;wait for a key to be pressed
SendMessage 0x112, 0xF170, -1,,Program Manager ; send the monitor into on mode
return




