Class WindowPack{
	__Call(name,params*){
		if(!IsFunc(this[name])){
			if(IsFunc("Win" name))
				return (result:=Func("Win" name).Call(this._id,params*))==-1?this:result
			else if(InStr(name,"Get")==1)
				try return this.Get(SubStr(name,4),params*)
			else if(InStr(name,"Set")==1)
				try return this.Set(SubStr(name,4),params*)
			else
				try return this.Set(name,params*)
		}
	}
	__Get(k){
		if(this[""].HasKey(k)){
			if(!(this[""])[k])
				(this[""])[k]:=this["Get" k]()
			return (this[""])[k]
		}
	}
	_NewEnum(){
		return this[""]._NewEnum()
	}
	Get(cmd){
		return WinGet(cmd,this._id)
	}
	Set(cmd,v:=""){
		WinSet(cmd,v,this._id)
		return this
	}
	GetName(){
		return this.Get("ProcessName")
	}
	GetPath(){
		return this.Get("ProcessPath")
	}
	GetState(){
		return this.Get("MinMax")
	}
	
	GetList(){
		WinGet,i,List,% this._id
		arr:=[]
		loop %i% {
			arr.Push(i%i%)
			i--
		}
		return arr
	}
	
	Active(){
		return (ihwnd:=WinActive(this._id))?new Window(ihwnd):0
	}
	Close(s:=""){
		WinClose(this._id,,s)
		return this
	}
	Kill(s:=""){
		WinKill(this._id,,s)
		return this
	}
	SetTitle(newTitle){
		WinSetTitle(newTitle,this._id)
		return this
	}
	Wait(s:=""){
		WinWait(this._id,,s)
		return this
	}
	WaitActive(s:=""){
		WinWaitActive(this._id,,s)
		return this
	}
	WaitNotActive(s:=""){
		WinWaitNotActive(this._id,,s)
		return this
	}
	WaitChange(s:=""){
		if(this.Active())
			return this.WaitNotActive(s)
		else
			return this.WaitActive(s)
	}
	WaitClose(s:=""){
		WinWaitClose(this._id,,s)
		return this
	}
}