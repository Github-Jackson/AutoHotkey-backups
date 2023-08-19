Class Window extends WindowPack{
	__New(id:="A"){
		if(id=="A")
			id:=WinActive("A")
		this.id:=id
		this._id:="ahk_id " id
		this[""]:={name:"",path:"",pid:"",class:""}
	}
	__Get(k){
		if(this[""].HasKey(k)){
			if(!(this[""])[k])
				(this[""])[k]:=this["Get" k]()
			return (this[""])[k]
		}
	}
	PID(){
		return new Windows(#(this.pid))
	}
	Name(){
		return new Windows(@(this.name))
	}
	Path(){
		return new Windows(@(this.path))
	}
	Class(){
		return new Windows($(this.class))
	}
	Title(){
		return new Windows(this.GetTitle())
	}
	;Ex
	Process(){
		return new Process(this.pid)
	}
	Windows(){
		return new Windows(#(this.pid))
	}
	Control(){
		MsgBox Undefined
	}
}
