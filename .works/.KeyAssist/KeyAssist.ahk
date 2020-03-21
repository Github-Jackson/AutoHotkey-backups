#NoEnv
;#NoTrayIcon
#SingleInstance Force

SetStoreCapslockMode,off
SendMode Input

#Include <KeyMap>
#Include <Application>
;扩展功能
;根据文件夹限定按键映射生效窗体
$main(){
	loop,Files,*.ini,R 
		new KeyMap(new InIReader(A_LoopFilePath,StrReplace(A_LoopFileName,"." A_LoopFileExt)))
	for k,v in KeyMap.Modifier
		v.OnSuccess(new Success(k))
}
Class Success{
	__New(key){
		this.out:=Application.Config.Modifier[SubStr(key,2,StrLen(key)-4)]
	}
	Call(){
		Send % this.out
	}
}
$main()