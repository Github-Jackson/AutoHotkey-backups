$(e){
	return "ahk_class " e
}
#(e){
	if(InStr(e,"0x"))
		return "ahk_id " e
	return "ahk_pid " e
}
@(e){
	return "ahk_exe " e
}
WinTitle(e){
	return new WinTitle(e).title
}
DetectHiddenWindows(e:="On"){
	DetectHiddenWindows,% e
}
DetectHiddenText(e:="On"){
	DetectHiddenText,% e
}
WinActivate(p*){
	WinActivate,% p[1],% p[2],% p[3],% p[4]
	return -1
}
WinActivateBottom(p*){
	WinActivateBottom,% p[1],% p[2],% p[3],% p[4]
	return -1
}
WinShow(title:="A",p*){
	WinShow,% title,% p[1],% p[2],% p[3]
	return -1
}
WinHide(title:="A",p*){
	WinHide,% title,% p[1],% p[2],% p[3]
	return -1
}
WinWait(p*){
	WinWait,% p[1],% p[2],% p[3],% p[4],% p[5]
	return -1
}
WinWaitActive(p*){
	WinWaitActive,% p[1],% p[2],% p[3],% p[4],% p[5]
	return -1
}
WinWaitNotActive(title:="A",p*){
	WinWaitNotActive,% title,% p[1],% p[2],% p[3],% p[4]
	return -1
}
WinWaitClose(title:="A",p*){
	WinWaitClose,% title,% p[1],% p[2],% p[3],% p[4]
	return -1
}
WinClose(title:="A",p*){
	WinClose,% title,% p[1],% p[2],% p[3],% p[4]
	return -1
}
WinKill(title:="A",p*){
	WinKill,% title,% p[1],% p[2],% p[3]
	return -1
}

WinSet(cmd,v,p*){
	WinSet,% cmd,% v,% p[1],% p[2],% p[3],% p[4]
	return -1
}
WinSetTitle(newTitle,p*){
	WinSetTitle,% p[1],% p[2],% newTitle,% p[3],% p[4]
	return -1
}
WinGet(cmd:="ID",title:="A",p*){
	WinGet,out,% cmd,% title,% p[1],% p[2],% p[3]
	if(InStr(cmd,"List")){
		arr:=[],index:=0
		loop {
			if(++index>out)
				return arr
			arr.Push(out%index%)
		}
	}
	return out
}
WinGetTitle(title:="A",p*){
	WinGetTitle,out,% title,% p[1],% p[2],% p[3]
	return out
}
WinGetClass(title:="A",p*){
	WinGetClass,out,% title,% p[1],% p[2],% p[3]
	return out
}
WinGetPos(title:="A",p*){
	WinGetPos,_X,_Y,_Width,_Height,% title,% p[1],% p[2],% p[3]
	return {X:_X,Y:_Y,Width:_Width,Height:_Height}
}
WinGetText(title:="A",p*){
	WinGetText,out,% title,% p[1],% p[2],% p[3]
	return out
}


WinMax(title:="A",p*){
	WinMaximize,% title,% p[1],% p[2],% p[3]
	return -1
}
WinMin(title:="A",p*){
	WinMinimize,% title,% p[1],% p[2],% p[3]
	return -1
}
WinRestore(title:="A",p*){
	WinRestore,% title,% p[1],% p[2],% p[3]
	return -1
}
WinMinAll(e:=""){
	if(e)
		WinMinimizeAll
	else
		WinMinimizeAllUndo
	return -1
}
WinMove(){
	MsgBox Undefined
	return -1
}