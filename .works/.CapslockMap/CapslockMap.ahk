#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force
#NoTrayIcon
Import("String")

FileInstall,Main.map,Main.map
FileInstall,Capslock.map,Capslock.map
FileInstall,RAlt.map,RAlt.map

global main:={active:0,state:0}
global mainMap:=LoadMap("Main.map")

$main(){
	Load_Main(mainMap)
	Load_RAlt(LoadMap("RAlt.map"))
	Load_Capslock(LoadMap("Capslock.map"))
}
$main()

$*CapsLock Up::
$*RAlt Up::
for k,v in mainMap
{
	if GetKeyState(k,"P")
	{
		main.active:=1
		return
	}
}
if (!main.state)
{
	SetCapsLockState % !GetKeyState("Capslock","T")
}
main.state:=main.active:=0
return
#If GetKeyStatus("Capslock")
^+Space::Suspend
Esc::Reload
#If