#include HotkeyGUI.ahk

#NoEnv
#NoTrayIcon
#SingleInstance Ignore

Gui, Add, Button, x10 y10 w60 h20 gMapKeyAdd, Add
Gui, Show, , Untitled GUI
return

MapKeyAdd:
Value:="A=>映射用户:C:1000"
StringReplace,valField,%Value%,=>,:,All

Select:=HotkeyGUI()
MsgBox,%Select%

GuiClose:
ExitApp