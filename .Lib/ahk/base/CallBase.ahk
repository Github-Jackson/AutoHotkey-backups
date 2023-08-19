Class CallBase{
    __Call(name,args*){
        if(name=="")
            return this.Call(args*)
        if(IsObject(name))
            return this.Call(name,args*)
    }
}