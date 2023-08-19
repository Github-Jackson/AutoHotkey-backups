#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
/*
===========================================
[屏幕抓字生成字库工具与找字函数]v5.6  By FeiYue
===========================================

更新历史：

v5.6 改进：颜色模式增加了对偏色的支持，方便高手在游戏中使用。

v5.5 改变：取消了后台查找，因为Win7以上系统不太适用。
改进：直接生成单行的字库，用其他控件来显示字库对应的图像。

v5.3 改进：容差增加为两个，分别是 0_字符 的容许误差百分比。
采用新的算法，提高了带容差参数时的查找速度。
容差为默认值0时，找不到会自动使用 5% 的容差再找一次。

v5.2 改进：新增后台查找，相当于把指定ID的窗口搬到前台再查找。
因此用于前台操作的找字找图代码不用修改就可以转到后台模式。
注：Win7以上系统因PrintWindow不太好用，因此许多窗口不支持。

v5.0 改进：新增了第三种查找模式：边缘灰差模式。

v4.6 改进：增加对多显示器扩展显示的支持。

v4.5 改进：修正了Win10-64位系统的一些兼容性问题。
提高了抓字窗口中二值化、删除操作的反应速度。

v4.3 改进：文字参数中，每个字库文字可以添加用中括号括起来
的容差值，没有中括号才用“查找文字”函数中的容差参数。

v4.2 改进：新增了64位系统的机器码，可用于AHK 64位版。

v4.1 改进：不再使用GDI+获取屏幕图像，直接用GDI实现。

v4.0 改进：文字参数增加竖线分隔的字库形式，可以进行
OCR识别。这种形式也可用于同时查找多幅文字或图片。

v3.5 改进：采用自写的机器码实现图内找字，极大的提高了速度。

===========  屏幕抓字生成字库工具 使用说明  ===========

1、先点击主界面的[抓取文字图像]，然后[移动鼠标]到你要
抓取的文字或图像，然后[点击鼠标左键]，再[移开鼠标]
100像素以上，会弹出“抓字生成字库”界面。

2、抓字界面会显示抓取图像的彩色放大图像，先要将它二值化为
黑白图像。目前提供了三种二值化方式，任意选一种就行。

（1）颜色二值化：如果文字是单色的，最好采取这种方式。
在放大的图像中[点击某种颜色]，然后点击[颜色二值化]。
如果不是单色的，则选定主要颜色后，手动输入偏色，也能够
以颜色加减偏色来二值化（如：红色+/-红色偏色都视为同色）。

（2）灰差二值化：手动输入灰差后（或直接采用默认的50），
点击[灰差二值化]。这种方式容易统一阀值，但黑点偏少。

（3）直接点击[灰度二值化]就会自动计算出一个灰度阀值，
并以这个阀值二值化。自动计算是针对整个图像的所有点的，
所以最好先[手动裁剪]图像边缘，留下中心的图像后再二值化。
当然如果对自动计算的阀值不满意，可以手动输入阀值，慢慢
调整看哪个效果好。另外要统一阀值添加字库时也要手动输入。

3、图像二值化后，可以点击[智删]或[左删]等来裁剪边缘，再
点击[确定]，即可在主窗口生成调用“查找文字()”的代码。

4、如果要进行OCR文字识别，那么可以在“识别结果文字”输入框中
输入这幅图像或文字的识别结果（随便写），之后如果点击
[字库分割添加]，那么结果文字的每个字都对应图像中以空列
分割的一部分，而如果点击[字库整体添加]则结果文字整体
对应于这幅图像的整体。这两种添加都不会改变主窗口的代码。
提示：可以用[修改]清除一些点生成空列来分开连在一起的字。
也可以添加一些点让左右结构的字不要被空列分割开。
这样修改了原始图像后，代码中的两个容差最好都大于0。
另外逗号等自动分割会裁边，建议手动裁剪保留空白边缘。
注意：字库应统一阀值。一般先在第3步点击确定生成代码，然后
再抓字添加字库，这时要统一采用上一次的阀值来二值化。

5、回到主窗口，点击[全屏查找测试]，测试成功后，点击
[复制代码]，并粘贴到你自己的脚本中，这时还运行不了，
因为你的代码中没有“查找文字()”函数。请在我的源代码的
最后面找到“查找文字()”函数，将它及后面的函数都复制到
你自己的脚本中就行了（保存成库文件然后 #Include 也行）。

6、由于许多因素会影响屏幕图像，所以换一台电脑一般就要重新
抓字/抓图。设置一样的屏幕分辨率、浏览器放大倍数、（取消）
平滑屏幕字体边缘，可能通用性高一些。单色文字也通用一些。

===========  找字函数 使用说明  ===========

是否成功 := 查找文字( 中心点X, 中心点Y, 左右偏移W, 上下偏移H
, 文字, 颜色, 返回X, 返回Y, 返回OCR结果
, 0字符容许误差百分比, _字符容许误差百分比 )

1、屏幕查找范围为(X-W, Y-H)—>(X+W, Y+H)，返回找到文字的中心坐标。

2、颜色带*号的为灰度阀值（或灰差）模式，对于非单色的文字比较好用。

3、颜色不带*号为“RRGGBB-偏色RR偏色GG偏色BB”格式，同大漠一样。

4、末尾的容差参数允许有一些点不同，取值范围 0~1（即 0%~100%）。

5、如果颜色模式的偏色不为0，则末尾两个容差参数也最好大于0。

6、对于游戏中搜图常用的背景透明图，把“_字符”容差取1即可。

7、注意抓字时是鼠标移开后再抓的，如果查找文字时鼠标刚好在
目标位置并造成了变色、凹凸等影响，可能要移开后再查找。

===========================================
*/

#NoEnv
#SingleInstance Force
SetBatchLines, -1
CoordMode, Mouse
CoordMode, Pixel
CoordMode, ToolTip
SetTitleMatchMode, 2
SetWorkingDir, %A_ScriptDir%
;----------------------------
Menu, Tray, Icon, Shell32.dll, 23
Menu, Tray, Add
Menu, Tray, Add, 显示主窗口
Menu, Tray, Default, 显示主窗口
Menu, Tray, Click, 1
;-- 左右上下抓字抓图的范围
ww:=35, hh:=12
;ww:=70, hh:=24
nW:=2*ww+1, nH:=2*hh+1
;----------------------------
gosub, 生成抓字窗口
gosub, 生成主窗口
OnExit, savescr
gosub, readscr
return

F12::    ; 按[F12]保存修改并重启脚本
	SetTitleMatchMode, 2
	SplitPath, A_ScriptName,,,, name
	IfWinExist, %name%
	{
		ControlSend, ahk_parent, {Ctrl Down}s{Ctrl Up}
		
		Sleep, 500
	}
	Reload
