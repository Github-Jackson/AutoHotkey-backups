ToolTip(text:="",x:="",y:="",number:=1){
	ToolTip,% text,% X,% Y,% number
}
TrayTip(title:="",text:="",s:="",option:=0){
	TrayTip,% title,% text,% s,% option
}
SetTimer(fn:="",option:="",priority:=0){
	if(fn=="")
		SetTimer,,% option,% priority
	else
		SetTimer,% fn,% option,% priority
}
MsgBox(text*){
	if(!text.Length())
		MsgBox
	else{
		for k,v in text
			e.=v
		MsgBox % e
	}
}
