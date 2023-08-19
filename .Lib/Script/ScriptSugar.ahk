ToolTip(text:="",x:="",y:="",number:=1){
	ToolTip,% text,% X,% Y,% number
}
TrayTip(title:="",text:="",s:="",option:=0){
	TrayTip,% title,% text,% s,% option
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
