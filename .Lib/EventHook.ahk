Class EventHook{
	__New(min,max,fn){
		this.hwnd:=this.Hook(min,max,RegisterCallback(fn))
		OnExit(this)
	}
	Hook(min,max,fnptr){
		return DllCall("SetWinEventHook","UInt",0x0003,"UInt",0x0003,"Ptr",0,"Ptr",fnptr,"UInt",0,"UInt",0,"UInt",0)
	}
	Unhook(){
		return DllCall("UnhookWinEvent","Ptr",this.hwnd)
	}
	Call(){
		this.Unhook()
	}
}
