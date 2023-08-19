Class Array{
	__New(params*){
		arr:=params
		arr.base:=Array
		return arr
	}

	Shift(params*){
		if(params.Length())
			this.InsertAt(1, params*)
		else
			return this.RemoveAt(1)
	}

	Foreach(fn){
		fn:=new Func(fn)
		for k,v in this
			fn.Call(v,k)
		return this
	}
	Each(fnName:="Call",params*){
		for k,v in this
			v[fnName](params*)
		return this
	}
}
