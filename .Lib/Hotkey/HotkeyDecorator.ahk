#Include <Key>
#Include <Decorator>
Class HotkeyDecorator extends Decorator{
	__New(params*){
		if(params[1].__Class==this.__Class){
			return params[1]
		}
		this._Initial(params)
		this.state:=2
	}
	Push(params*){
		for k,v in params{
			if(v){
				if(IsObject(v))
					this.list.Push(v)
				else if(IsFunc(v))
					this.list.Push(Func(v))
				else
					this.list.Push(new KeyState(v))
			}
		}
		return this.list.Length()
	}
	Clone(){
		return new HotkeyDecorator(this.list*)
	}
}