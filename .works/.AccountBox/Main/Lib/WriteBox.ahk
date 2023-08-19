WriteBox(object:="",filepath:="Box.ahk"){
	if(!object)object:=Box
	file:=FileOpen(filepath,"w")
	line=$:={
	queue:=[]
	for k,v in object{
		if(IsObject(v)){
			queue.push(k)
			continue
		}
		line=%line%"%k%":"%v%",
	}
	line=%line%}
	line:=StrReplace(line,",}","}")
	file.WriteLine(line)
	for k,v in queue{
		WriteLine(file,object,[v])
	}
	file.close()
}

WriteLine(file,box,keys){
	action:=box
	inn:=[]
	ectype:=[]
	line=$[
	for k,v in keys{
		line=%line%"%v%",
		action:=action[v ""]
		ectype.push(v)
	}
	line=%line%]:={
	line:=StrReplace(line,",]","]")
	for k,v in action{
		if(IsObject(v)){
			inn.push(k)
			continue
		}
		line=%line%"%k%":"%v%",
	}
	line.="}"
	line:=StrReplace(line,",}","}")
	file.WriteLine(line)
	ectype.push("")
	for k,v in inn{
		ectype[ectype.length()]:=v
		WriteLine(file,box,ectype)
		file.WriteLine()
	}
}




