Class Function{
	__New(fn,params*){
		this.fn:=IsObject(fn)?fn:Func(fn)
		this.params:=params
	}
	__Get(attr){
		return this.fn[attr]
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
		return new Function(this.fn,this.GetParams(this.params*)*)
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
	__New(p*){
		return new Function(p*)
	}
}
Function(fn,params*){
	return new Function(fn,params*)
}