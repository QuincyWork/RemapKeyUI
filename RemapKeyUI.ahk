;-- 脚本名称:Diablo3 UI Script
;-- 脚本描述:暗黑3按键脚本(V0.1)
;-- 作者时间:QuincyHu 2017/8/1
;-- 修改记录:


;-- 待改列表：


#include HotkeyGUI.ahk

#NoEnv
#NoTrayIcon
#SingleInstance Ignore

;-- 全局变量
gvalConfFile := % A_ScriptDir . "\RemapKey.ini"
gvalMappedKeyList :=
gvalHotKeyArray :={}
gvalFuncArray :={}
;gCount := 0

;-- 界面
Gui, Add, GroupBox, x13 y13 w307 h336 , 按键设置
Gui, Add, Text, x22 y41 w40 h20 , 源按键
Gui, Add, Text, x22 y71 w53 h20 , 映射类型
Gui, Add, Text, x22 y101 w53 h20 , 目标按键
Gui, Add, Text, x22 y131 w60 h20 , 目标按键2
Gui, Add, Text, x22 y161 w53 h20 , 时间间隔
Gui, Add, Text, x22 y191 w53 h20 , 进程窗口

Gui, Add, Edit, x112 y40 w160 h20 vSouceKey, 
Gui, Add, Button, x272 y40 w30 h20 gSourceKeySelect, ...
Gui, Add, ComboBox, x112 y70 w190 h20 R15 vMapKeyType Choose1, 映射单次|映射多次|映射定时|映射按下
Gui, Add, Edit, x112 y100 w160 h20 vTargetKey, 特殊按键需要加{}
Gui, Add, Button, x272 y100 w30 h20 gTargetKeySelect, ...
Gui, Add, Edit, x112 y130 w190 h20 vTargetKey2,
Gui, Add, Edit, x112 y160 w190 h20 vTimeDelay, 1000
Gui, Add, Edit, x112 y190 w190 h20 vActiveWindow, Win+Space获取

Gui, Add, Text, x22 y240 w280 h60 , 说明：`r`n输入采用AHK识别的按键字符,可以多个按键组合.`r`n[Win+/]应用中控制脚本继续或暂停.`r`n[Win+Space]获取当前窗口，用于按键绑定窗口.
Gui, Add, Button, x22 y319 w60 h20 gMapKeyAdd, 添加

Gui, Add, GroupBox, x326 y13 w226 h278 , 映射列表
Gui, Add, ListBox, x342 y39 w200 h240 +HScroll vMappedKeyList,

Gui, Add, Button, x352 y299 w60 h20 gMapListDelete, 删除
Gui, Add, Button, x422 y299 w60 h20 gMapListClear, 清空
Gui, Add, Button, x492 y299 w60 h20 gMapListApply, 应用
Gui, Add, Button, x422 y329 w60 h20 gMapListExport, 导出
Gui, Add, Button, x352 y329 w60 h20 gMapListImport, 导入
Gui, Add, Button, x492 y329 w60 h20 gMapKeyStop, 停止

;-- 加载配置
IfExist %gvalConfFile%
{
	IniRead,gvalMappedKeyList,%gvalConfFile%,KeyMapping,Default
	IniRead,varActiveWindow,%gvalConfFile%,KeyMapping,Window
	GuiControl,,MappedKeyList,|%gvalMappedKeyList%
	GuiControl,,ActiveWindow,%varActiveWindow%	
}

;-- 界面变量初始化
Gui, Show, x287 y188 h364 w569, RemapKeyUI

Return

;-- 界面响应事件
SourceKeySelect:
	valSelect:=HotkeyGUI("","","",True)
	GuiControl,,SouceKey,%valSelect%	
Return

TargetKeySelect:
	valSelect:=HotkeyGUI("","","",True,"",True)
	GuiControl,,TargetKey,%valSelect%	
	GuiControl,,TargetKey2,
Return

;-- 获取当前窗口
#Space::
	WinGetClass, vClassName, A
	GuiControl,,ActiveWindow,%vClassName%
Return

;-- 添加键映射
MapKeyAdd:
	Gui,Submit,NoHide
	
	valMappingKey = %SouceKey%=>%MapKeyType%:%TargetKey%-%TargetKey2%:%TimeDelay%	
	gvalMappedKeyList = %gvalMappedKeyList%%valMappingKey%|
	GuiControl,,MappedKeyList,|%gvalMappedKeyList%
	
Return

MapListDelete:
	Gui, Submit, NoHide
	
	if MappedKeyList=
	{
		Return
	}
	
	StringReplace,gvalMappedKeyList,gvalMappedKeyList,%MappedKeyList%|,	
	GuiControl,,MappedKeyList,|%gvalMappedKeyList%
	
Return

MapListClear:	
	gvalMappedKeyList :=
	GuiControl,,MappedKeyList,|
Return

;-- 应用按键映射配置
MapListApply:
	Gui,Submit,NoHide
	
	UnRegisterHotKeys()
	vCount := 0
	
	if ActiveWindow!=
	{	
		HotKey,IfWinActive,ahk_class %ActiveWindow%
	}
	
	Loop, Parse, gvalMappedKeyList, |
	{
		if A_LoopField !=
		{	
			; 格式Source=>Type:Target-Target2:Time
			StringReplace,valField,A_LoopField,=>,:,All			
			StringSplit,valArray,valField,:	
			StringSplit,valTarget,valArray3,-			
			vSource := vKey := valArray1			
			; 替换vSource中特殊字符
			StringReplace,vSource,vSource,*
			
			; 如果源和目标按键一样，则添加$
			if valArray1 = %valTarget1%
			{
				vKey = % "$" . valArray1
			}
			gvalHotKeyArray[vKey] := {Type: valArray2, Source: vSource, Target: valTarget1, Target2:valTarget2, Time: valArray4}
			
			; 动态注册热键			
			RegisterHotKey(vKey,valArray2,valTarget1,valArray4)
			vCount := vCount + 1
		}
	}
	
	IniWrite,%gvalMappedKeyList%,%gvalConfFile%,KeyMapping,Default	
	IniWrite,%ActiveWindow%,%gvalConfFile%,KeyMapping,Window
	MsgBox, 应用成功
	
