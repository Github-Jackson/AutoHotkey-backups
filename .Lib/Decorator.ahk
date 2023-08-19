#Include <List>
;装饰器: 保存一个执行队列, 遍历执行Call方法并将逻辑结果返回
Class Decorator extends List{
	__New(params*){
		this._Initial(params)
	}
	_Initial(list){
		this.list:=[]
		this.Push(list*)
		;状态位标识 取2bit, 第一位为默认逻辑值, 第二位为装饰器是否启用
		;默认逻辑值:0<<0, 默认装饰器为启用态:1<<1;
		;this.state:= 0<<0|1<<1 :=2
		this.state:=2
	}
	Call(params*){
		;获取默认逻辑值,若装饰器未启用,则直接返回
		;若装饰器启用,则遍历执行队列中的函数,并对结果做逻辑运算
		;
		;若队列中函数全部执行完毕,则返回默认逻辑值
		;若队列中函数全部执行完毕,且默认逻辑值不为1,则返回逻辑值
		result:=this.state&1
		;判断第二标志位是否为1,不为1则装饰器为禁用状态,停止后续遍历,返回默认结果
		if(!(this.state&2))
			return result
		for k,v in this.list
			if((v.Call()&&1)!=result)
				return !result
		return result
	}
	;state: 装饰器启用状态下,设置默认state决定遍历执行的逻辑运算关系
	;state为1, 则遍历对应队列中的函数,对结果做逻辑与运算
	;state为0, 则遍历对应队列中的函数,对结果做逻辑或运算
	On(state:=0){
		this.state:=state?3:2
		return this
	}
	;state: 装饰器禁用状态下, 装饰器不会遍历队列, 将直接返回默认state
	Off(state:=0){
		this.state:=state?1:0
		return this
	}
	Toggle(){
		this.state^=3
	}
}