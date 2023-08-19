class KeyState{
	static rep:={"<":"L",">":"R","#":"Win&","!":"Alt&","^":"Ctrl&","+":"Shift&","*":"","~":"","$":""}
	__New(key){
		this._key:=key
		this._e:=this._Replace(key)
	}
	_Replace(exp){
		for k,v in rep
			exp:=StrReplace(exp,k,v)
		return exp
	}
	
	_FunS(e){
		result:=1
		for k,v in StrSplit(e,"&")
			result&=GetKeyStatus(v)
		return result
	}
		
	
	Get(){
		try{
		this.file:=FileOpen("log.txt","w")
		return this.GetStatus(this._e)
		}finally{
			this.file.Close()
		}
	}
	
	GetStatus(e){
		lIndex:=InStr(e,"(")
		rIndex:=InStr(e,")")
		this.file.WriteLine(e)
		MsgBox % lindex ":" rindex "-" e
		if(lIndex<rIndex&&lIndex!=0)
			return this.GetStatus(SubStr(e,1,lIndex-1) . this.GetStatus(SubStr(e,lIndex+1)))
		if(rIndex)
			return (this._GetState(SubStr(e,1,rIndex-1))?"_VKFF":"VKFF") . this.GetStatus(SubStr(e,rIndex+1))
		return this._GetState(e)
		
	}
	GetState(e){
		return GetKeyState(Trim(StrReplace(e,"@")),InStr(e,"@") ? "T":"P")
	}
	_GetState(e){
		local result:=0
		this.file.WriteLine("-" e)
		MsgBox % ":" e
		if(InStr(e,"|")){
			for k, v in StrSplit(e,"|")
				result|=this._GetState(v)
			return result
		}
		result:=1
		for k,v in StrSplit(e,"&")
			result&=this.GetState(StrReplace(v,"_",,count))^(count&&1)
		return result
	}
}
