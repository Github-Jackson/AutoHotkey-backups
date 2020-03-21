Class IDirectory{
	__New(filename){
		this.filename:=filename
	}
	IsNew(){
		return 1
	}
	New(){
		Run(this.filename)
	}
}
