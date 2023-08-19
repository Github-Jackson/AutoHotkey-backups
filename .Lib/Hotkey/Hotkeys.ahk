#Include <Function>
Class Hotkeys extends HotkeyPack{
	__New(key,decor*){
		this.key:=key
		this.list:=new HotkeyDecorator()
		this.decor:=new HotkeyDecorator(decor*)
		this.Register()
	}
	Push(fns*){
		for k,v in fns
			if(IsObject(v))
				this.list.Push(v)
			else if(IsFunc(v))
				this.list.Push(Func(v))
		return this
	}
	Clear(fns*){
		return this.list.Clear(fns*)
	}
	New(key:="",fns:="",decor:=""){
		if(key=="")
			key:=this.key
		if(decor=="")
			decor:=this.decor
		hk:=new Hotkeys(key,this.decor)
		if(fns=="")
			fns:=this.list
		hk.list:=fns
		return hk
	}
	Call(params*){
		return this.list.Call(params*)?this.success.Call(params*):0
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
