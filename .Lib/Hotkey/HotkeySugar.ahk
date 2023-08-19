Hotkey(key,fn:="",option:=""){
	if(option=="" and fn=="")
		fn:="Off"
	Hotkey,%key%,%fn%,%option%
}
HotkeyIf(fn:=""){
	if(IsObject(fn))
		Hotkey,if,% fn
	else if (fn=="")
		Hotkey,if
	else
		HotkeyIf(new HotkeyDecorator(fn))
}