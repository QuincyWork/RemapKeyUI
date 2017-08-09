Gui, Add, GroupBox, x13 y13 w307 h336 , 按键设置
Gui, Add, Text, x22 y39 w40 h20 , 源按键
Gui, Add, Text, x22 y70 w53 h12 , 映射类型
Gui, Add, Text, x22 y100 w53 h12 , 目标按键
Gui, Add, Text, x22 y130 w53 h12 , 时间间隔
Gui, Add, Text, x22 y160 w53 h20 , 进程窗口

Gui, Add, Edit, x112 y40 w190 h20 , Edit
Gui, Add, ComboBox, x112 y70 w190 h20 , ComboBox
Gui, Add, Edit, x112 y100 w190 h20 , Edit
Gui, Add, Edit, x112 y130 w190 h20 , Edit
Gui, Add, Edit, x112 y160 w190 h20 , Win+Space获取

Gui, Add, Text, x22 y279 w260 h20 , 说明：按键直接采用AHK识别的字符串输入
Gui, Add, Button, x22 y319 w60 h20 , 添加
Gui, Add, GroupBox, x326 y13 w226 h278 , 映射列表
Gui, Add, ListBox, x342 y39 w200 h240 , ListBox
Gui, Add, Button, x422 y299 w60 h20 , 清空
Gui, Add, Button, x492 y299 w60 h20 , 应用
Gui, Add, Button, x422 y329 w60 h20 , 导出
Gui, Add, Button, x492 y329 w60 h20 , 退出
Gui, Add, Button, x352 y299 w60 h20 , 删除
Gui, Add, Button, x352 y329 w60 h20 , 导入

; Generated using SmartGUI Creator 4.0
Gui, Show, x340 y302 h368 w573, New GUI Window
Return

GuiClose:
ExitApp