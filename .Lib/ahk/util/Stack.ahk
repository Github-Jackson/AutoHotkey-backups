Class Stack{
    __New(args*){
        args.base:=Stack
        return args
    }

    Peek(){
        return this[this.MaxIndex()]
    }

    IsEmpty(){
        return this.Length()==0
    }
    Size(){
        return this.Length()
    }
    
}