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
;;            +----+----+----+
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



#Numpad0::
  GoSub, RestoreOrMinimize
return
#Numpad1::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrBottom/2.0,ScrRight/2.0,ScrBottom/2.0
return
#Numpad2::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrBottom/2.0,ScrRight,ScrBottom/2.0
return
#Numpad3::
  GoSub, MoveInit
  WinMove,A,,ScrRight/2.0,ScrBottom/2.0,ScrRight/2.0,ScrBottom/2.0
return
#Numpad4::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/2.0,ScrBottom
return
#Numpad5::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight,ScrBottom
return
#Numpad6::
  GoSub, MoveInit
  WinMove,A,,ScrRight/2.0,ScrTop,ScrRight/2.0,ScrBottom
return
#Numpad7::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/2.0,ScrBottom/2.0
return
#Numpad8::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight,ScrBottom/2.0
return
#Numpad9::
  GoSub, MoveInit
  WinMove,A,,ScrRight/2.0,ScrTop,ScrRight/2.0,ScrBottom/2.0
return



#^Numpad0::
  GoSub, RestoreOrMinimize
return
#^Numpad1::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrBottom/3.0*2,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad2::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0,ScrBottom/3.0*2,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad3::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0*2,ScrBottom/3.0*2,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad4::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrBottom/3.0,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad5::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0,ScrBottom/3.0,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad6::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0*2,ScrBottom/3.0,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad7::
  GoSub, MoveInit
  WinMove,A,,ScrLeft,ScrTop,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad8::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0,ScrTop,ScrRight/3.0,ScrBottom/3.0
return
#^Numpad9::
  GoSub, MoveInit
  WinMove,A,,ScrRight/3.0*2,ScrTop,ScrRight/3.0,ScrBottom/3.0
return
