Class HotkeyDirector{
	__New(decor*){
		this.decor:=new HotkeyDecorator(decor*)
		this.decor.On(1)
		this.map:={}
	}
	__Get(k){
		return this.map[key]
	}
	_NewEnum(){
		return this.map._NewEnum()
	}
	Get(key){
		return this.map[key]
	}
	Set(key,hk){
		return this.map[key]:=hk
	}
	Put(key,fns*){
		if(!this.map.HasKey(key))
			this.map[key]:=new Hotkeys(key,,this.decor)
		return this.map[key].Push(fns*)
	}
	Remove(key){
		return this.map[key].Clear()
	}
	On(key:=""){
		if(key)
			return this.map[key].On()
		return this.decor.On()
	}
	Off(key:=""){
		if(key)
			return this.map[key].Off()
		return this.decor.Off()
	}
}