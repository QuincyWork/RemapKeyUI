;
; Diablo3 key tools
;

#NoEnv
#NoTrayIcon
#SingleInstance Ignore
AFlag:=false
EFlag:=false
vCount:=0

; Pressing a once will repeat send a. Pressing a again will stop repeat.
~$a::
if AFlag:=!AFlag
	SetTimer,AKeyPress,2000
else
	SetTimer,AKeyPress,Off
Return 

AKeyPress:
	Send,a
Return

; Pressing f will cause send Shift+Left Mouse
f::
loop
{
	;Send,+{LButton}
	Send,G
	Sleep,500
}Until Not GetKeyState("f","P")

vCount:= vCount+1
ToolTip, % "Key UP " . vCount . "State=" . (GetKeyState("f","P") ? "True" : "False") 

Return

; Pressing e will send right mouse click
e::
Send,{RButton}
Return

; Pressing Win+/ once will exit the script.
#/::ExitApp