#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;加密
BoxProcess_Encrypt(source,factor,param*){
	return source
}

;解密
BoxProcess_Decode(source,factor,param*){
	return source
}