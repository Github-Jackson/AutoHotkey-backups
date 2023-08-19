AutoFill(){
	AutoFill_Initial()
}
AutoFill_Initial(){
	AutoFill_HotKey()
	FillState("off")
}

execute(){
	endkey:="{Tab}{Space}"
	FillState("on")
	input,out,c v,%endKey%
	FillState("off")
	endkey:=StrSplit(SubStr(ErrorLevel,InStr(ErrorLevel,"EndKey:")),":")
	endkey:=endkey[2]
	content:=GetBox(out)
	if(content!=""){
		len:=StrLen(out)+1
		send,{Backspace %len%} 
	}
	if(IsObject(content)){
		sendInput % content.account
		if(endkey=="Tab"){
			send {Tab}
			sendRaw % content.password
		}
	}else{
		sendRaw % content
	}
}

AutoFill_HotKey(){
	HotKey,tab,NullFun
	HotKey,space,NullFun
	HotKey,~@,execute
}
NullFun(){
	return
}

FillState(state){
	HotKey,tab,,%state%
	HotKey,space,,%state%
	;HotKey,enter,,%state%
}