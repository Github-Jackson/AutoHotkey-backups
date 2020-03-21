#Include <System>
#Include <File>
#Include <Script>
Class FileTool{
	static ext:={}
	GetExe(filepath){
		file:=SplitPath(filepath)
		if(StringLower(file.ext)=="lnk")
			return FileTool.GetExe(FileGetShortcut(filepath).target)
		if(StringLower(file.ext)=="exe")
			return filepath
		return FileTool.HasKey(file.ext)?FileTool[file.ext]:FileTool.GetTarget(file.ext)
	}
	GetTarget(ext){
		cmd:=RegRead("HKCR\" RegRead("HKCR\." ext) "\shell\open\command")
		if(index:=InStr(cmd,""""))
			cmd:=SubStr(cmd,index+1,InStr(cmd,"""",,index+1)-2)
		else
			cmd:=SubStr(cmd,1,InStr(cmd," ")-1)
		return FileTool[ext]:=EnvDeref(cmd)
	}
	GetTitle(filepath){
		lindex:=InStr(filepath,"{"),rindex:=InStr(filepath,"}")
		title:=SubStr(filepath,lindex+1,rindex?rindex-lindex-1:0)
		return title " " @(FileTool.GetExe(filepath))
	}
}