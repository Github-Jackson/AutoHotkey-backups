Class WinTitle{
	static NULL:=""
	static rep:={"@":" ahk_exe ","$":" ahk_class "}
	__New(e){
		this.title:=this._Replace(this._e:=e)
		tmp:=StrSplit(this.title,"!!")
		if(InStr(this.title,"!!"))
			this.ex:=this._Split(tmp[2])
		this.e:=this._Split(tmp[1])
	}
	_Replace(e){
		for k,v in this.rep
			e:=StrReplace(e,k,v)
		return e
	}
	_WinGet(e:=""){
		m:=new Map()
		WinGet,out,List,%e%
		loop %out% {
			m.Put(out%out%,this.NULL)
			out--
		}
		return m
	}
	_Split(e){
		if(InStr(e,"||"))
			return StrSplit(e,"||")
		return [e]
	}
	_NewEnum(){
		return this.e._NewEnum()
	}
	HasEx(){
		return this.ex!=""
	}
	
	Get(){
		return this.Exclude(this.Match())
	}
	Match(){
		temp:=new Map()
		for k,v in this
			temp:=temp.Union(this._WinGet(v))
		return temp
	}
	Exclude(map){
		if(this.HasEx())
			for k,v in this.ex
				for k,v in this._WinGet(v)
					if(map.HasKey(k))
						map.Remove(k)
		return map
	}
	
	SetTitleMatchMode(e){
		SetTitleMatchMode,%e%
	}
}