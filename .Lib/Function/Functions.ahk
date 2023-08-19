#Include <List>
Class Functions extends List{
	__New(fns*){
		this._Initial(fns)
	}
	Push(params*){
		for k,v in params
			this.list.Push(IsObject(v)?v:new Function(v))
		return this
	}
	Call(params*){
		for k,v in this
			result:=v.Call(params*)
		return result
	}
}