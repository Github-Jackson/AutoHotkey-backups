#Include <Key>
#Include <Function>
#Include <InI>
#Include <Hotkey>
#UseHook

class KeyMap{
	static Modifier:=new HotkeyDirector()
	static action:={}
	__New(ini){
		if((this.Name:=ini.Name)!="")
			try (h:=KeyMap.Modifier.Put("*" ini.Name " Up",this)).list.Call:=this.CallAll
		if(h)
			return this.Register(ini)
		HotkeyIf(this.Name)
		for k,v in ini 
			new this.KeySection(k,v,this)
		HotkeyIf()
	}
	CallAll(){
		result:=1
		for k,v in this.list
			result&=v.Call()
		return result
	}
	Register(ini){
		this._keyStates:={"":new KeyState(this.name)}

		for k,v in ini {
			if(InStr(k,"@")||InStr(k,"&"))
				this._keyStates[k]:=this.GetKeyState(v)
			HotkeyIf(this.GetAction.Bind(this,k))
			new this.KeySection(k,v,this)
			HotkeyIf()
		}
	}
	GetAction(e){
		result:=0
		if(InStr(e,"&"))
			result:=result||this.action[this.Name]
		if(InStr(e,"@"))
			result:=result||this["@"]
		return result||this._keyStates[""].Call()
	}
	
	Call(){
		for k,v in this._keyStates
			if(v.Call())
				return !this.Control(k)
		if(this[""])
			this[""]:=this["@"]:=this.action[this.name]:=0
		else return true
	}
	Control(section){
		if(InStr(section,"@"))
			return this["@"]:=1
		if(InStr(section,"&"))
			return this.action[this.Name]:=1
		return 1
	}
	GetKeyState(o){
		temp:="_"
		for k,v in o
			temp.="|" k
		return new KeyState(temp)
	}
	Class KeySection{
		static SendAss:={modify:{"~":"~","*":"*"},mode:{"%":"{Raw}","#":"{Text}","*":"{Blind}"}}
		__New(name,section,parent){
			this.parent:=parent
			this._Initial(name)
			for k,v in section
				Hotkey(this.prev . k,this.Send.Bind(this,this.mode . v))
		}
		_Initial(name){
			if(InStr(name,"!"))
				this.Send:=this.SendPlay
			if(InStr(name,"$"))
				this.Send:=this.SendEvent
			for k,v in this.SendAss.modify
				if(InStr(name,k))
					this.prev.=v
			for k,v in this.SendAss.mode
				if(InStr(name,k))
					this.mode:=v . this.mode
		}
		Send(v){
			this.parent[""]:=1
			Send %v%
		}
		SendEvent(v){
			this.parent[""]:=1
			SendEvent %v%
		}
		SendPlay(v){
			this.parent[""]:=1
			SendPlay %v%
		}
	}
}
