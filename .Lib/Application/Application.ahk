#Include <InI>
#Include <Key>
#Include <Hotkey>
Class Application{
	static Application:=new Application()
	__New(o:="Application.Config"){
		Application.Config:=o:=IsObject(o)?o:InIReader(o)
		new this.Control()
		HotkeyIf()
		return Application.Application
	}
	Class Control{
		__New(){
			if(Application.Config.Control.HasKey("Modifier"))
				HotkeyIf(Application.Config.Control.Delete("Modifier"))
			for k,v in Application.Config.Control
				Hotkey(v,Func(k))
		}
	}
	Class Setting{
		__New(){
			
		}
	}
}
