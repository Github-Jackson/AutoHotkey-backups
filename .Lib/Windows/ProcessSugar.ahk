Process(cmd,target:="",params*){
	if(params.Length())
		Process,%cmd%,%target%,% params[1]
	else
		Process,%cmd%,%target%
}
Run(target,options:=""){
	Run,% target,,% options,out
	return out
}
RunWait(target,options:=""){
	RunWait,% target,,% options,out
	return out
}

ShutDown(code:=0){
	;0:注销,1:关机,2:重启,4:强制,8:断电
	Shutdown,% code
}