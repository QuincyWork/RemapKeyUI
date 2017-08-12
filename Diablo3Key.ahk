;-- 脚本名称:Diablo3 死灵脚本
;-- 脚本描述:暗黑3死灵脚本按键脚本(V0.1)
;-- 作者时间:QuincyHu 2017/8/1
;-- 修改记录:
	/*
	1、修改死灵双分骷髅召唤套按键脚本 2017/8/10
	*/

;-- 功能说明：
	/*	
	1、吞噬定时按键
	2、使用按键代替鼠标键
	3、双分绑定骷髅法师
	4、死地绑定快速定时吞噬
	
	按键绑定
	A--吞噬
	S--骨甲
	D--双分
	F--鼠标左键 骨刺
	E--鼠标右键 骨法
	R--死地	
	*/

#NoEnv
#SingleInstance Ignore

;-- 全局变量
AKeyTimmerFlag := 0


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

;-- 按键D 绑定成按双分和骷髅法师
*$d::
Send,d
Sleep,200
Send,{RButton}
Return

;-- 按键E 绑定成鼠标右键,释放骷髅法师
*e::
Send,{RButton}
Return

;-- 按键F 绑定成按下Shift+Left Mouse
f::
Send,{Shift Down}{LButton Down}	
KeyWait,f
Send,{Shift Up}{LButton Up}	
Return

;-- 按键R 绑定死地和快速定时吞噬
*$r::
Send,r
Sleep,200
AKeyTimmerFlag := True
SetTimer,OnAKeyTimmerHandler,500
Return

#IfWinActive

;-- 暂停和继续脚本.
#/::Suspend
