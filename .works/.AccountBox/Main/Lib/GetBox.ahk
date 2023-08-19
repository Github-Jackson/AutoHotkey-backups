;提供字符键或者key数组,返回Object中key对应的内容
GetBox(keys,obj:=""){
	if(!IsObject(keys)){
		keys:=StrSplit(keys,".")
	}
	if(!obj){
		obj:= Box
	}
	for k,v in keys{
		obj:=obj[v ""]
	}
	return obj
}

GetBox_Fill(keys,obj:=""){
		if(!IsObject(keys)){
		keys:=StrSplit(keys,".")
	}
	if(!obj){
		obj:= Box
	}
	for k,v in keys{
		if(!IsObject(obj[v ""])){
			obj[v ""]:={}
		}
		obj:=obj[v ""]
	}
	return obj
}