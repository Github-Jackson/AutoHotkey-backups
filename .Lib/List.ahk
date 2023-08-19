Class List{
	__New(list*){
		this._Initial(list)
	}
	__Call(name,params*){
		if(!IsFunc(this[name])){
			if(IsFunc((this.list)[name]))
				return (this.list)[name](params*)
			return this.each(name,params*)
		}
	}
	__Get(k){
		if k is Integer
			return this.list[k]
	}
	_NewEnum(){
		return this.list._NewEnum()
	}
	_Initial(list){
		this.list:=[]
		this.Push(list*)
	}
	Push(params*){
		this.list.Push(params*)
		return this
	}
	Pop(){
		return this.list.Pop()
	}
	Add(params*){
		return this.Push(params*)
	}
	Clear(params*){
		this.list:=params
		return this
	}
	Count(){
		return this.list.Length()
	}
	InsertAt(pos,v,vs*){
		return this.list.InsertAt(pos,v,vs*)
	}
	RemoveAt(pos,length:=""){
		if(length=="")
			return this.list.RemoveAt(pos)
		return this.list.RemoveAt(pos,length)
	}
	Delete(key,lastkey:=""){
		if(lastkey=="")
			return this.list.Delete(key)
		return this.list.Delete(key,lastkey)
	}
	MinIndex(){
		return this.list.MinIndex()
	}
	MaxIndex(){
		return this.list.MaxIndex()
	}
	Length(){
		return this.list.Length()
	}
	
	
	Last{
		get{
			return this.list[this.list.Length()]
		}
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
	
	
}