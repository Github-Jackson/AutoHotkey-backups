Class Processes extends WindowsPack{
	__New(title:=""){
		if(!IsObject(title))
			return this._Initial(title)
		this.list:=title
	}
	_Initial(title){
		return Processes.Build(WinGet("List",title),title)
	}
	Build(wins,title:=""){
		list:=[]
		map:={}
		for k,v in wins{
			if(!v.pid)
				v:=new Window(v)
			if(!map.HasKey(v.pid)){
				list.Push(map[v.pid]:=new Process(v.pid))
			}
		}
		procs:=new Processes(list)
		procs.map:=map
		procs.wins:=list
		procs.title:=title
		return procs
	}
	;Ex
	Process(i:=1){
		return this.list[index]
	}
	Windows(){
		return new Windows(this.wins)
	}
}
