#Include <ahk/util/List>
Class Functions extends List{
	__New(fns*){
		this._Initial(fns)
	}
	Push(fns*){
		for k,v in fns
			this.list.Push(new Func(v))
		return this
	}
	Call(params*){
		for k,v in this
			result:=v.Call(params*)
		return result
	}
}