return

readscr:
	f=%A_Temp%\~scr1.tmp
	FileRead, s, %f%
	GuiControl, Main:, scr, %s%
	s=
return

savescr:
	f=%A_Temp%\~scr1.tmp
	GuiControlGet, s, Main:, scr
	FileDelete, %f%
	FileAppend, %s%, %f%
	ExitApp

显示主窗口:
	Gui, Main:Show, CEnter
return

生成主窗口:
	Gui, Main:Default
	Gui, +AlwaysOnTop +HwndMain_ID
	Gui, Margin, 15, 15
	Gui, Color, DDEEFF
	Gui, Font, s6 bold, Verdana
	Gui, Add, Edit, xm w660 r25 vMyEdit -Wrap -VScroll
	Gui, Font, s12 norm, Verdana
	Gui, Add, Button, xm w220 gMainRun, 抓取文字图像
	Gui, Add, Button, x+0 wp gMainRun, 全屏查找测试
	Gui, Add, Button, x+0 wp gMainRun, 复制代码
	Gui, Font, s12 cBlue, Verdana
	Gui, Add, Edit, xm w660 h350 vscr Hwndhscr -Wrap HScroll
	Gui, Show, NA, 文字/图像字库生成工具
	;---------------------------------------
	OnMessage(0x100, "EditEvents1")  ; WM_KEYDOWN
	OnMessage(0x201, "EditEvents2")  ; WM_LButtonDOWN
return

EditEvents1() {
	ListLines, Off
	if (A_Gui="Main") and (A_GuiControl="scr")
		SetTimer, 显示文字, -100
}

EditEvents2() {
	ListLines, Off
	if (A_Gui="catch")
		WM_LBUTTONDOWN()
	else
		EditEvents1()
}

显示文字:
	ListLines, Off
	Critical
	ControlGet, i, CurrentLine,,, ahk_id %hscr%
	ControlGet, s, Line, %i%,, ahk_id %hscr%
	if RegExMatch(s,"(\d+)\.([\w+/]{3,})",r)
	{
		s:=RegExReplace(base64tobit(r2),".{" r1 "}","$0`n")
		s:=StrReplace(StrReplace(s,"0","_"),"1","0")
	}
	else s=
	GuiControl, Main:, MyEdit, % Trim(s,"`n")
return

MainRun:
	k:=A_GuiControl
	WinMinimize
	Gui, Hide
	DetectHiddenWindows, Off
	WinWaitClose, ahk_id %Main_ID%
	if IsLabel(k)
		gosub, %k%
	Gui, Main:Show
	GuiControl, Main:Focus, scr
return

复制代码:
	GuiControlGet, s,, scr
	Clipboard:=StrReplace(s,"`n","`r`n")
	s=
return

抓取文字图像:
	;------------------------------
	; 先用一个微型GUI提示抓字范围
	Gui, Mini:Default
	Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x08000000
	WinSet, Transparent, 100
	Gui, Color, Red
	Gui, Show, Hide w%nW% h%nH%
	;------------------------------
	Hotkey, $*LButton, _LButton_Off, On
	ListLines, Off
	loop {
		MouseGetPos, px, py
		if GetKeyState("LButton","P")
			break
		Gui, Show, % "NA x" (px-ww) " y" (py-hh)
		ToolTip, % "当前鼠标位置：" px "," py
		. "`n请移到目标位置后点击左键"
		Sleep, 20
	}
	KeyWait, LButton
	Gui, Color, White
	loop {
		MouseGetPos, x, y
		if Abs(px-x)+Abs(py-y)>100
			break
		Gui, Show, % "NA x" (x-ww) " y" (y-hh)
		ToolTip, 请把鼠标移开100像素以上
		Sleep, 20
	}
	ToolTip
	ListLines, On
	Hotkey, $*LButton, Off
	Gui, Destroy
	WinWaitClose
	cors:=getc(px,py,ww,hh)
	Gui, catch:Default
	loop, 6
		GuiControl,, Edit%A_Index%
	GuiControl,, huicha, 50
	GuiControl,, xiugai, % xiugai:=0
	gosub, 重读
	Gui, Show, CEnter
	GuiControl, Focus, fazhi
	DetectHiddenWindows, Off
	WinWaitClose, ahk_id %catch_ID%
_LButton_Off:
return

WM_LBUTTONDOWN() {
	global
	ListLines, Off
	MouseGetPos,,,, mclass
	if !InStr(mclass,"Progress")
		return
	MouseGetPos,,,, mid, 2
	For k,v in C_
		if (v=mid)
		{
			if (xiugai and bg!="")
			{
				c:=cc[k], cc[k]:=c="0" ? "_" : c="_" ? "0" : c
				c:=c="0" ? "White" : c="_" ? "Black" : WindowColor
				gosub, SetColor
			}
			else
			{
				c:=cors[k]
				GuiControl, catch:, yanse, % StrReplace(c,"0x")
				c:=((c>>16&0xFF)*38+(c>>8&0xFF)*75+(c&0xFF)*15)>>7
				GuiControl, catch:, huidu, %c%
			}
			return
		}
}

getc(px,py,ww,hh) {
	xywh2xywh(px-ww,py-hh,2*ww+1,2*hh+1,x,y,w,h)
	if (w<1 or h<1)
		return, 0
	bch:=A_BatchLines
	SetBatchLines, -1
	;--------------------------------------
	GetBitsFromScreen(x,y,w,h,Scan0,Stride,bits)
	;--------------------------------------
	cors:=[], k:=0, nW:=2*ww+1, nH:=2*hh+1
	ListLines, Off
	fmt:=A_FormatInteger
	SetFormat, IntegerFast, H
	loop, %nH% {
		j:=py-hh-y+A_Index-1
		loop, %nW% {
			i:=px-ww-x+A_Index-1, k++
			if (i>=0 and i<w and j>=0 and j<h)
				c:=NumGet(Scan0+0,i*4+j*Stride,"uint")
				, cors[k]:="0x" . SubStr(0x1000000|c,-5)
			else
				cors[k]:="0xFFFFFF"
		}
	}
	SetFormat, IntegerFast, %fmt%
	ListLines, On
	; 左右上下超出屏幕边界的值
	cors.left:=Abs(px-ww-x)
	cors.Right:=Abs(px+ww-(x+w-1))
	cors.up:=Abs(py-hh-y)
	cors.down:=Abs(py+hh-(y+h-1))
	SetBatchLines, %bch%
	return, cors
}

