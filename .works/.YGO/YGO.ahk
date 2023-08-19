#SingleInstance,force

#Include <Windows>
#Include <Hotkey>
#Include <Application>
global Config := Application.Config.Config
global @YGO:=new YGO(win:=new Windows(Config.Match).Window(),config)


Hotkey(Config.Hotkey,new Timer())

Class Timer{
  __New(){
    this.status:=False
  }
  Call(){
    if(this.status){
      @YGO.Stop()
      this.status:=False
    }else{
      @YGO.Initial()
      @YGO.Start(Config.Period)
      this.status:=True
    }
  }
}

Class YGO{
  __New(win,config){
    this.current:=win
    this.pos:=[]
    this.config:=config
    for k,v in this.list{
      pos:=StrSplit(config[v],",")
      pos:=new Point(pos[1],pos[2])
      this.pos.Push(pos)
    }
  }
  list:=["Custom","Begin","Empty","Affirm"]

  Initial(){

  }
  Start(period){
    this.Call()
    SetTimer,%this%, %period%
  }
  Stop(){
    SetTimer,%this%,off
  }

  Click(pos){
    id:=this.current.id
    lparam:=pos.ToMakeLong()
    PostMessage,0x201,1,%lparam%,,ahk_id %id%
    PostMessage,0x202,0,%lparam%,,ahk_id %id%
  }
  Call(){
    for k,v in this.pos{
      this.Click(v)
      Sleep % this.config.Sleep
    }
  }
}
Class Point{
  __New(x,y){
    this.x:=x
    this.y:=y
  }
  ToMakeLong(){
    result:=this.y<<16
    result|=this.x
    Return result
  }
}