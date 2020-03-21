Class InIReader{
	__New(path,name:=""){
		this.path:=path,this.name:=name,this.ini:=InIReader(path)
	}
	_NewEnum(){
		return this.ini._NewEnum()
	}
	__Get(params*){
		o:=this.ini
		for k,v in params
			o:=o[v]
		return o
	}
}
InIReader(path){
	ini:={}
	for k,v in StrSplit(IniRead(path),"`n"){
		ini[v]:=section:={}
		for k,v in StrSplit(IniRead(path,v),"`n"){
			section[SubStr(v,1,i:=InStr(v,"=")-1)]:=SubStr(v,i+2)
		}
	}
	return ini
}