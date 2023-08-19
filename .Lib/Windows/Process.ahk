Class Process extends WindowPack{
	__New(id:="A"){
		if(id=="A")
			id:=WinGet("PID","A")
		this.id:=id
		this._id:="ahk_pid " id
		this[""]:={name:"",path:"",pid:"",class:""}
	}
	__Get(k){
		if(this[""].HasKey(k)){
			if(!(this[""])[k])
				(this[""])[k]:=this["Get" k]()
			return (this[""])[k]
		}
	}
	Name(){
		return new Processes(@(this.name))
	}
	Path(){
		return new Processes(@(this.path))
	}
	Class(){
		return new Processes($(this.class))
	}
	Title(){
		return new Processes(this.GetTitle())
	}
	;Ex
	Window(){
		return this.Windows().Window()
	}
	WaitWindow(s:=""){
		WinWait(this._id,,s)
		return this.Window()
	}
	Windows(){
		return new Windows(this._id)
	}
	Processes(){
		return new Processes(@(this.path))
	}
	
	;Process
	Exist(){
		Process("Exist",this.id)
		return ErrorLevel?this:0
	}
	Close(){
		Process("Close",this.id)
		return this
	}
	Priority(LBNAHR){
		Process("Priority",this.id,LBNAHR)
	}
	Wait(s:=""){
		if(s=="")
			Process("Wait",this.id)
		else
			Process("Wait",this.id,s)
		return ErrorLevel?this:0
	}
	WaitClose(s:=""){
		if(s=="")
			Process("WaitClose",this.id)
		else
			Process("WaitClose",this.id,s)
		return ErrorLevel?ErrorLevel:0
	}
}
