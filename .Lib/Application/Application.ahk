#Include <InI>
#Include <Key>
#Include <Hotkey>
Class Application{
	static Application:=new Application()
	static Config ;Application.Config 配置文件
	static WorkingDirectory ; 原始工作目录, 一般用于AdminRun //管理员启动
	__New(o:="Application.Config"){
		Application.WorkingDirectory:=A_WorkingDir
		Application.Config:=o:=IsObject(o)?o:InIReader(o)
		new this.Control()
		new this.Setting()
		return Application.Application
	}
	Class Control{
		__New(){
			if(Application.Config.Control.HasKey("Modifier"))
				HotkeyIf(Application.Config.Control.Delete("Modifier"))
			for k,v in Application.Config.Control
				Hotkey(v,Func(k))
			HotkeyIf()
		}
	}
	Class Setting{
		__New(){
			for k,v in Application.Config.Setting
				Func("Set" k).Call(StrSplit(v,",")*)
		}
	}
}

AdminRun(){
	SetWorkingDir % Application.WorkingDirectory
	Run *RunAs %A_ScriptFullPath%
}