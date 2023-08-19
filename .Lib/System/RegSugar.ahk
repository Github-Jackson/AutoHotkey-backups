RegRead(key,value:=""){
	RegRead,out,% key,% value
	return out
}
RegWrite(type,key,value:="",content:=""){
	RegWrite,% type,% key,% value,% content
}
RegDelete(key,value:=""){
	RegDelete,% key,% value
}