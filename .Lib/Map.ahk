Class Map{
	__New(o:=""){
		this._MAP:=o?o:{}
		return this
	}
	__Get(k){
		return this._MAP[k]
	}
	__Set(k,v){
		if(k!="_MAP")
			return this._MAP[k]:=v
	}
	_NewEnum(){
		return this._MAP._NewEnum()
	}
	Haskey(k){
		return this._MAP.HasKey(k)
	}
	Get(k){
		return this[k]
	}
	Put(k,v){
		return this[k]:=v
	}
	Remove(k){
		return this._MAP.Delete(k)
	}
	RemoveAll(map){
		for k,v in map
			if(this._MAP.HasKey(k))
				this.Remove(k)
		return this
	}
	Clear(o:=""){
		this._MAP:=o?o:{}
		return this
	}
	Clone(){
		return new Map(this._MAP.Clone())
	}
	Count(){
		return this._MAP.Count()
	}
	Keys(){
		arr:=[]
		for k in this
			arr.Push(k)
		return arr
	}
	Values(){
		arr:=[]
		for k,v in this
			arr.Push(v)
		return arr
	}
	
	Foreach(fn){
		fn:=IsObject(fn)?fn:Func(fn)
		for k,v in this
			fn.Call(v,k)
		return this
	}
	Each(fnName,params*){
		for k,v in this
			v[fnName](params*)
		return this
	}
	
	Union(_map){
		m:=this.Clone()
		for k,v in _map
			m.Put(k,v)
		return m
	}
	Intersection(_map){
		m:=new Map()
		for k,v in _map
			if this.HasKey(k)
				m.Put(k,v)
		return m
	}
	Difference(_map){
		m:=this.Union(_map)
		for k,v in this.Intersection(_map)
			if(m.HasKey(k))
				m.Remove(k)
		return m
	}
}