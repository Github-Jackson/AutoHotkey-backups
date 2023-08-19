#Include <Map>
Class WinMatch{
	__New(e){
		this.title:=new WinTitle(e)
	}

	Find(){
		return this.title.Get()
	}
	Match(){
		return this.Find()
	}
	Call(){
		return this.Find()
	}
	
	SetTitleMatchMode(e){
		SetTitleMatchMode,%e%
	}
}
