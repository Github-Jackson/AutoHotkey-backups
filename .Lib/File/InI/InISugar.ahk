IniRead(fileName,section:="",params*){
	IniRead,out,% fileName,% section,% params[1],% params[2]
	return out
}
IniWrite(v,fileName,section,key:="="){
	if(IsObject(v)){
		for k,v in v
			pairs .= k "=" v "`n"
		IniWrite,% pairs,% fileName,% section
	}else if(key=="="){
		IniWrite,% v,% fileName,% section
	}else
		IniWrite,% v,% fileName,% section,% key
}
IniDelete(fileName,section:="",key:="="){
	if(key=="=")
		IniDelete,% fileName,% section
	else
		IniDelete,% fileName,% section,% key
}