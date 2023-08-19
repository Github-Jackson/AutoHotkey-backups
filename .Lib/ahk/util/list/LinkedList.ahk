Class LinkedList{
    __New(){
        this.size:=0
        this.first:=""
        this.last:=""
    }
    _NewEnum(){
        return new this.Enum(this)
    }
    last{
        get{
            return this._last.data
        }
        set{
            if(this._last)
                return this._last.data:=value
            return this.Push(value)
        }
    }
    first{
        get{
            return this._frist.data
        }set{
            if(this._first)
                return this._frist.data:=value
            return this.Push(value)
        }
    }
    size{
        get{
            return this._size
        }
    }
    Count(){

    }

    Push(e){
        if(this.size==0)
            this._last:=this._first:=new this.Node(e)
        else{
            this._last.next:=new this.Node(e,this.last)
            this._last:=this._last.next
        }
        this._size++
        return this._last.data
    }
    Add(i,v){
        
    }

    Class Node{
        __New(data,prev:="",next:=""){
            this.data:=data
            this.prev:=prev
            this.next:=next
        }
        __delete(){
            ;MsgBox % "delete : " this.data
        }
    }
    Class Enum{
        __New(list){
            this.node:=list.first
            this.size:=0
        }
        Next(ByRef index,ByRef value){
            if(this.node!=""){
                index:=++this.size
                value:=this.node.data
                this.node:=this.node.next
                return 1
            }
        }
    }

}