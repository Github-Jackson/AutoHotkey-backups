#Include <Windows>
#Include <Execute>
Class WinHotkeyDirector{
	static Register:=WinHotkeyDirector.Build.Bind(new WinHotkeyDirector())
	static director:={}
	static HideWindows:={}
	static Current:=[]
	
	Build(fileName,ext){
		key:=this.GetKey(StrReplace(fileName,"." ext))
		if(this.director.HasKey(key)){
			test:=this.director[key]
			return this.director[key].Push(fileName)
		}
		if(InStr(key,Application.Config.Config.ModifierEnd)){
			arr:=StrSplit(key,Application.Config.Config.ModifierEnd)
			key:=arr[2]
			modifier:=arr[1]
		}
		key:=this.ReplaceKey(key),modifier:=this.GetModifier(modifier)
		if(!this.director[modifier . key]){
			try this.director[modifier . key]:=new Hotkey(key,new Execute(filename),modifier)
			try this.director[modifier . key].New(Application.Config.Config.NewModifier . key,,modifier,Application.Config.Config.New)
		}else
			this.director[modifier . key].Push(filename)
	}
	GetKey(e){
		if(index:=InStr(e,Application.Config.Config.HotkeyEnd))
			return SubStr(e,1,index-1)
		return e
	}
	ReplaceKey(e){
		for k,v in Application.Config.KeyMap{
			e:=StrReplace(e,k,v)
		}
		return e
	}
	GetModifier(e){
		for k,v in Application.Config.ModifierMap
			e:=StrReplace(e,k,v)
		return StrReplace(e,"\","&")
	}
	OnExit(){
		for k,v in WinHotkeyDirector.HideWindows
			try v.Show()
	}
	OnHide(){
		new Windows()[Application.Config.Config.ActivateIndex].Activate()
	}
}