全屏查找测试:
	GuiControlGet, s, Main:, scr
	wenzi=
	while RegExMatch(s,"文字[.:]=""([^""]+)""",r)
		wenzi.=r1, s:=StrReplace(s,r,"","",1)
	if !RegExMatch(s,"查找文字\(([^)]+)\)",r)
		return
	StringSplit, r, r1, `,, ""
	if r0<6
		return
	t1:=A_TickCount
	ok:=查找文字(r1,r2,r3,r4,wenzi,r6,X,Y,OCR,r10,r11)
	t1:=A_TickCount-t1
	MsgBox, 4096,, % "查找结果：" (ok ? "成功":"失败")
	. "`n`n文字识别结果：" OCR
	. "`n`n耗时：" t1 " 毫秒，找到的位置：" (ok ? X "," Y:"")
	if ok
	{
		MouseMove, X, Y
		Sleep, 1000
	}
return


生成抓字窗口:
	WindowColor:="0xCCDDEE"
	Gui, catch:Default
	Gui, +LastFound +AlwaysOnTop +ToolWindow +Hwndcatch_ID
	Gui, Margin, 15, 15
	Gui, Color, %WindowColor%
	Gui, Font, s16, Verdana
	ListLines, Off
	w:=(2*35+1)*14//nW+1, h:=(2*12+1)*14//nH+1
	loop, % nH*nW {
		j:=A_Index=1 ? "" : Mod(A_Index,nW)=1 ? "xm y+-1" : "x+-1"
		Gui, Add, Progress, w%w% h%h% %j% -Theme
	}
	ListLines, On
	Gui, Add, Button, xm+120 w70 gRun Section, 上删
	Gui, Add, Button, x+0 wp gRun, 上3
	Gui, Add, Button, xm y+15 wp gRun, 左删
	Gui, Add, Button, x+0 wp gRun, 左3
	Gui, Add, Button, x+15 wp gRun, 智删
	Gui, Add, Button, x+15 wp gRun, 右删
	Gui, Add, Button, x+0 wp gRun, 右3
	Gui, Add, Button, xm+120 y+15 wp gRun, 下删
	Gui, Add, Button, x+0 wp gRun, 下3
	;-------------------------
	Gui, Add, Text,   xm+410 ys+10 Section w60 CEnter, 颜色
	Gui, Add, Edit,   x+2 w120 vyanse ReadOnly
	Gui, Add, Text,   x+2 w60 CEnter, 偏色
	Gui, Add, Edit,   x+2 w120 vpianse Limit6
	Gui, Add, Button, x+5 yp-6  w140 gRun, 颜色二值化
	;-------------------------
	Gui, Add, Text,   xs w60 CEnter, 灰度
	Gui, Add, Edit,   x+2 w120 vhuidu ReadOnly
	Gui, Add, Text,   x+2 w60 CEnter, 阀值
	Gui, Add, Edit,   x+2 w120 vfazhi
	Gui, Add, Button, x+5 yp-6  w140 gRun Default, 灰度二值化
	;-------------------------
	Gui, Add, Text,   xs w244 CEnter, 灰差阀值(与四周比较)
	Gui, Add, Edit,   xs+246 yp w120 vhuicha
	Gui, Add, Button, x+5 yp-6  w140 gRun, 灰差二值化
	;-------------------------
	Gui, Add, Button, xm gRun, 重读
	Gui, Add, Checkbox, x+15 yp+6 vxiugai gRun, 修改黑白色
	Gui, Add, Text,   x+30,  字库识别结果
	Gui, Add, Edit,   x+5 w140 vziku
	Gui, Add, Button, x+5 yp-6 gRun, 分割添加
	Gui, Add, Button, x+5 gRun, 整体添加
	Gui, Add, Button, x+30 gRun, 确定
	Gui, Add, Button, x+10 gCancel, 关闭
	;-------------------------
	Gui, Show, Hide, 抓字生成字库
	WinGet, s, ControlListHwnd
	C_:=StrSplit(s,"`n"), s:=""
return

Run:
	Critical
	k:=A_GuiControl
	if IsLabel(k)
		goto, %k%
return

xiugai:
	GuiControlGet, xiugai
return

SetColor:
	c:=c="White" ? 0xFFFFFF : c="Black" ? 0x000000
: ((c&0xFF)<<16)|(c&0xFF00)|((c&0xFF0000)>>16)
	SendMessage, 0x2001, 0, c,, % "ahk_id " . C_[k]
return

重读:
	if !IsObject(cc)
		cc:=[], gg:=[], pp:=[]
	left:=Right:=up:=down:=k:=0, bg:=""
	loop, % nH*nW {
		cc[++k]:=1, c:=cors[k]
		gg[k]:=((c>>16&0xFF)*38+(c>>8&0xFF)*75+(c&0xFF)*15)>>7
		gosub, SetColor
	}
	; 裁剪抓字范围超过屏幕边界的部分
	loop, % cors.left
		gosub, 左删
	loop, % cors.Right
		gosub, 右删
	loop, % cors.up
		gosub, 上删
	loop, % cors.down
		gosub, 下删
return

颜色二值化:
	GuiControlGet, c,, yanse
	GuiControlGet, dc,, pianse
	if c=
	{
		MsgBox, 4096,, `n    请先进行选色！    `n, 1
		return
	}
	dc:=dc="" ? "000000" : StrReplace(dc,"0x")
	color:=c "-" dc, k:=i:=0
	c:=Round("0x" c), dc:=Round("0x" dc)
	R:=(c>>16)&0xFF, G:=(c>>8)&0xFF, B:=c&0xFF
	dR:=(dc>>16)&0xFF, dG:=(dc>>8)&0xFF, dB:=dc&0xFF
	R1:=R-dR, G1:=G-dG, B1:=B-dB
	R2:=R+dR, G2:=G+dG, B2:=B+dB
	loop, % nH*nW {
		if (cc[++k]="")
			continue
		c:=cors[k], R:=(c>>16)&0xFF, G:=(c>>8)&0xFF, B:=c&0xFF
		if (R>=R1 && R<=R2 && G>=G1 && G<=G2 && B>=B1 && B<=B2)
			cc[k]:="0", c:="Black", i++
		else
			cc[k]:="_", c:="White", i--
		gosub, SetColor
	}
	; 背景色
	bg:=i>0 ? "0":"_"
return

灰度二值化:
	GuiControl, Focus, fazhi
	GuiControlGet, fazhi
	if fazhi=
	{
		; 统计灰度直方图
		loop, 256
			pp[A_Index-1]:=0
		loop, % nH*nW
			if (cc[A_Index]!="")
				pp[gg[A_Index]]++
			; 迭代法求二值化阈值
		IP:=IS:=0
		loop, 256
			k:=A_Index-1, IP+=k*pp[k], IS+=pp[k]
		Newfazhi:=Floor(IP/IS)
		loop, 20 {
			fazhi:=Newfazhi
			IP1:=IS1:=0
			loop, % fazhi+1
				k:=A_Index-1, IP1+=k*pp[k], IS1+=pp[k]
			IP2:=IP-IP1, IS2:=IS-IS1
			if (IS1!=0 and IS2!=0)
				Newfazhi:=Floor((IP1/IS1+IP2/IS2)/2)
			if (Newfazhi=fazhi)
				break
		}
		GuiControl,, fazhi, %fazhi%
	}
	color:="*" fazhi, k:=i:=0
	loop, % nH*nW {
		if (cc[++k]="")
			continue
		if (gg[k]<fazhi+1)
			cc[k]:="0", c:="Black", i++
		else
			cc[k]:="_", c:="White", i--
		gosub, SetColor
	}
	; 背景色
	bg:=i>0 ? "0":"_"
