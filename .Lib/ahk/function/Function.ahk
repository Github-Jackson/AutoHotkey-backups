Class Function{
	__New(fn,params*){
		this.fn:=new Func(fn)
		this.params:=params
	}
	__Get(key){
		return this.fn[key]
	}

	GetParams(params*){
		if(this.params.Length())
			params.InsertAt(1,this.params*)
		return params
	}
	Call(params*){
		return this.fn.Call(this.GetParams(params*)*)
	}
	Bind(params*){
		this.params.Push(params*)
		return this
	}
	_Bind(params*){
		return this.fn.Bind(this.GetParams(params*)*)
	}
	Factory(params*){
		return new Function(this.fn,this.GetParams(params*)*)
	}
	New(params*){
		return new Function(this.fn,params*)
	}

	IsByRef(params*){
		return this.fn.IsByRef(params*)
	}
	IsOptional(params*){
		return this.fn.IsOptional(params*)
	}
}
Class Func{
	__New(fn){
		return IsObject(fn)?fn:Func(fn)
	}
}
