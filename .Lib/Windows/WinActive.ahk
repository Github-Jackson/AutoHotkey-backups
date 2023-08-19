Class WinActive{
	__New(e){
		this.title:=new WinTitle(e)
	}
	
	Call(){
		if(this.title.HasEx())
			for k,v in this.title.ex
				if(WinActive(v))
					return 0
		for k,v in this.title
			if(WinActive(v))
				return 1
		return 0
	}
}