return

灰差二值化:
	GuiControlGet, huicha
	if huicha=
	{
		MsgBox, 4096,, `n  请先设置边缘灰度差（比如50）！  `n, 1
		return
	}
	huicha:=Round(huicha)
	if (left=cors.left)
		gosub, 左删
	if (Right=cors.Right)
		gosub, 右删
	if (up=cors.up)
		gosub, 上删
	if (down=cors.down)
		gosub, 下删
	color:="**" huicha, k:=i:=0
	loop, % nH*nW {
		if (cc[++k]="")
			continue
		c:=gg[k]+huicha
		if (gg[k-1]>c or gg[k+1]>c or gg[k-nW]>c or gg[k+nW]>c)
			cc[k]:="0", c:="Black", i++
		else
			cc[k]:="_", c:="White", i--
		gosub, SetColor
	}
	; 背景色
	bg:=i>0 ? "0":"_"
return

gui_del:
	cc[k]:="", c:=WindowColor
	gosub, SetColor
return

左3:
	loop, 3
		gosub, 左删
return

左删:
	if (left+Right>=nW)
		return
	left++, k:=left
	loop, %nH% {
		gosub, gui_del
		k+=nW
	}
return

右3:
	loop, 3
		gosub, 右删
return

右删:
	if (left+Right>=nW)
		return
	Right++, k:=nW+1-Right
	loop, %nH% {
		gosub, gui_del
		k+=nW
	}
return

上3:
	loop, 3
		gosub, 上删
return

上删:
	if (up+down>=nH)
		return
	up++, k:=(up-1)*nW
	loop, %nW% {
		k++
		gosub, gui_del
	}
return

下3:
	loop, 3
		gosub, 下删
return

下删:
	if (up+down>=nH)
		return
	down++, k:=(nH-down)*nW
	loop, %nW% {
		k++
		gosub, gui_del
	}
return

getwz:
	wz=
	if bg=
		return
	ListLines, Off
	k:=0
	loop, %nH% {
		v=
		loop, %nW%
			v.=cc[++k]
		wz.=v="" ? "" : v "`n"
	}
	ListLines, On
return

智删:
	gosub, getwz
	if wz=
	{
		MsgBox, 4096, 提示, `n请先进行一种二值化！, 1
		return
	}
	while InStr(wz,bg) {
		if (wz~="^" bg "+\n")
		{
			wz:=RegExReplace(wz,"^" bg "+\n")
			gosub, 上删
		}
		else if !(wz~="m`n)[^\n" bg "]$")
		{
			wz:=RegExReplace(wz,"m`n)" bg "$")
			gosub, 右删
		}
		else if (wz~="\n" bg "+\n$")
		{
			wz:=RegExReplace(wz,"\n\K" bg "+\n$")
			gosub, 下删
		}
		else if !(wz~="m`n)^[^\n" bg "]")
		{
			wz:=RegExReplace(wz,"m`n)^" bg)
			gosub, 左删
		}
		else break
		}
	wz=
return

