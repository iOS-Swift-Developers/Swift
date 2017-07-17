//
//  main.swift
//  方法
//
//  Created by 韩俊强 on 2017/6/13.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 隶属于每一个类或结构体的函数称之为方法:
 方法分为类方法和实例方法, 对应OC中的+ - 方法
 实例方法:实例方法一定是通过对象来调用的, 实例方法隶属于某一个类
 */

class Person  {
    var _name: String = "HaRi"
    var _age: Int = 26
    //实例方法一定是通过对象来调用的, 实例方法隶属于某一个类
    //如果不希望某个参数作为外部参数使用, 可以在参数前面加上 _ , 忽略外部参数
    func setName(name: String, _ age: Int)
    {
        _name = name
        _age = age
    }
    func show()
    {
        print("name = \(_name) age = \(_age)")
    }
}
var p = Person()
p.show()

// 由于第一个参数可以通过方法名称指定, 所以默认第一个参数不作为外部参数
//p.setName(name:"xiaoHan", age:100)    Error!
p.setName(name: "hjq", 88)  //正确姿势
p.show()

//func setName(name:String, age:Int){
//func setName(name:String,myAge age:Int){
func setName(name: String, age: Int) {
    
}
// 实例方法和函数的区别在于, 实例方法会自动将除第一个参数以外的其他参数既当做为外部参数又当做内部参数, 而函数需要我们自己指定才会有外部参数, 默认没有
setName(name: "han", age: 30)

/*
 self关键字, Swift中的self和OC中的self基本一样; self指当前对象, self在对象方法中代表当前对象, 但是在类方法中没有self
 */
class Person2 {
    var name: String = "hjq"
    var age: Int = 25
    
    //当参数名称和属性名称一模一样时, 无法区分哪个是参数哪个是属性, 这个时候可以通过self明确的来区分参数和属性
    func setName(name: String, age: Int)
    {
        //默认情况下, _name和_age前面默认有一个self关键字, 因为所有变量都需要先定义再使用, 而setName方法中并没有定义过_name和_age, 而是在属性中定义的, 所以setName中访问的其实是属性, 编译器默认帮我们在前面加了一个self
//        _name = name
//        _age = age
        self.name = name
        self.age = age
    }
    func show()
    {
        print("name = \(name) age = \(age)")
    }
}

/*
 mutating方法
 值类型(结构体和枚举)默认方法是不可以修改属性的, 如果需要修改属性, 需要在方法前加上mutating关键字, 让该方法变为一个改变方法
 */
struct Person3 {
    var name: String = "hjq"
    var age: Int = 24
    //值类型(结构体和枚举)默认方法是不可以修改属性的, 如果需要修改属性, 需要在方法前加上mutating关键字, 让该方法变为一个改变方法
    //注意: 类不需要, 因为类的实例方法默认就可以修改
    mutating func setName(name: String, age: Int)
    {
        self.name = name
        self.age = age
    }
    func show()
    {
        print("name = \(name) age = \(age)")
    }
}
var p3 = Person3()
p3.setName(name: "han", age: 100)
p3.show()


enum LightSwitch {
    case OFF, ON
    mutating func next()
    {
        switch self {
        case .OFF:
            self = .ON
        case .ON:
            self = .OFF
        }
    }
}
var ls:LightSwitch = .OFF
if ls == LightSwitch.OFF
{
    print("off")
}
ls.next()
if ls == LightSwitch.ON
{
    print("on")
}


/*
 类方法:
 和类属性一样通过类名来调用, 类方法通过static关键字(结构体/枚举), class(类)
 类方法中不存在self
 */

struct Person4 {
    var name: String = "HanJunqiang"
    static var card: String = "1234567"
    func show()
    {
        print("name = \(name) card = \(Person4.card)")
    }
    static func staticShow()
    {
        //类方法中没有self
        //静态方法对应OC中的+号方法, 和OC一样在类方法中不能访问非静态属性
        print("card = \(Person4.card)")
    }
}
var p4 = Person4()
p4.show()
Person4.staticShow()



