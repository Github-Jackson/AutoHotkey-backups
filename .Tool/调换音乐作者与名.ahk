#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

global target 
FileSelectFolder,target,D:\Area.Media\Media.Musics,,"选择目标文件夹"
ReName()

ReName(){
	SetWorkingDir % target
	FileCreateDir, .Invert
	Loop,Files,%target%\*
	{
		name:=StrReplace(A_LoopFileName,"." A_LoopFileExt)
		name:=Invert(name)
		FileMove,%A_LoopFileLongPath%,%A_LoopFileDir%\.Invert\%name%.%A_LoopFileExt%
	}
	FileMove,.Invert\*.*,*.*
	;FileRemoveDir,.Invert
}

Invert(name){
	per:=SubStr(name,1,InStr(name," - ")-1)
	name:=SubStr(name,InStr(name," - ")+3)
	return name " - " per
}

#R::Reload