//
//  main.swift
//  扩展
//
//  Created by 韩俊强 on 2017/7/11.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 扩展: 就是给一个现存类, 结构体, 枚举或者协议添加新的属性挥着方法的语法, 无需目标源码, 就可以吧想要的代码加到目标上面
 但有一些限制条件需要说明:
 1.不能添加一个已经存在的方法或者属性;
 2.添加的属性不能是存储属性, 只能是计算属性;
 格式:
 extension 某个先有类型{
    //增加新的功能
 }
 */

/// 1.扩展计算属性;
class Transport {
    var scope:String
    init(scope:String) {
        self.scope = scope
    }
}
extension Transport {
    var extProperty:String{
        get{
            return scope
        }
    }
}
var myTrans = Transport(scope: "飞机")
print(myTrans.extProperty)

/// 2.扩展构造器
class Transport1 {
    var price = 30
    var scope:String
    init(scope:String) {
        self.scope = scope
    }
}
extension Transport1 {
    convenience init(price:Int, scope:String) {
        self.init(scope: scope)
        self.price = price
    }
}
var myTra1 = Transport1(price: 55, scope: "大炮") //使用宽展的构造器, 价格为55
var myTra2 = Transport(scope: "轮船") //使用原构造器, 价格属性的值仍然是30

/// 3.扩展方法

//扩展整数类型
extension Int {
    func calculate() -> Int {
        return self * 2
    }
}
var i = 3
print(3.calculate()) // 返回6

//扩展下标
//我们还可以通过扩展下标的方法来增强类的功能, 比如扩展整数类型, 使整数类型可以通过下标返回整数的倍数;
extension Int {
    subscript (num: Int) -> Int {
        return self * num
    }
}
var j = 3
print(3[2]) //返回6









