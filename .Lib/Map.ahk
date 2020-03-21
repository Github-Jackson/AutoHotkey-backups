Class Map{
	__New(){
		this._Initial(list)
	}
	__Get(k){
		return this.map[k]
	}
	__Set(k,v){
		if(this.map)
			return this.map[k]:=v
	}
	__Call(name,params*){
		if(!IsFunc(this[name]))
			return (this.map)[name](params*)
	}
	_NewEnum(){
		return this.map._NewEnum()
	}
	_Initial(list){
		this.map:={}
	}
	Get(k){
		return this.map[k]
	}
	Put(k,v){
		this.map[k]:=v
		return this
	}
	Remove(k){
		return this.map.Delete(k)
	}
	Clear(){
		this.map:={}
		return this
	}
}