Class Hotkey extends HotkeyPack{
	__New(key,fn:="",decor*){
		this.key:=key
		this.fn:=IsObject(fn)?fn:Func(fn)
		this.decor:=new HotkeyDecorator(decor*)
		this.Register()
	}
	Push(fns*){
		for k,v in fns
			if(fn:=this.fn.Push(v))
				this.fn:=fn
		return this.fn
	}
	Clear(fns*){
		return this.fn.Clear(fns*)
	}
	New(key:="",fn:="",decor:=""){
		if(key=="")
			key:=this.key
		if(fn=="")
			fn:=this.fn
		if(decor=="")
			decor:=this.decor
		return new Hotkey(key,fn,decor)
	}
	Call(params*){
		return this.fn.Call(params*)?this.success.Call(params*):0
	}
	OnSuccess(params*){
		if(!this.success)
			this.success:=new Functions()
		return this.success.Push(params*)
	}
	ClearSuccess(params*){
		return this.success.Clear(params*)
	}
}
