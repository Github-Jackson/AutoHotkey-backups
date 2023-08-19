Class InIFile extends InIPack{
	__New(path,name:=""){
		this[""]:={fileName:path,path:path,name:name}
		this.Read()
	}
	__Get(k,p*){
		if(this._ini.HasKey(k))
			return (l:=p.Length())?this[k][p[l]]:this._ini[k]
		if(this[""].HasKey(k))
			return this[""][k]
		return new this.InISection(this,k)
	}
	__Set(k,params*){
		if(k!="" and k!="_ini"){
			v:=params[params.Length()]
			if(IsObject(v))
				return new this.InISection(this._WriteObject(v,k),k)
			else
				return v==""?new this.InISection(this,k).Write(v):this.Delete(k)
		}
	}
	_NewEnum(){
		return this._ini._NewEnum()
	}
	Read(){
		this._ini:={}
		for k,v in StrSplit(this._Read(),"`n")
			new this.InISection(this,v)
		return this
	}
	Delete(section,key:="="){
		return this._Delete(section,key)._ini.Delete(section)
	}
	Write(pairs,section){
		return new this.InISection(this,section).Write(pairs)
	}
	Class InISection extends InIPack{
		__New(ini,section){
			this[""]:={section:section,ini:ini,path:ini[""].path}
			ini._ini[section]:=this
			this.Read()
		}
		__Get(k){
			if(this._pairs[k])
				return this._pairs[k]
			if(this[""][k])
				return this[""][k]
		}
		__Set(k,v){
			if(v=="")
				this.Delete(k)
			else if(!IsObject(v))
				return this._Write(v,this[""].section,k)._pairs[k]:=v
		}
		_NewEnum(){
			return this._pairs._NewEnum()
		}
		Read(){
			this._pairs:={}
			for k,v in StrSplit(this._Read(this[""].section),"`n")
				this._pairs[SubStr(v,1,InStr(v,"=")-1)]:=SubStr(v,InStr(v,"=")+1)
			return this
		}
		Write(k,v:="="){
			if(v=="=")
				return this._Write(k,this[""].section).Read()
			this._pairs[k]:=v
			return this._Write(v,this[""].section,k)
		}
		Delete(key:="="){
			if(key=="=")
				return this[""].ini.Delete(this[""].section)
			return this._Delete(this[""].section,key)._pairs.Delete(key)
		}
	}
}