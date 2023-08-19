Class Processes extends WindowsPack{
	__New(title:=""){
		if(!IsObject(title))
			return this.Initial(this.match:=new WinMatch(this.title:=title))
		this.match:=new WinMatch()
		this.list:=title
	}
	Initial(){
		map:=new Map()
		for k,v in this.match.Find(){
			if(!map.HasKey(pid:=WinGet("pid","ahk_id " k)))
				map[pid]:=new Process(pid)
		}
		this.list:=map.Values()
		return this
	}
	
	Process(i:=1){
		return this.list[i]
	}
	Windows(){
		wins:=new Windows([])
		for k,v in this
			wins.Push(new Windows("ahk_pid " v.id).list*)
		return wins
	}
}
