#NoEnv
#SingleInstance Off
#NoTrayIcon
DetectHiddenWindows,On

global param:=A_Args[1]
WinGet,list,List,%A_ScriptFullPath%
if(list>1){
    if(param!="")
        PostMessage,10001,%param%,,,ahk_id %list2%
    ExitApp
}
global objWMIService := ComObjGet("winmgmts:\\.\root\wmi")  
if(param!=""){
    UpdateBrightness(param)
    Reload
}
GetBrightness(){
    getItems := objWMIService.ExecQuery("Select * from WmiMonitorBrightness", ComObjMissing(), 48) 
    For objItem in getItems
        brightness := objItem.CurrentBrightness
    return brightness?brightness:0
}
SetBrightness(num){
	num := Max(0, Min(100, num)) ; 不小于0
    setItems := objWMIService.ExecQuery("Select * from WmiMonitorBrightnessMethods", ComObjMissing(), 48)
    For objItem in setItems 
        objItem.WmiSetBrightness(1, num)
    return num
}
OnMessage(10001,"UpdateBrightness")
UpdateBrightness(wParam){
    if(wParam==0)
        CloseScreen()
    SetBrightness(GetBrightness()+wParam)
}
CloseScreen(){
    ;Sleep 300  ; 让用户有机会释放按键 (以防释放它们时再次唤醒显视器).
    ;关闭显示器:
    SendMessage, 0x112, 0xF170, 2,, Program Manager  ; 0x112 是 WM_SYSCOMMAND, 0xF170 是 SC_MONITORPOWER.
    ; 对上面命令的注释: 使用 -1 代替 2 来打开显示器.
    ; 使用 1 代替 2 来激活显示器的节能模式.   
}