确定:
分割添加:
整体添加:
	gosub, getwz
	if wz=
	{
		MsgBox, 4096, 提示, `n请先进行一种二值化！, 1
		return
	}
	Gui, Hide
	GuiControlGet, ziku
	ziku:=Trim(ziku)
	IfInString, A_ThisLabel, 分割
	{
		; 正则表达式中数字需要十进制
		SetFormat, IntegerFast, d
		s:="", bg:=StrLen(StrReplace(wz,"_"))
		loop {
			while InStr(wz,bg) and !(wz~="m`n)^[^\n" bg "]")
				wz:=RegExReplace(wz,"m`n)^.")
			loop, % InStr(wz,"`n")-1 {
				i:=A_Index
				if !(wz~="m`n)^.{" i "}[^\n" bg "]")
				{
					; 自动分割会裁边，小数点等的字库要手动制作
					v:=RegExReplace(wz,"m`n)^(.{" i "}).*","$1")
					v:=RegExReplace(v,"^(" bg "+\n)+")
					v:=RegExReplace(v,"\n\K(" bg "+\n)+$")
					s.=towz(SubStr(ziku,1,1),v)
					ziku:=SubStr(ziku,2)
					wz:=RegExReplace(wz,"m`n)^.{" i "}")
					continue, 2
				}
			}
			break
		}
		add(s)
		return
	}
	IfInString, A_ThisLabel, 整体
	{
		add(towz(ziku,wz))
		return
	}
	; 生成代码中的坐标为裁剪后整体文字的中心位置
	px1:=px-ww+left+(nW-left-Right)//2
	py1:=py-hh+up+(nH-up-down)//2
	s:= StrReplace(towz(ziku,wz),"文字.=","文字:=")
	. "`nif 查找文字(" px1 "," py1 ",150000,150000,文字,"""
	. color . """,X,Y,OCR,0,0)`n"
	. "{`n  CoordMode, Mouse`n  MouseMove, X, Y`n}`n"
	GuiControl, Main:, scr, %s%
	s:=wz:=""
return

towz(ziku,wz) {
	SetFormat, IntegerFast, d
	wz:=StrReplace(StrReplace(wz,"0","1"),"_","0")
	wz:=InStr(wz,"`n")-1 . "." . bit2base64(wz)
	return, "`n文字.=""|<" ziku ">" wz """`n"
}

add(s) {
	global hscr
	s:=RegExReplace("`n" s "`n","\R","`r`n")
	ControlGet, i, CurrentCol,,, ahk_id %hscr%
	if i>1
		ControlSend,, {Home}{Down}, ahk_id %hscr%
	Control, EditPaste, %s%,, ahk_id %hscr%
}


;---- 将后面的函数附加到自己的脚本中 ----


;-----------------------------------------
; 查找屏幕文字/图像字库及OCR识别
; 注意：参数中的x、y为中心点坐标，w、h为左右上下偏移
; cha1、cha0分别为0、_字符的容许误差百分比
;-----------------------------------------
查找文字(x,y,w,h,wz,c,ByRef rx="",ByRef ry="",ByRef ocr=""
	, cha1=0, cha0=0)
{
	xywh2xywh(x-w,y-h,2*w+1,2*h+1,x,y,w,h)
	if (w<1 or h<1)
		return, 0
	bch:=A_BatchLines
	SetBatchLines, -1
	;--------------------------------------
	GetBitsFromScreen(x,y,w,h,Scan0,Stride,bits)
	;--------------------------------------
	; 设定图内查找范围，注意不要越界
	sx:=0, sy:=0, sw:=w, sh:=h
	loop, 2 {
		if PicOCR(Scan0,Stride,sx,sy,sw,sh,wz,c
			,rx,ry,ocr,cha1,cha0)
		{
			rx+=x, ry+=y
			SetBatchLines, %bch%
			return, 1
		}
		; 容差为0的若失败则使用 5% 的容差再找一次
		if (A_Index=1 and cha1=0 and cha0=0)
			cha1:=0.05, cha0:=0.05
		else break
	}
	SetBatchLines, %bch%
	return, 0
}

;-- 规范输入范围在屏幕范围内
xywh2xywh(x1,y1,w1,h1,ByRef x,ByRef y,ByRef w,ByRef h)
{
	; 获取包含所有显示器的虚拟屏幕范围
	SysGet, zx, 76
	SysGet, zy, 77
	SysGet, zw, 78
	SysGet, zh, 79
	left:=x1, Right:=x1+w1-1, up:=y1, down:=y1+h1-1
	left:=left<zx ? zx:left, Right:=Right>zx+zw-1 ? zx+zw-1:Right
	up:=up<zy ? zy:up, down:=down>zy+zh-1 ? zy+zh-1:down
	x:=left, y:=up, w:=Right-left+1, h:=down-up+1
}

;-- 获取屏幕图像的内存数据，图像包括透明窗口
GetBitsFromScreen(x,y,w,h,ByRef Scan0,ByRef Stride,ByRef bits)
{
	VarSetCapacity(bits,w*h*4,0), bpp:=32
	Scan0:=&bits, Stride:=((w*bpp+31)//32)*4
	Ptr:=A_PtrSize ? "UPtr" : "UInt", PtrP:=Ptr . "*"
	; 桌面窗口对应包含所有显示器的虚拟屏幕
	win:=DllCall("GetDesktopWindow", Ptr)
	hDC:=DllCall("GetWindowDC", Ptr,win, Ptr)
	mDC:=DllCall("CreateCompatibleDC", Ptr,hDC, Ptr)
	;-------------------------
	VarSetCapacity(bi, 40, 0), NumPut(40, bi, 0, "int")
	NumPut(w, bi, 4, "int"), NumPut(-h, bi, 8, "int")
	NumPut(1, bi, 12, "short"), NumPut(bpp, bi, 14, "short")
	;-------------------------
	if hBM:=DllCall("CreateDIBSection", Ptr,mDC, Ptr,&bi
		, "int",0, PtrP,ppvBits, Ptr,0, "int",0, Ptr)
	{
		oBM:=DllCall("SelectObject", Ptr,mDC, Ptr,hBM, Ptr)
		DllCall("BitBlt", Ptr,mDC, "int",0, "int",0, "int",w, "int",h
			, Ptr,hDC, "int",x, "int",y, "uint",0x00CC0020|0x40000000)
		DllCall("RtlMoveMemory","ptr",Scan0,"ptr",ppvBits,"ptr",Stride*h)
		DllCall("SelectObject", Ptr,mDC, Ptr,oBM)
	}
	DllCall("DeleteObject", Ptr,hBM)
	DllCall("DeleteDC", Ptr,mDC)
	DllCall("ReleaseDC", Ptr,win, Ptr,hDC)
}

;-----------------------------------------
; 图像内查找文字/图像字符串及OCR函数
;-----------------------------------------
PicOCR(Scan0, Stride, sx, sy, sw, sh, wenzi, c
	, ByRef rx, ByRef ry, ByRef ocr, cha1, cha0)
{
	static MyFunc
	if !MyFunc
	{
		x32:="5589E55383C4808B452C0FAF45248B5528C1E20201D0894"
		. "5F08B5530B80000000029D0C1E00289C28B452401D08945ECC"
		. "745E800000000C745D800000000C745D4000000008B4530894"
		. "5D08B45348945CCC745C800000000837D08000F854D0100008"
		. "B450CC1E81025FF0000008945C48B450CC1E80825FF0000008"
		. "945C08B450C25FF0000008945BC8B4510C1E81025FF0000008"
		. "945B88B4510C1E80825FF0000008945B48B451025FF0000008"
		. "945B08B45C42B45B88945AC8B45C02B45B48945A88B45BC2B4"
		. "5B08945A48B55C48B45B801D08945A08B55C08B45B401D0894"
		. "59C8B55BC8B45B001D0894598C745F400000000E9A6000000C"
		. "745F800000000E9840000008B45F083C00289C28B452001D00"
		. "FB6000FB6C08945C48B45F083C00189C28B452001D00FB6000"
		. "FB6C08945C08B55F08B452001D00FB6000FB6C08945BC8B45C"
		. "43B45AC7C338B45C43B45A07F2B8B45C03B45A87C238B45C03"
		. "B459C7F1B8B45BC3B45A47C138B45BC3B45987F0B8B55E88B4"
		. "53C01D0C600318345F8018345F0048345E8018B45F83B45300"
		. "F8C70FFFFFF8345F4018B45EC0145F08B45F43B45340F8C4EF"
		. "FFFFFE917020000837D08010F85A30000008B450C83C001C1E"
		. "00789450CC745F400000000EB7DC745F800000000EB628B45F"
		. "083C00289C28B452001D00FB6000FB6C06BD0268B45F083C00"
		. "189C18B452001C80FB6000FB6C06BC04B8D0C028B55F08B452"
		. "001D00FB6000FB6D089D0C1E00429D001C83B450C730B8B55E"
		. "88B453C01D0C600318345F8018345F0048345E8018B45F83B4"
		. "5307C968345F4018B45EC0145F08B45F43B45340F8C77FFFFF"
		. "FE96A010000C745F400000000EB7BC745F800000000EB608B5"
		. "5E88B45388D0C028B45F083C00289C28B452001D00FB6000FB"
		. "6C06BD0268B45F083C00189C38B452001D80FB6000FB6C06BC"
		. "04B8D1C028B55F08B452001D00FB6000FB6D089D0C1E00429D"
		. "001D8C1F80788018345F8018345F0048345E8018B45F83B453"
		. "07C988345F4018B45EC0145F08B45F43B45340F8C79FFFFFF8"
		. "B453083E8018945948B453483E801894590C745F401000000E"
		. "9B0000000C745F801000000E9940000008B45F40FAF453089C"
		. "28B45F801D08945E88B55E88B453801D00FB6000FB6D08B450"
		. "C01D08945EC8B45E88D50FF8B453801D00FB6000FB6C03B45E"
		. "C7F488B45E88D50018B453801D00FB6000FB6C03B45EC7F328"
		. "B45E82B453089C28B453801D00FB6000FB6C03B45EC7F1A8B5"
		. "5E88B453001D089C28B453801D00FB6000FB6C03B45EC7E0B8"
		. "B55E88B453C01D0C600318345F8018B45F83B45940F8C60FFF"
		. "FFF8345F4018B45F43B45900F8C44FFFFFF8B45D40FAF45308"
		. "9C28B45D801D089458CC745F800000000E912030000C745F40"
		. "0000000E9F60200008B45F40FAF453089C28B45F801C28B458"
		. "C01D08945F0C745E800000000E9C40200008B45E883C0018D1"
		. "485000000008B454801D08B008945948B45E883C0028D14850"
		. "00000008B454801D08B008945908B55F88B459401D03B45D00"
		. "F8F800200008B55F48B459001D03B45CC0F8F6F0200008B45E"
		. "88D1485000000008B454801D08B008945888B45E883C0038D1"
		. "485000000008B454801D08B008945848B45E883C0048D14850"
		. "00000008B454801D08B008945808B45E883C0058D148500000"
		. "0008B454801D08B008945E48B45E883C0068D1485000000008"
		. "B454801D08B008945E08B45843945800F4D458089857CFFFFF"
		. "FC745EC00000000E9820000008B45EC3B45847D378B55888B4"
		. "5EC01D08D1485000000008B454001D08B108B45F001D089C28"
		. "B453C01D00FB6003C31740E836DE401837DE4000F889E01000"
		. "08B45EC3B45807D378B55888B45EC01D08D1485000000008B4"
		. "54401D08B108B45F001D089C28B453C01D00FB6003C30740E8"
		. "36DE001837DE0000F88620100008345EC018B45EC3B857CFFF"
		. "FFF0F8C6FFFFFFF837DC8000F858A0000008B55288B45F801C"
		. "28B454C89108B454C83C0048B4D2C8B55F401CA89108B454C8"
		. "D50088B459489028B454C8D500C8B45908902C745C80400000"
		. "0837D180175728B45F42B45908945D48B559089D001C001D08"
		. "945CC8B559089D0C1E00201D001C083C0648945D0837DD4007"
		. "907C745D4000000008B45342B45D43B45CC7D338B45342B45D"
		. "48945CCEB288B55DC8B451401D03B45F87F1B8B45C88D50018"
		. "955C88D1485000000008B454C01D0C700FFFFFFFF8B45C88D5"
		. "0018955C88D1485000000008B454C01D08B55E883C20789108"
		. "17DC8FD0300000F8FAA000000C745EC00000000EB298B55888"
		. "B45EC01D08D1485000000008B454001D08B108B45F001D089C"
		. "28B453C01D0C600308345EC018B45EC3B45847CCF8B45F883C"
		. "0010145D88B45948945DC8B45302B45D83B45D00F8D0AFDFFF"
		. "F8B45302B45D88945D0E9FCFCFFFF90EB0490EB01908345E80"
		. "78B45E83B451C0F8C30FDFFFF8345F4018B45F43B45CC0F8CF"
		. "EFCFFFF8345F8018B45F83B45D00F8CE2FCFFFF837DC800750"
		. "8B800000000EB0690B80100000083EC805B5DC24800"
		x64:="554889E54883C480894D108955184489452044894D288B4"
		. "5580FAF45488B5550C1E20201D08945F48B5560B8000000002"
		. "9D0C1E00289C28B454801D08945F0C745EC00000000C745DC0"
		. "0000000C745D8000000008B45608945D48B45688945D0C745C"
		. "C00000000837D10000F855D0100008B4518C1E81025FF00000"
		. "08945C88B4518C1E80825FF0000008945C48B451825FF00000"
		. "08945C08B4520C1E81025FF0000008945BC8B4520C1E80825F"
		. "F0000008945B88B452025FF0000008945B48B45C82B45BC894"
		. "5B08B45C42B45B88945AC8B45C02B45B48945A88B55C88B45B"
		. "C01D08945A48B55C48B45B801D08945A08B55C08B45B401D08"
		. "9459CC745F800000000E9B6000000C745FC00000000E994000"
		. "0008B45F483C0024863D0488B45404801D00FB6000FB6C0894"
		. "5C88B45F483C0014863D0488B45404801D00FB6000FB6C0894"
		. "5C48B45F44863D0488B45404801D00FB6000FB6C08945C08B4"
		. "5C83B45B07C388B45C83B45A47F308B45C43B45AC7C288B45C"
		. "43B45A07F208B45C03B45A87C188B45C03B459C7F108B45EC4"
		. "863D0488B45784801D0C600318345FC018345F4048345EC018"
		. "B45FC3B45600F8C60FFFFFF8345F8018B45F00145F48B45F83"
		. "B45680F8C3EFFFFFFE959020000837D10010F85B60000008B4"
		. "51883C001C1E007894518C745F800000000E98D000000C745F"
		. "C00000000EB728B45F483C0024863D0488B45404801D00FB60"
		. "00FB6C06BD0268B45F483C0014863C8488B45404801C80FB60"
		. "00FB6C06BC04B8D0C028B45F44863D0488B45404801D00FB60"
		. "00FB6D089D0C1E00429D001C83B451873108B45EC4863D0488"
		. "B45784801D0C600318345FC018345F4048345EC018B45FC3B4"
		. "5607C868345F8018B45F00145F48B45F83B45680F8C67FFFFF"
		. "FE999010000C745F800000000E98D000000C745FC00000000E"
		. "B728B45EC4863D0488B4570488D0C028B45F483C0024863D04"
		. "88B45404801D00FB6000FB6C06BD0268B45F483C0014C63C04"
		. "88B45404C01C00FB6000FB6C06BC04B448D04028B45F44863D"
		. "0488B45404801D00FB6000FB6D089D0C1E00429D04401C0C1F"
		. "80788018345FC018345F4048345EC018B45FC3B45607C86834"
		. "5F8018B45F00145F48B45F83B45680F8C67FFFFFF8B456083E"
		. "8018945988B456883E801894594C745F801000000E9CA00000"
		. "0C745FC01000000E9AE0000008B45F80FAF456089C28B45FC0"
		. "1D08945EC8B45EC4863D0488B45704801D00FB6000FB6D08B4"
		. "51801D08945F08B45EC4898488D50FF488B45704801D00FB60"
		. "00FB6C03B45F07F538B45EC4898488D5001488B45704801D00"
		. "FB6000FB6C03B45F07F388B45EC2B45604863D0488B4570480"
		. "1D00FB6000FB6C03B45F07F1D8B55EC8B456001D04863D0488"
		. "B45704801D00FB6000FB6C03B45F07E108B45EC4863D0488B4"
		. "5784801D0C600318345FC018B45FC3B45980F8C46FFFFFF834"
		. "5F8018B45F83B45940F8C2AFFFFFF8B45D80FAF456089C28B4"
		. "5DC01D0894590C745FC00000000E98E030000C745F80000000"
		. "0E9720300008B45F80FAF456089C28B45FC01C28B459001D08"
		. "945F4C745EC00000000E9400300008B45EC48984883C001488"
		. "D148500000000488B85900000004801D08B008945988B45EC4"
		. "8984883C002488D148500000000488B85900000004801D08B0"
		. "08945948B55FC8B459801D03B45D40F8FEA0200008B55F88B4"
		. "59401D03B45D00F8FD90200008B45EC4898488D14850000000"
		. "0488B85900000004801D08B0089458C8B45EC48984883C0034"
		. "88D148500000000488B85900000004801D08B008945888B45E"
		. "C48984883C004488D148500000000488B85900000004801D08"
		. "B008945848B45EC48984883C005488D148500000000488B859"
		. "00000004801D08B008945E88B45EC48984883C006488D14850"
		. "0000000488B85900000004801D08B008945E48B45883945840"
		. "F4D4584894580C745F000000000E9980000008B45F03B45887"
		. "D428B558C8B45F001D04898488D148500000000488B8580000"
		. "0004801D08B108B45F401D04863D0488B45784801D00FB6003"
		. "C31740E836DE801837DE8000F88D40100008B45F03B45847D4"
		. "28B558C8B45F001D04898488D148500000000488B858800000"
		. "04801D08B108B45F401D04863D0488B45784801D00FB6003C3"
		. "0740E836DE401837DE4000F888D0100008345F0018B45F03B4"
		. "5800F8C5CFFFFFF837DCC000F859D0000008B55508B45FC01C"
		. "2488B85980000008910488B85980000004883C0048B4D588B5"
		. "5F801CA8910488B8598000000488D50088B45988902488B859"
		. "8000000488D500C8B45948902C745CC04000000837D3001757"
		. "A8B45F82B45948945D88B559489D001C001D08945D08B55948"
		. "9D0C1E00201D001C083C0648945D4837DD8007907C745D8000"
		. "000008B45682B45D83B45D07D3B8B45682B45D88945D0EB308"
		. "B55E08B452801D03B45FC7F238B45CC8D50018955CC4898488"
		. "D148500000000488B85980000004801D0C700FFFFFFFF8B45C"
		. "C8D50018955CC4898488D148500000000488B8598000000480"
		. "1D08B55EC83C2078910817DCCFD0300000F8FB5000000C745F"
		. "000000000EB348B558C8B45F001D04898488D1485000000004"
		. "88B85800000004801D08B108B45F401D04863D0488B4578480"
		. "1D0C600308345F0018B45F03B45887CC48B45FC83C0010145D"
		. "C8B45988945E08B45602B45DC3B45D40F8D8EFCFFFF8B45602"
		. "B45DC8945D4E980FCFFFF90EB0490EB01908345EC078B45EC3"
		. "B45380F8CB4FCFFFF8345F8018B45F83B45D00F8C82FCFFFF8"
		. "345FC018B45FC3B45D40F8C66FCFFFF837DCC007508B800000"
		. "000EB0690B8010000004883EC805DC3909090909090909090"
		MCode(MyFunc, A_PtrSize=8 ? x64:x32)
	}
	;--------------------------------------
	; 统计字库文字的个数和宽高，将解释文字存入数组并删除<>
	;--------------------------------------
	ocrtxt:=[], info:=[], t1:=[], t0:=[], p:=0
	loop, Parse, wenzi, |
	{
		v:=A_LoopField, txt:="", e1:=cha1, e0:=cha0
		; 用角括号输入每个字库字符串的识别结果文字
		if RegExMatch(v,"<([^>]*)>",r)
			v:=StrReplace(v,r), txt:=Trim(r1)
		; 可以用中括号输入每个文字的两个容差，以逗号分隔
		if RegExMatch(v,"\[([^\]]*)]",r)
		{
			v:=StrReplace(v,r), r2:=""
			StringSplit, r, r1, `,
			e1:=r1, e0:=r2
		}
		; 记录每个文字的起始位置、宽、高、01字符的数量和容差
		StringSplit, r, v, .
		w:=r1, v:=base64tobit(r2), h:=StrLen(v)//w
		if (r0<2 or h<1 or w>sw or h>sh or StrLen(v)!=w*h)
			continue
		len1:=len0:=0, j:=sw-w+1, i:=-j
		ListLines, Off
		loop, Parse, v
		{
			i:=Mod(A_Index,w)=1 ? i+j : i+1
			if A_LoopField
				t1[4*(p+len1++)]:=i
			else
				t0[4*(p+len0++)]:=i
		}
		ListLines, On
		e1:=Round(len1*e1), e0:=Round(len0*e0)
		info.Push(p,w,h,len1,len0,e1,e0)
		ocrtxt.Push(txt), p+=StrLen(v)
	}
	IfEqual, p, 0, return, 0
	;--------------------------------------
	; in 输入各文字的起始位置等信息，out 返回结果
	; interval 两字的间隔超过此值，识别结果就加入*号
	; limit 根据第一个字限制后续查找高度和右范围
	;--------------------------------------
	mode:=InStr(c,"**") ? 2 : InStr(c,"*") ? 1 : 0
	c:=StrReplace(c,"*"), interval:=5, limit:=1
	if mode=0
	{
		c:=StrReplace(c,"0x") . "-0"
		StringSplit, r, c, -
		c:=Round("0x" r1), dc:=Round("0x" r2)
	}
	num:=info.MaxIndex()
		, VarSetCapacity(gs, sw*sh)
		, VarSetCapacity(ss, sw*sh, Asc("0"))
		, VarSetCapacity(s1, p*4, 0)
		, VarSetCapacity(s0, p*4, 0)
		, VarSetCapacity(in, num*4)
		, VarSetCapacity(out, 1024*4, 0)
	ListLines, Off
	loop, % num
		NumPut(info[A_Index], in, (A_Index-1)*4, "int")
	For k,v in t1
		NumPut(v, s1, k, "int")
	For k,v in t0
		NumPut(v, s0, k, "int")
	ListLines, On
	if DllCall(&MyFunc, "int",mode
		, "uint",c, "uint",dc
		, "int",interval, "int",limit, "int",num
		, "ptr",Scan0, "int",Stride
		, "int",sx, "int",sy, "int",sw, "int",sh
		, "ptr",&gs, "ptr",&ss
		, "ptr",&s1, "ptr",&s0, "ptr",&in, "ptr",&out)
	{
		; 返回第一个文字的中心位置
		x:=NumGet(out,0,"int"), y:=NumGet(out,4,"int")
		w:=NumGet(out,8,"int"), h:=NumGet(out,12,"int")
		rx:=x+w//2, ry:=y+h//2, ocr:="", i:=12
		while (k:=NumGet(out,i+=4,"int"))
			v:=ocrtxt[k//7], ocr.=v="" ? "*" : v
		return, 1
	}
	return, 0
}

