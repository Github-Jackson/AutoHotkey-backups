#Include <List>
Class WindowsPack extends List{
	Active(){
		for k,v in this.list
			if(v.Active())
				return v
		return 0
	}
	
	Activate(){
		if(this.title)
			WinActivate(this.title)
		else
			this.list.last.Activate()
		return this
	}
	
}