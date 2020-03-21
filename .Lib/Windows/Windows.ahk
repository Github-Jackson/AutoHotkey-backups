Class Windows extends WindowsPack{
	__New(title:=""){
		if(!IsObject(title))
			return this._Initial(WinGet("List",this.title:=title))
		this.list:=title
	}
	_Initial(list){
		this.list:=[]
		for k,v in list
			this.list.Push(new Window(v.id?v.id:v))
		return this
	}
	Exclude(title:="",text:=""){
		arr:=[]
		for k,v in this.list {
			if(title==""){
				if(StrLen(v.GetTitle()))
					arr.Push(v)
			}else{
				if(!InStr(v.GetTitle(),title))
					arr.Push(v)
			}
		}
		return new Windows(arr)
	}
	
	;Ex
	Window(index:=""){
		if(index=="")
			return this.Window(1)
		return this.list[index]
	}
	Processes(){
		return Processes.Build(this)
	}
}
