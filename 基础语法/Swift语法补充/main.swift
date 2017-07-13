//
//  main.swift
//  Swift语法补充
//
//  Created by 韩俊强 on 2017/7/12.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 断言: 当程序发生异常时, 如果希望找到出错位置并打印一个消息, 就可以使用断言, 即通过一个全局的函数 assert
 assert 接受一个闭包作为其第一个参数, 第二个参数是一个字符串; 假如第一个闭包返回的是一个false, 那么这个字符串就会被打印到中控制台上, assert格式如下:
 */
//assert(()-> Bool, "Message")

// 如示例, 我们希望某个函数不为空, 如果为空则会使程序崩溃, 这时就可以使用assert, 当这个函数为空的时候, 会把后面的字符串打印到中控台, 这样就知道哪里出现问题了:
//assert(someFunction() != nil, "someFunction 返回了空值! ")



/*
 precondition: 它和 assert 的格式类型, 也是动态的, 它会造成程序的提前终止并抛出错误信息; 前面讲过, Swift 数组的下标操作可能造成越界, 使用扩展的方式向其中怎敢爱一个方法来判断下标是否越界:
 */
extension Array {
    func ifOutBounds(index:Int){
        precondition((0..<endIndex).contains(index), "数组越界")
        print("继续执行")
    }
}
[1,2,3].ifOutBounds(index: 2) // index == 3 会被提前终止


//最后要注意: precondition 在一般代码中并不多见, 因为它是动态的, 只会在程序运行时进行检查; 适用于那些无法在编译器确定的风险情况;


