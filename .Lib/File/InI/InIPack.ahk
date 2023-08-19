Class InIPack{
	_Read(section:="",params*){
		IniRead,out,% this[""].path,% section,% params[1],% params[2]
		return out
	}
	_Write(value,section,key:="="){
		if(IsObject(value))
			this._WriteObject(value,section)
		else if(key=="=")
			IniWrite,% value,% this[""].path,% section
		else
			IniWrite,% value,% this[""].path,% section,% key
		return this
	}
	_WriteObject(object,section){
		for k,v in object
			t:=t . k "=" v "`n"
		return this._Write(t,Section)
	}
	_Delete(section:="",key:="="){
		if(key=="=")
			IniDelete,% this[""].path,% section
		else
			IniDelete,% this[""].path,% section,% key
		return this
	}
}