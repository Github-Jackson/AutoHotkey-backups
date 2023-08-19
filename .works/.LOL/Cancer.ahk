#SingleInstance Force
#Include <Application>
#InstallMouseHook
global Screen:={}
;width:1200,height:50
Screen.Left:=A_ScreenWidth*Application.Config.Screen.Left
Screen.Right:=A_ScreenWidth*Application.Config.Screen.Right
Screen.Height:=A_ScreenHeight*(1-Application.Config.Screen.Height)

global troop:={},CheckBox:=1,fn:=Func("UpdateTarget"),log:=""

Gui,Margin,,-1
Gui,+AlwaysOnTop +Resize ToolWindow +HwndScriptHwnd
for k,v in IniReader("Troop.ini")[Application.Config.Config.Version]{
	troop[k]:=StrSplit(v,",")
	Gui Add, CheckBox,v%k% x20 w120 h25 ,% k
	gofn:=fn.Bind(k)
	GuiControl,+g,%k%,%gofn%
	
}
Gui Add,Text,vTip x20 h800 w150 cRed
Gui Show, w170 h600 x0 y60, 目标阵容
WinSet,Transparent,% Application.Config.Config.Transparent,ahk_id %ScriptHwnd%
CoordMode,Pixel,Screen
CoordMode,Mouse,Screen

#UseHook
$main:=new Cancer()
for k,v in StrSplit(Application.Config.Config.Hotkey,",")
	Hotkey(v,$main)
UpdateTarget(key,hwnd){
	GuiControlGet,out,,%hwnd%
	if(out)
		Cancer.target[key]:=troop[key]
	else
		Cancer.target[key]:=""
}

Class Cancer{
	static target:={}
	Call(){
		count:=0,log:="`n"
		Sleep,% Application.Config.Config.Delay
		for k,v in this.target
			for i,item in v
				loop 
					if(!this.Click(ImageSearch(item ".png"),i)||++count>7)
						break
		GuiControl,,Tip,% log
	}
	Click(pos,i){
		if(!pos)
			return 0
		x:=pos.x,y:=pos.y
		Click,%x%,%y%
		return 1
	}
}



ImageSearch(img){
	if(!FileExist(img)){
		log.="文件缺失: " img "`n"
		GuiControl,,Tip,% log
		return
	}
	ImageSearch,x,y,% Screen.Left,% Screen.Height,% Screen.Right,% A_ScreenHeight,% Application.Config.Config.Scope " " img
	if(x){
		log.="搜索成功: " StrReplace(img,".png") "`n"
		GuiControl,,Tip,% log
		return {x:x+30,y:y+10}
	}
}