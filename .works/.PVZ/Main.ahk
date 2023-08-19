#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
CoordMode,Mouse,Client
SetDefaultMouseSpeed,0
;global $title:="植物大战僵尸中文版"
;global $title:="Plants vs."
global $card:={x:60,xBegin:90,width:50,y:40,height:70}
$再次尝试:={x:400,y:360}
global $main:={x:40,width:80,swidth:765+40,y:80,height:100,sheight:500}
global $rowNum:=0

$main(){
	;WinActive($title)
	;WinActivate,%$title%
	;WinMove,%$title%,,0,0
	
	fn:=Func("RowActive")
	Hotkey,if,% fn
	for k,v in StrSplit("123456789")
	{
		fn:=Func("PlantCard").Bind(k)
		Hotkey,^%v%,% fn
	}
	
	fn:=Func("TargetActive")
	;Hotkey,if,% fn
	for k,v in StrSplit("1234567890")
	{
		fn:=Func("SelectCard").Bind(k)
		Hotkey,!%v%, % fn
	}
	for k,v in StrSplit("12345")
	{
		fn:=Func("ControlRow").Bind(k)
		Hotkey,^%v%, % fn
	}

	Hotkey,if

}
$main()

SelectCard(num){
	x:=$card.x+num*$card.width
	y:=$card.y
	Click,%x%,%y%
}
ControlRow(num){
	$rowNum:=num
}
PlantCard(num){
	y:=$rowNum*$main.height
	x:=$main.swidth-num*$main.width
	Click,%x%,%y%
	$rowNum:=0
	Click,Right
}

TargetActive(){
	;WinActivate,%$title%
	;return WinActive($title)
}
RowActive(){
	;WinActivate,%$title%
	return $rowNum
}
;#If WinActive($title)
;Restart Esc-$再次尝试-Enter
R::
Send {Enter}{Esc}
Click,400,360
Send {Enter}
return
S::
Send {Enter}{Space}
return
P::
Send {Enter}{Enter}
return
;#If



return
#^R::Reload