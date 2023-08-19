#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

#SingleInstance Force
#NoTrayIcon

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SelectOutFolder()
global list:=GetList()
RunCmd(Command(list)

SelectOutFolder(){
	FileSelectFolder,selectFolder,*%A_WorkingDir%,3,选择MKLink的输出目录
	SetWorkingDir,%selectFolder%
	return selectFolder
}

GetList(dirPath:="../"){
	fileList :=[]
	Loop,Files,%dirPath%\*,D
	{
		Loop,Files,%A_LoopFilePath%\*.List,D
		{
			fileList.Push(A_LoopFileLongPath)
		}
	}
	return fileList
}
Command(list){
	command:="CD " . A_WorkingDir
	for k,v in list
	{
			command.=" & " (MKLink(GetKey(v),v))
	}
	return command
}

RunCmd(Command){
	Run,cmd /C %Command%,,Hide
}

MKLink(name,target,type:="J"){
	result:="Mklink /" type " "
	result.=name " " target
	return result
}

GetKey(filePath){
	key := StrSplit(filePath,"`\").Pop()
	key :="." StrSplit(key,".")[1]
	return key
}

