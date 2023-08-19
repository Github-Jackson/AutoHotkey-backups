#Include <Function>
Class HotkeyPack{
	Decorator(){
		if(this.decor.Length())
			HotkeyIf(this.decor)
		return this.decor
	}
	Register(){
		this.Decorator()
		Hotkey(this.key,this)
		HotkeyIf()
		return this
	}
	Options(options){
		this.Decorator()
		Hotkey,% this.key,,%options%
		HotkeyIf()
		return this
	}
	On(){
		this.Decorator()
		Hotkey(this.key,"On")
		HotkeyIf()
		return this
	}
	Off(){
		this.Decorator()
		Hotkey(this.key,"Off")
		HotkeyIf()
		return this
	}
	Toggle(){
		this.Decorator()
		Hotkey(this.key,"Toggle")
		HotkeyIf()
		return this
	}
}
