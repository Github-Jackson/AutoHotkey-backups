#Include <List>
Class Decorator extends List{
	__New(params*){
		this._Initial(params)
	}
	_Initial(list){
		this.list:=[]
		this.Push(list*)
		this.state:=2
	}
	Call(params*){
		result:=this.state&1
		if(!(this.state&2))
			return result
		for k,v in this.list
			if((v.Call()&&1)==result)
				return result
		return !result
	}
	On(state:=0){
		this.state:=state?3:2
		return this
	}
	Off(state:=0){
		this.state:=state?1:0
	}
	Toggle(){
		this.state^=3
	}
}