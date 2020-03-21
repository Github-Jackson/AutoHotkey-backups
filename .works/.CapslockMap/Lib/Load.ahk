Load_Main(map){
	Hotkey, If, Active()
	for k,v in map
	{
		f:=Func("Send_Main").Bind(v)
		Hotkey, $*%k%,%f%
	}
	Hotkey,If
}
Load_Capslock(map){
	Hotkey, If, GetKeyStatus("Capslock")
	for k,v in map
	{
		f:=Func("Send").Bind(v)
		Hotkey,%k%,%f%
	}
	Hotkey,If
}
Load_RAlt(map){
	Hotkey, If, GetKeyStatus("RAlt")
	for k,v in map
	{
		f:=Func("Send").Bind(v)
		Hotkey,$*%k%,%f%
	}
	Hotkey, If
}

Send(keys){
	main.state:=1
	Send %Keys%
}
Send_Main(keys){
	main.state:=1
	Send(keys)
}
Send_Blind(keys){
	Send {Blind}%keys%
}
#If GetKeyStatus("RAlt")
#If Active()
#If
Active(){
	return main.active or GetKeyStatus("Capslock")
}