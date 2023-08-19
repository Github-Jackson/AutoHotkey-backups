
#SingleInstance Force
CoordMode,Mouse,Client
SetDefaultMouseSpeed,2

global contin:=true

Once(y){
	ChangeLine(y)
	Sleep 1400
	Gather()
	Gather()
}
;一个周期
Period(){
	x:=0
	while (x<8)
	{
		x++
		ShowLine()
		Once((x*75)+10)
	}
}
;加强周期
Reinforce(){
	x:=0
	while (x<8)
	{
		x++
		ShowLine()
		MouseMove,930,680
		Click,Down
		MouseMove,930,80,10
		Click,Up
		Sleep,400
		Once((x*75)+10)
	}
}
;830 380 换锄头坐标
;采集
Gather(){
	Click,970,480
	Click,830,380
	Sleep,6600
}
;展开line
ShowLine(){
	Click,1130,14
	Sleep,300	
}
;换线
ChangeLine(y){
	Click,930,%y%
}

Begin(){
	Period()
	Reinforce()
}

^#R::
	contin:=true
	while contin
	{
		Begin()
		if(!contin) 
			return
	}
return
#T::
	ShowLine()
	MouseMove,930,680
	Click,Down
	MouseMove,930,80,10
	Click,Up
	Sleep,500
return

#P::Pause
#R::Reload
