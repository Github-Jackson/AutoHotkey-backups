;Rename Desktop.ini

FileSelectFolder,targetFolder,D:,,选择目标文件夹

Loop,Files,%targetFolder%\*,D
{
	ReDesktopIni(A_LoopFileName,A_LoopFileLongPath)
}

ReDesktopIni(name,path){
	IniWrite,%name%,%path%\desktop.ini,.ShellClassInfo,LocalizedResourceName
}
