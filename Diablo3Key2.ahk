;-- 脚本名称:Diablo3 死灵脚本
;-- 脚本描述:暗黑3死灵脚本按键脚本(V0.1)
;-- 作者时间:QuincyHu 2017/8/1
;-- 修改记录:
	/*
	1、修改死灵血矛套按键脚本 2017/8/16
	*/

;-- 功能说明：
	/*	
	1、吞噬定时按键
	2、使用按键代替鼠标键	
	3、死地绑定双分和快速定时吞噬
	4、尸矛定时按键
	
	按键绑定
	A--吞噬
	S--尸矛
	D--双分
	R--死地+双分+快速定时吞噬
	
	F--鼠标左键 Shift+镰刀/衰弱
	E--鼠标右键 鲜血直行

	1--定时吞噬
	2--定时尸矛
	*/

#NoEnv
#SingleInstance Ignore

;-- 全局变量
AKeyTimmerFlag := 0
SKeyTimmerFlag := 0


;-- 按键绑定
#IfWinActive ahk_class D3 Main Window Class

;-- 按键1 开启较慢定时吞噬，同时可以看情况自己按A来吞噬
*1::
if AKeyTimmerFlag:=!AKeyTimmerFlag	
	SetTimer,OnAKeyTimmerHandler,1000
else
	SetTimer,OnAKeyTimmerHandler,Off
Return 

OnAKeyTimmerHandler:
	If not A_IsSuspended
	{
		Send,a
	}
Return

;-- 按键E 绑定成鼠标右键
*e::
Send,{RButton}
Return

*f::
Send,{LButton}
Return

;-- 按键S 绑定成按下
*$s::
Loop
{			
	Send, s
	Sleep,300
			
}Until Not GetKeyState("s","P")

Return

;-- 按键R 绑定双分和死地和快速定时吞噬
*$r::
Send,d
Sleep,200
Send,r
Sleep,200
AKeyTimmerFlag := True
SetTimer,OnAKeyTimmerHandler,500
Return



#IfWinActive

;-- 暂停和继续脚本.
#/::Suspend
