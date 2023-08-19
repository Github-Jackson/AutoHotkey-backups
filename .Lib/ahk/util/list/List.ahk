#Include <ahk/util/Array>
Class List extends Array{
    __New(params*){
        this.list:=params
    }
    _NewEnum(){
        return this.list._NewEnum()
    }

    __Call(name, params*){
        if(!IsFunc(this[name]))
            return (this.list)[name](params*)
    }
    __Get(key){
        if key is Integer
            return this.list[key]
    }
    __Set(key,value){
        if key is Integer
            return this.list[key]:=value
    }


    Add(i:="",params*){
        if(index)
            return this.InsertAt(i, params*)
        return this.Push(i,params*)
    }
    Remove(e){
        return this.RemoveAt(this.IndexOf(e))
    }
    RemoveAll(params*){
        index:=new Array()
        for k,v in this{
            for i,e in params{
                if(IsFunc(e.equals)){
                    if(e.equals(v)){
                        index.Shift(k)
                        params.RemoveAt(i)
                        continue
                    }
                }else{
                    if(e==v){
                        index.Shift(k)
                        params.RemoveAt(i)
                        continue
                    }
                }
            }
        }
        Loop % index.Length()
            this.RemoveAt(index.Pop())

    }
    IndexOf(e){
        for k,v in this{
            if(IsFunc(e.equals)){
                if(e.equals(v))
                    return k
            }else{
                if(e==v) 
                    return k
            }
        }
    }
    Clear(params*){
        this.list:=params
        return this
    }
    
    Clone(){
        return new this(this.list*)
    }
}

