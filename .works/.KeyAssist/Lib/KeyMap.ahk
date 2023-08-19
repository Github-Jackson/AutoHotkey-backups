#Include <Map>
#Include <Key>
#Include <Function>
#Include <InI>
#Include <Hotkey>
#Include <WinActive>
#Include <Application>
#UseHook

class KeyMap{
	static Modifier := new Map()
	static action:={}
	static press:={}
	static LongMappingDetectionDelay := 20
	__New(filePath){
		SplitPath, % filePath ,, dir,, name
		name:=this._Replace(name,Application.Config.NameReplace)
		dir:=this._Replace(dir,Application.Config.PathReplace)

		if(dir){
			this.active:=new WinActive(dir)
		}
		ini:= new InIReader(filePath)
		if((this.Name:=name)){
			
			if(!KeyMap.Modifier.HasKey(dir)){
				KeyMap.Modifier.Put(dir,new HotkeyDirector(this.active))
			}
			
			try {
				h:=KeyMap.Modifier[dir].Put("*" name " Up",this).list.Call:=this.CallAll
			}
			return this.Register(ini)
		}
		HotkeyIf(new HotkeyDecorator(this.Name,this.active).On(1))
		for k,v in ini {
			new this.KeySection(k,v,this)
		}
		HotkeyIf()
	}
	CallAll(){
		result:=1
		for k,v in this.list
			result&=v.Call()
		return result
	}
	_Replace(e,replaceMap){
		for k,v in replaceMap{
			e:=StrReplace(e,k,v)
		}
		return e
	}
	Register(ini){
		this._keyStates:={"":new KeyState(this.name)}

		for k,v in ini {
			if(InStr(k,"@")||InStr(k,"&"))
				this._keyStates[k]:=this.GetKeyState(v)
			HotkeyIf(new HotkeyDecorator(this.GetAction.Bind(this,k),this.active).On(1))
			new this.KeySection(k,v,this)
			HotkeyIf()
		}
	}
	GetAction(e){
		result:=0
		if(InStr(e,"&"))
			result:=result||KeyMap.action[this.Name]
		if(InStr(e,"@"))
			result:=result||this["@"]
		return result||this._keyStates[""].Call()
	}
	
	Call(){
		Sleep % this.LongMappingDetectionDelay
		for k,v in this._keyStates
			if(v.Call())
				return !this.Control(k)
		if(KeyMap.press[this.Name]){
			this.SetPress(0)
			this["@"]:=KeyMap.action[this.Name]:=0
		}
		else {
			return true
		}
	}
	Sending(){
		this.SetPress()
	}
	SetPress(state:=1){
		KeyMap.press[this.Name]:=state
	}
	Control(section){
		if(InStr(section,"@"))
			return this["@"]:=1
		if(InStr(section,"&"))
			return KeyMap.action[this.Name]:=1
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
		static toggle_regex:="OS){@(.+?)( .)?}" ;用于匹配Send 中的{@name}
		__New(name,section,parent){
			this.parent:=parent
			this._Initial(name)
			for k,v in section{
				if(InStr(k,":")){
					Hotstring(k,v)
				}else{
					index:=1,init:=1
					loop
					{
						if(index:=RegExMatch(v,this.toggle_regex,match,index)){
							if(init){
								this.toggle:={},init:=0
							}
							index++
							this.toggle[match[1]]:=match[2]&1
						}else{
							break
						}
					}
					Hotkey(this.prev . k,this.Send.Bind(this,this.mode . v))
				}
			}
				
		}
		_Initial(name){
			if(InStr(name,"!"))
				this._Send:=this.SendPlay
			if(InStr(name,"$"))
				this._Send:=this.SendEvent
			if(InStr(name,"^"))
				this._Send:=this.SendInput
			for k,v in this.SendAss.modify
				if(InStr(name,k))
					this.prev.=v
			for k,v in this.SendAss.mode
				if(InStr(name,k))
					this.mode:=v . this.mode
		}
		Send(value){
			this.parent.Sending()
			this._Send(value)
			if(this.toggle){
				for k,v in this.toggle{
					if(v==""){
						KeyState.toggle[k]:=!KeyState.toggle[k]
					}else{
						KeyState.toggle[k]:=v
					}
				}
			}
		}
		_Send(v){
			Send %v%
		}
		SendInput(v){
			SendInput %v%
		}
		SendEvent(v){
			SendEvent %v%
		}
		SendPlay(v){
			SendPlay %v%
		}
	}
}