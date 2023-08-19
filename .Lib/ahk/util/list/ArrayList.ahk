#Include <ahk/util/List>
Class ArrayList{
    __New(args*){
        this.list:=new List(args*)
    }
    __Call(name,args*){
        if(!IsFunc(this[name]))
            return (this.list)[name](args*)
    }
    __Get(key){
        if key is Integer
            return this.list[key]
    }
    __Set(key,value){
        if key is Integer
            return this.list[key]:=value
    }

    Clone(){
        return this
    }
}