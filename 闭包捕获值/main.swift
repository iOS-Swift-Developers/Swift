//
//  main.swift
//  闭包捕获值
//
//  Created by 韩俊强 on 2017/6/12.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

func getIncFunc(inc: Int) -> (Int) -> Int
{
    var max = 10
    func incFunc(x: Int) ->Int{
        print("incFunc函数结束")
        max += 1
        return max + x
    }
    // 当执行到这一句时inc参数就应该被释放了, 但是由于在内部函数中使用到了它, 所以它被捕获了;
    // 同理, 当执行完这一句时max变量就被释放了, 但是由于在内部函数中使用到了它, 所以它被捕获了.
    print("getIncFunc函数结束")
    return incFunc
}

//当捕获的值回合与之对应的方法绑定在一起, 同意个方法中的变量会被绑定到不同的方法中

let incFunc = getIncFunc(inc: 5)
print(incFunc(5))
print(incFunc(5))
let incFunc2 = getIncFunc(inc: 5)
print(incFunc2(5))



