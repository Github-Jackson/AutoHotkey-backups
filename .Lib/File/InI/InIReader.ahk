Class InIReader{
	__New(path,name:=""){
		if(name==""){
			arr:=StrSplit(path,"\")
			name:=arr[arr.Length()]
		}
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
	static regex := ("S)^('|"")(.*)(\1)$")
	ini:={}
	for k,v in StrSplit(IniRead(path),"`n"){
		ini[v]:=section:={}
		for k,v in StrSplit(IniRead(path,v),"`n"){
			key:=SubStr(v,1,i:=InStr(v,"=")-1)
			value:=SubStr(v,i+2)
			count:=0
			key := RegExReplace(key,regex,"$2",count)
			if(count==0){
				key:=StrReplace(key,"\t","`t")
				key:=StrReplace(key,"\n","`n")
			}
			value := RegExReplace(value,regex,"$2")
			section[key]:=value
		}
	}
	return ini
}