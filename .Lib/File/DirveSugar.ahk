Drive(cmd,drive,v:=""){
	Drive,% cmd,% drive,% v
}
DriveGet(cmd,v:=""){
	DriveGet,out,% cmd,% v
	return out
}
DiveSpaceFree(e){
	DriveSpaceFree,out,% path
	return out
}