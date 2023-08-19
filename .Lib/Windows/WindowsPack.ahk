#Include <List>
Class WindowsPack extends List{
	Active(){
		for k,v in this.list
			if(v.Active())
				return v
		return 0
	}
	
	Activate(){
		this.last.Activate()
		return this.last
	}
	
}