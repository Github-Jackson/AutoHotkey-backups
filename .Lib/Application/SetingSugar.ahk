;DetectHiddenWindows,DetectHiddenText
SetBatchLines(e){
	SetBatchLines,% e
}
SetTimer(fn:="",option:="",priority:=0){
	if(fn=="")
		SetTimer,,% option,% priority
	else
		SetTimer,% fn,% option,% priority
}
SetKeyDelay(delay,press,arg*){
	SetKeyDelay,% delay,% press,% arg[1]
}
SetMouseDelay(delay,arg*){
	SetMouseDelay,% delay,% arg[1]
}
SetWinDelay(delay){
	SetWinDelay,% delay
}
SetControlDelay(delay){
	SetControlDelay,% delay
}
SetStoreCapslockMode(onoff){
	SetStoreCapslockMode,% onoff
}
SetDefaultMouseSpeed(speed){
	SetDefaultMouseSpeed,% speed
}
SetTitleMatchMode(mode){
	SetTitleMatchMode,% mode
}

SetSendMode(mode){
	SendMode,% mode
}
SetSendLevel(level){
	SendLevel,% level
}
SetInputLevel(level){
	;#InputLevel,% Application.Congfig.Setting.InputLevel
}


SetCapsLockState(state){
	SetCapsLockState,% state
}
SetNumLockState(state){
	SetNumLockState,% state
}
SetScrollLockState(state){
	SetScrollLockState,% state
}