MCode(ByRef code, hex)
{
	ListLines, Off
	bch:=A_BatchLines
	SetBatchLines, -1
	VarSetCapacity(code, StrLen(hex)//2)
	loop, % StrLen(hex)//2
		NumPut("0x" . SubStr(hex,2*A_Index-1,2), code, A_Index-1, "char")
	Ptr:=A_PtrSize ? "UPtr" : "UInt"
	DllCall("VirtualProtect", Ptr,&code, Ptr
		,VarSetCapacity(code), "uint",0x40, Ptr . "*",0)
	SetBatchLines, %bch%
	ListLines, On
}

base64tobit(s)
{
	ListLines, Off
	Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	. "abcdefghijklmnopqrstuvwxyz"
	SetFormat, IntegerFast, d
	StringCaseSense, On
	loop, Parse, Chars
	{
		i:=A_Index-1, v:=(i>>5&1) . (i>>4&1)
		. (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
		s:=StrReplace(s,A_LoopField,v)
	}
	StringCaseSense, Off
	s:=SubStr(s,1,InStr(s,"1",0,0)-1)
	s:=RegExReplace(s,"[^01]+")
	ListLines, On
	return, s
}

bit2base64(s)
{
	ListLines, Off
	s:=RegExReplace(s,"[^01]+")
	s.=SubStr("100000",1,6-Mod(StrLen(s),6))
	s:=RegExReplace(s,".{6}","|$0")
	Chars:="0123456789+/ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	. "abcdefghijklmnopqrstuvwxyz"
	SetFormat, IntegerFast, d
	loop, Parse, Chars
	{
		i:=A_Index-1, v:="|" . (i>>5&1) . (i>>4&1)
		. (i>>3&1) . (i>>2&1) . (i>>1&1) . (i&1)
		s:=StrReplace(s,v,A_LoopField)
	}
	ListLines, On
	return, s
}


/************  机器码的C源码 ************

int __attribute__((__stdcall__)) OCR( int mode
, unsigned int c, unsigned int dc
, int interval, int limit, int num
, unsigned char * Bmp, int Stride
, int sx, int sy, int sw, int sh
, unsigned char * gs, char * ss
, int * s1, int * s0, int * in, int * out )
{
int x, y, o=sy*Stride+sx*4, j=Stride-4*sw, i=0;
int o1, o2, w, h, max, len1, len0, e1, e0, lastw;
int sx1=0, sy1=0, sw1=sw, sh1=sh, Ptr=0;

//先将图像各点在ss中转化为01字符
if (mode==0)    //颜色模式
{
int R=(c>>16)&0xFF, G=(c>>8)&0xFF, B=c&0xFF;
int dR=(dc>>16)&0xFF, dG=(dc>>8)&0xFF, dB=dc&0xFF;
int R1=R-dR, G1=G-dG, B1=B-dB;
int R2=R+dR, G2=G+dG, B2=B+dB;
for (y=0; y<sh; y++, o+=j)
for (x=0; x<sw; x++, o+=4, i++)
{
R=Bmp[2+o]; G=Bmp[1+o]; B=Bmp[o];
if (R>=R1 && R<=R2 && G>=G1 && G<=G2 && B>=B1 && B<=B2)
ss[i]='1';
}
}
else if (mode==1)    //灰度阀值模式
{
c=(c+1)*128;
for (y=0; y<sh; y++, o+=j)
for (x=0; x<sw; x++, o+=4, i++)
if (Bmp[2+o]*38+Bmp[1+o]*75+Bmp[o]*15<c)
ss[i]='1';
}
else    //mode==2，边缘灰差模式
{
for (y=0; y<sh; y++, o+=j)
{
for (x=0; x<sw; x++, o+=4, i++)
gs[i]=(Bmp[2+o]*38+Bmp[1+o]*75+Bmp[o]*15)>>7;
}
w=sw-1; h=sh-1;
for (y=1; y<h; y++)
{
for (x=1; x<w; x++)
{
i=y*sw+x; j=gs[i]+c;
if (gs[i-1]>j || gs[i+1]>j || gs[i-sw]>j || gs[i+sw]>j)
ss[i]='1';
}
}
}

//ss中每一点都进行一次全字库匹配
NextWenzi:
o1=sy1*sw+sx1;
for (x=0; x<sw1; x++)
{
for (y=0; y<sh1; y++)
{
o=y*sw+x+o1;
for (i=0; i<num; i+=7)
{
w=in[i+1]; h=in[i+2];
if (x+w>sw1 || y+h>sh1)
continue;
o2=in[i]; len1=in[i+3]; len0=in[i+4];
e1=in[i+5]; e0=in[i+6];
max=len1>len0 ? len1 : len0;
for (j=0; j<max; j++)
{
if (j<len1 && ss[o+s1[o2+j]]!='1' && (--e1)<0)
goto NoMatch;
if (j<len0 && ss[o+s0[o2+j]]!='0' && (--e0)<0)
goto NoMatch;
}
//成功找到文字或图像
if (Ptr==0)
{
out[0]=sx+x; out[1]=sy+y; out[2]=w; out[3]=h; Ptr=4;
//找到第一个字就确定后续查找的上下范围和右边范围
if (limit==1)
{
sy1=y-h; sh1=h*3; sw1=h*10+100;
if (sy1<0)
sy1=0;
if (sh1>sh-sy1)
sh1=sh-sy1;
}
}  //与前一字间隔较远就添加*号
else if (x>=lastw + interval)
out[Ptr++]=-1;
out[Ptr++]=i+7;
//返回的int数组中元素个数不超过1024
if (Ptr>1021)
goto returnOK;
//清除找到的文字，后续查找范围从文字左侧X坐标+1开始
for (j=0; j<len1; j++)
ss[o+s1[o2+j]]='0';
sx1+=x+1; lastw=w;
if (sw1>sw-sx1)
sw1=sw-sx1;
goto NextWenzi;
//------------
NoMatch:
continue;
}
}
}
if (Ptr==0)
return 0;
returnOK:
return 1;
}

*/


;============ 脚本结束 =================

;


return

if 查找文字(663,401,150000,150000,文字,"*222",X,Y,OCR,0,0)
{

  CoordMode, Mouse
  MouseMove, X, Y
  Send {LButton}
}


return

;#R::
Run *RunAs %A_ScriptFullPath%
return