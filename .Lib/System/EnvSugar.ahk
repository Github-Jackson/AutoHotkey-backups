EnvGet(name){
	EnvGet,out,% name
	return out
}
EnvSet(var,value){
	EnvSet,% var,% value
}
EnvUpdate(){
	EnvUpdate
}
EnvDeref(str){
	Transform,out,Deref,% str
	return out
}