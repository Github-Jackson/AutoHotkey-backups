UI(){
	UI_Create()
	UI_Initial()
}
UI_Create(){
	Gui,M:New,,AccountBox
	Gui,M:default
	Gui,M:Add,Edit,vMainkey GUI_Input ym w350,MainKey 
	Gui,M:Add,Edit,vSubKey GUI_Input section w100,SubKey
	Gui,M:Add,Text,ys w1,:
	Gui,M:Add,Edit,vValue ys w223,Value
	Gui,M:-Caption AlwaysOnTop +Owner
}
UI_Initial(){
	UI_HotKey()
}

UI_HotKey(){
	HotKey,#Insert,UI_Toggle
	HotKey,IfWinActive,AccountBox
	HotKey,^w,UI_Hide
	HotKey,Enter,UI_Save
	HotKey,IfWinActive
}

UI_Toggle(){
	if(application.show){
		if(WinActive("AccountBox")){
			UI_Hide()
		}else{
			WinActivate,AccountBox
		}
	}else{
		UI_Show()
	}
}
UI_Input(){
	UI_Submit()
	application.mainBox:=GetBox(MainKey)
	application.subBox:=GetBox(SubKey,application.mainBox)
	if(application.subBox==""){
		application.subBox:=application.mainBox.account
	}
	if(isObject(application.subBox)){
		application.subBox:=application.subBox.account
	}
	GuiControl,M:,Value,% application.subBox
}
UI_Save(){
	UI_Submit()
	keys:=MainKey . "." SubKey
	keys:=StrSplit(keys,".")
	key:=keys.Pop()
	GetBox_Fill(keys)[key]:=Value
	WriteBox()
	GuiControl,M:Focus,SubKey
	Send ^a
}

MGuiEscape(){
	UI_Hide()
}
MGUIClose(){
	UI_Hide()
	return true
}

UI_Show(){
	if WinExist("AccountBox"){
		UI_Create()
		Msgbox % WinExist("AccountBox")
	}
	application.show:=1
	Gui,M:Show,autoSize x1000 y680
}
UI_Submit(){
	Gui,M:Submit,NoHide
}
UI_Hide(){
	application.show:=0
	Gui,M:Hide
}
