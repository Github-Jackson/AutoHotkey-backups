Class Windows extends WindowsPack{
	__New(title:=""){
		if(!IsObject(title))
			return this.Initial(this.match:=new WinMatch(this.title:=title))
		this.match:=new WinMatch()
		this.list:=title
	}
	
	Initial(){
		this.list:=[]
		for k,v in this.match.Find()
			this.list.Push(new Window(k))
		return this
	}
	Exclude(title:=""){
		; WindowTitleMatchMode not exreg
		map:=new WinMatch(title).Find()
		for k,v in this.list
			if(map.HasKey(v.id))
				this.list.RemoveAt(k)
		return this
	}
	
	;Ex
	Window(index:=1){
		return this.list[index]
	}
	Processes(){
		proces:=new Processes([])
		map:=new Map()
		for k,v in this
			if(!map.HasKey(v.pid))
				map[v.pid]:=v.Process()
		proces.list:=map.Values()
		return proces
	}
}
