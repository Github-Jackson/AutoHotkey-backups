FileAppend(text,filename:="",encoding:=""){
	FileAppend,% text,% filename,% encoding
}
FileDelete(filePattern){
	FileDelete,% filePattern
}
FileCreateDir(dir){
	FileCreateDir,% dir
}
FileCreateShortcut(){
	MsgBox Undefined
}

FileCopy(source,dest,overWrite:=0){
	FileCopy,% source,% dest,% overWrite
}
FileMove(source,dest,overwrite:=0){
	FileMove,% source,% dest,% overwrite
}
FileCopyDir(source,dest,overWrite:=0){
	FileCopyDir,% source,% dest,% overWrite
}
FileMoveDir(source,dest,flag:=0){
	FileMoveDir,% source,% dest,% flag
}
FileRemoveDir(dirName,recurse:=0){
	FileRemoveDir,% dirName,% recurse
}

FileRead(filename){
	FileRead,out,% filename
	return out
}
FileReadLine(filename,line){
	FileReadLine,out,% filename,% line
	return out
}

FileGetAttrib(filename:=""){
	FileGetAttrib,out,% filename
	return out
}
FileGetShortcut(linkFile){
	FileGetShortcut,% linkFile,target,dir,args,desc,icon,iconNum,runState
	return {target:target,dir:dir,args:args,desc:desc,icon:icon,iconNum:iconNum,runState:runState}
}
FileGetSize(filename:="",units:=""){
	FileGetSize,out,% filename,% units
	return out
}
FileGetTime(filename:="",MCA:="M"){
	FileGetTime,out,% filename,% MCA
	return out
}
FileGetVersion(filename:=""){
	FileGetVersion,out,% filename
	return out
}
FileSetAttrib(attrs,filePattern:="",onfolder:=0,recurse:=0){
	FileSetAttrib,% attrs,% filePattern,% onfolder,% recurse
}
FileSetTime(date:="",filePattern:="",MCA:="M",onfolder:=0,recurse:=0){
	FileSetTime,% date,% filePattern,% MCA,% onfolder,% recurse
}


;----dialog box
FileSelectFile(options:="",root:="",prompt:="",filter:="*.*"){
	FileSelectFile,out,% options,% root,% prompt,% filter
	return out
}
FileSelectFolder(start:="",options:=1,prompt:=""){
	FileSelectFolder,out,% start,% options,% prompt
	return out
}


FileRecycle(filePattern){
	FileRecycle,% filePattern
}
FileRecycleEmpty(driveLetter){
	FileRecycleEmpty,% driveLetter
}

FileEncoding(encoding:="UTF-8"){
	FileEncoding,% encoding
}
SetWorkingDir(dirName){
	SetWorkingDir,% dirName
}
SplitPath(path){
	SplitPath,% path,path,dir,ext,name,dirve
	return {path:path,dir:dir,ext:ext,name:name,dirve:dirve}
}
