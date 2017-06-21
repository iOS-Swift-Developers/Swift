//
//  main.swift
//  继承
//
//  Created by 韩俊强 on 2017/6/14.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 继承语法
 继承是面向对象最显著的一个特性, 继承是从已经有的类中派生出新的类
 新的类能够继承已有类的属性和方法, 并能扩展新的能力
 术语: 基类(父类, 超类), 派生类(子类, 继承类)
 语法:
 class 子类: 父类{
 }
 
 继承优点: 代码重用
 继承缺点: 增加程序耦合度, 父类改变会影响子类
 注意:Swift和OC一样没有多继承
 */

class Man {
    var name: String = "hjq"
    var age: Int = 23
    func sleep()
    {
        print("睡觉")
    }
}
//继承Man的子类
class SuperMan: Man {
    var power: Int = 100
    func fly() {
        //子类可以继承父类的属性
        print("飞 \(name) \(age)")
    }
}
var m = Man()
m.sleep()
//父类不可以使用子类的方法
//m.fly()

var sm = SuperMan()
//子类可以继承父类的方法
sm.sleep()
sm.fly()

print("==============================================")

/*
 super关键字:
 
 派生类(子类)中可以通过super关键字来引用父类的属性和方法
 */

class Man2  {
    var name: String = "HaRi"
    var age: Int = 20
    func sleep()
    {
        print("睡吧!")
    }
}

class SuperMan2: Man2 {
    var power: Int = 100
    func eat()
    {
        print("吃饭喽!")
    }
    func fly()
    {
        //子类可以继承父类的属性
        print("飞 \(name) \(age)")
    }
    func eatAndSleep()
    {
        eat()
        //1.如果没有写super, 那么会在当前类中查找, 如果找不到才会再去父类中查找;
        //2.如果写了super, 会直接去父类中查找.
        super.sleep()
    }
}
var sm2 = SuperMan2()
sm2.eatAndSleep()

print("==============================================")

/*
 方法重写: override
 重写父类方法, 必须加上 override 关键字
 */

class Man3 {
    var name: String = "HanJunqiang"
    var age: Int = 24
    func sleep()
    {
        print("睡觉😴")
    }
}
class SuperMan3: Man3 {
    var power: Int = 200
    
    //1.override关键字主要是为了明确表示重写父类方法;
    //2.所以如果要重写父类方法, 必须加上ovrride关键字.
    override func sleep() {
//        sleep()  // Error! 特别注意: 不能这样调用父类方法, 会导致递归!
        //正确姿势
        super.sleep()
        print("子类睡觉😴")
    }
    func eat()
    {
        print("吃饭🍚")
    }
    func fly()
    {
        print("飞 \(name) \(age)")
    }
    func eatAndSleep()
    {
        eat()
        sleep()
    }
}
var sm3 = SuperMan3()
//通过子类调用, 优先调用子类重写的方法
//sm3.sleep()
sm3.eatAndSleep()

print("==============================================")

/*
 重写属性
 无论是存储属性还是计算属性, 都只能重写为计算属性
 */

class Man4 {
    var name: String = "hjq995" //存储属性
    var age: Int{ //计算属性
        get{
            return 30
        }
        set{
            print("man new age \(newValue)")
        }
    }
    func sleep()
    {
        print("睡觉")
    }
}
class SuperMan4: Man4 {
    var power: Int = 300
    
    //1.可以将父类的存储属性重写为计算属性;
    //2.但不可以将父类的存储属性又重写为存储属性, 因为这样重写没有意义.
    override var name: String{
        get{
            return "han"
        }
        set{
            print("SuperMan new name \(newValue)")
        }
    }
    //可以将父类的计算属性重写为计算属性, 同样不能重写为存储属性
    override var age: Int{ //计算属性
        get{
            return 20
        }
        set{
            print("SuprMan new age \(newValue)")
        }
    }
}

let sm4 = SuperMan4()
//通过子类对象来调用重写的属性或者方法, 肯定会调用子类中重写的版本
sm4.name = "Hello!!!!"
sm4.age = 60

print("==============================================")


/*
 重写属性的限制
 1.读写计算属性/存储属性, 是否可以重写为只读属性? (权限变小)不可以
 2.只读计算属性, 是否可以在重写时重写为读写计算属性? (权限变大)可以
 */
class Man5 {
    var name: String = "hjq" //存储属性
    var age: Int{
        get{
            return 30
        }
        set{
            print("man new age \(newValue)")
        }
    }
    func sleep()
    {
        print("睡觉")
    }
}
class SuperMan5: Man5 {
    var power: Int = 200
    override var name: String{
        get{
            return "jq"
        }
        set{
            print("SuperMan new name \(newValue)")
        }
    }
    override var age: Int{ //计算属性
        get{
            return 30
        }
        set{
            print("SuperMan new age \(newValue)")
        }
    }
}

print("==============================================")


/*
 重写属性观察器
 只能给非 lazy 属性的变量存储属性设定属性观察器,
 不能给计算属性设置属性观察器, 给计算属性设置属性观察起没有任何意义
 属性观察器限制:
 1.不能在子类中重写父类只读的存储属性;
 2.不能给lazy的属性设置属性观察器.
*/

class Man6 {
    var name: String = "hjq"
    var age: Int = 0 { //存储属性
        willSet{
            print("super new \(newValue)")
        }
        didSet{
            print("super old \(oldValue)")
        }
    }
    var height: Double {
        get{
            print("super get")
            return 100.0
        }
        set{
            print("super set")
        }
    }
}
class SuperMan6: Man6 {
    //可以在子类中重写父类的存储属性为属性观察器
    override var name: String {
        willSet{
            print("new \(newValue)")
        }
        didSet{
            print("old \(oldValue)")
        }
    }
    //可以在子类中重写父类的属性观察器
    override var age: Int {
        willSet{
            print("child new \(newValue)")
        }
        didSet{
            print("child old \(oldValue)")
        }
    }
    override var height: Double {
        willSet{
            print("child height willSet")
        }
        didSet{
            print("child height didSet")
        }
    }
}
var m6 = SuperMan6()
m6.age = 50
print(m6.age)
m6.height = 20.0



/*
 利用final关键字防止重写:
 1.final关键字既可以修饰属性, 也可以修饰方法, 并且还可以修饰类;
 2.被final关键字修饰的属性和方法不能被重写;
 3.被final关键字修饰的类不能被继承.
 */

final class Man7 {
    final var name: String = "jq"
    final var age: Int = 0 { //存储属性
        willSet{
            print("super new \(newValue)")
        }
        didSet{
            print("super old \(oldValue)")
        }
    }
    final var height: Double {
        get{
            print("super get")
            return 20.0
        }
        set{
            print("super set")
        }
    }
    final func eat()
    {
        print("吃饭🍚")
    }
}

//class SuperMan7: Man7 {  // Error! 被final关键字修饰的类不能被继承
//    
//}