Return

MapListExport:
	Gui,Submit,NoHide
	
	Thread, NoTimers
	FileSelectFile, vSaveFileName, S18, *.ini
	Thread, NoTimers, false
	
	if vSaveFileName!=
	{
		IniWrite,%gvalMappedKeyList%,%vSaveFileName%,KeyMapping,Default
		IniWrite,%ActiveWindow%,%vSaveFileName%,KeyMapping,Window
		MsgBox, 导出成功
	}	
	
Return

MapListImport:
	
	Thread, NoTimers
	FileSelectFile, vOpenFileName, *.ini
	Thread, NoTimers, false
	
	if vOpenFileName!=
	{
		IniRead,gvalMappedKeyList,%vOpenFileName%,KeyMapping,Default
		IniRead,varActiveWindow,%vOpenFileName%,KeyMapping,Window
		GuiControl,,MappedKeyList,|%gvalMappedKeyList%
		GuiControl,,ActiveWindow,%varActiveWindow%		
		MsgBox, 导入成功
	}
Return

MapKeyStop:
UnRegisterHotKeys()
MsgBox, 停止成功
Return

GuiClose:
ExitApp

;-- 通过快捷键方式停止/启用HotKey
#/::Suspend

;-- 处理映射一次按键的HotKey
OnHotKeyType1Handler:

	vInfo := gvalHotKeyArray[A_ThisHotkey]
	if vInfo.HasKey("Target")
	{
		vKeyValue := vInfo.Target
		Send, %vKeyValue%
	}
Return

;-- 处理映射多次按键,弹起时停止的HotKey
OnHotKeyType2Handler:

	vInfo := gvalHotKeyArray[A_ThisHotkey]
	if vInfo.HasKey("Target")
	{
		vKeySource := vInfo.Source		
		vKeyTarget := vInfo.Target
		vTime := vInfo.Time
		
		Loop
		{			
			Send, %vKeyTarget%
			Sleep,%vTime%
			
		}Until Not GetKeyState(vKeySource,"P")
				
		;gCount := gCount + 1
		;ToolTip, % "Key UP " . vKeySource . " C=" . gCount . " S=" . (GetKeyState("b","P") ? "True" : "False") 
	}
Return

;-- 处理映射定时按键,按下开始,再按下停止的HotKey
OnHotKeyType3Handler:
		
	vInfo := gvalHotKeyArray[A_ThisHotkey]
	if vInfo.HasKey("Target")
	{
		vFuncObj := gvalFuncArray[A_ThisHotkey]		
		if not IsObject(vFuncObj)
		{
			gvalFuncArray[A_ThisHotkey] := vFuncObj := Func("OnHotKeyTimerHandler").bind(vInfo.Target)						
			vTime := vInfo.Time
			vKeyValue := vInfo.Target
			Send,%vKeyValue%
			SetTimer, %vFuncObj%, %vTime%
		}
		else
		{
			gvalFuncArray.Delete(A_ThisHotkey)
			;gvalFuncArray[A_ThisHotkey] :=
			SetTimer, %vFuncObj%, Off
		}
	}
Return

OnHotKeyTimerHandler(Key)
{	
	;-- 两种可选 
	;While A_IsSuspended
	;{
	;	Sleep, 1000
	;}
	;Send,%Key%
	
	If not A_IsSuspended
	{
		Send,%Key%
	}	
}

;-- 处理映射按下,按下是，对应的几个按键一起按下
OnHotKeyType4Handler:

	vInfo := gvalHotKeyArray[A_ThisHotkey]
	if vInfo.HasKey("Target")
	{
		vKeySource := vInfo.Source		
		vKeyTarget := vInfo.Target
		vKeyTarget2:= vInfo.Target2		
		
		Send, %vKeyTarget%
		KeyWait, %vKeySource%
		Send, %vKeyTarget2%	
		;ToolTip, %vKeySource% %vKeyTarget% %vKeyTarget2%
	}
	
Return

;-- 辅助函数
RegisterHotKey(Key,Type,Target,Time)
{	
	;ToolTip, %Key% %Type% %Target% %Time%
	
	; 根据按键映射类型来选择HotKey的Label	
	if Type = 映射单次
	{		
		HotKey,%Key%,OnHotKeyType1Handler
	}
	else if Type = 映射多次
	{
		HotKey,%Key%,OnHotKeyType2Handler
	}
	else if Type = 映射定时
	{
		HotKey,%Key%,OnHotKeyType3Handler
	}
	else if Type = 映射按下
	{
		HotKey,%Key%,OnHotKeyType4Handler
	}
	
	HotKey,%Key%,On
}

UnRegisterHotKeys()
{	
	global gvalFuncArray
	global gvalHotKeyArray
	
	; 停止定时器	
	For Key, Value in gvalFuncArray
	{
		SetTimer, %Value%, Off		
	}
	
	; 停止HotKey	
	For Key, Value in gvalHotKeyArray
	{
		Hotkey, %Key%, Off
	}
	
	gvalFuncArray := {}
	gvalHotKeyArray := {}
}

