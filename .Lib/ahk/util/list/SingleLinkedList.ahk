Class SingleLinkedList{
    __New(){
        this._frist:=new this.Node("")
    }

    first{
        get{
            return this._frist.next.data
        }
        set{
            return this._frist.next.data:=value
        }
    }

    Push(e){
        
    }
    Link(){

    }

    Class Node{
        __New(data,next:=""){
            this.data:=data
            this.next:=next
        }
    }
    Class Enum{

    }
}