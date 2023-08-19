GetStatus(e){
	local index:=0
	local operation:="|"
	local after:=SubStr(e,2)
	index:=SubStr(e,1,1)
	if(index=="("||index==")")
		return GetStatus(after)
	if(index=="&")
		return GetStatus(prev)&GetStatus(after)
	if(index=="|")
		return  GetStatus(prev)| GetStatus(after)
	
	if(index:=InStr(e,"(")){
		prev:=SubStr(e,1,index-2)
		after:=SubStr(e,index+1)
		operation:=SubStr(e,index-1,1)
	}else if(index:=InStr(e,")")){
		if(index==StrLen(e))
			return  GetStatus(SubStr(e,1,index-1))
		prev:=SubStr(e,1,index-1)
		after:=SubStr(e,index+1)
		return  GetStatus(after)
	}else if(index:=InStr(e,"|")){
		prev:=SubStr(e,1,index-1)
		after:=SubStr(e,index+1)
	}else{
		return  _GetState(e)
	}
	return operation!="|" ? ( GetStatus(prev)& GetStatus(after)):( GetStatus(prev)| GetStatus(after))

}
GetState(e){
	return GetKeyState(Trim(StrReplace(e,"@")),InStr(e,"@") ? "T":"P")
}
_GetState(e){
	result:=1
	for k,v in StrSplit(e,"&")
		result&= GetState(StrReplace(v,"_",,count))^(count&&1)
	return result
}