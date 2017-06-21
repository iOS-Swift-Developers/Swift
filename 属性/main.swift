//
//  main.swift
//  属性
//
//  Created by 韩俊强 on 2017/6/12.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 存储属性
 其实Swift中的存储属性就是以前学习OC中的普通属性, 在结构体或者类中定义的属性, 默认就是存储属性
 */

struct Person {
    var name: String
    var age: Int
}
var p = Person(name: "xiaohange", age: 26)
print("name = \(p.name) age = \(p.age)")

p.name = "HaRi"
p.age = 28
print("name = \(p.name) age = \(p.age)")

/*
 常量存储属性
 常量存储属性只能在定义时或构造时修改, 构造好一个对象之后不能对常量存储属性进行修改
 */

struct Person2 {
    var name: String
    var age : Int
    let card: String // 常量 ID Card
}
var p2 = Person2(name: "HaRi", age: 24, card: "1234")
p2.name = "helloName"
p2.age = 25
// 构造好对象以后不能修改常量存储属性
//p2.card = "333" Error!

/*
 结构体和类常量与存储属性的关系
 结构体和枚举是值类型
 类是引用类型
 */

struct Person3 {
    var name: String
    var age : Int
}
let p3 = Person3(name: "hjq", age: 26)
// 1.因为结构体是值类型, 所以不能修改结构体常量中的属性;
// 2.不能修改结构体 / 枚举常量对象中的值, 因为他指向的对象是一个常量;
//p3.name = "hiName"  Error!
//p3 = Person3(name: "hiName", age: 27)   Error!


class Person4 {
    var name: String = ""
    var age: Int = 20
}
let p4:Person4 = Person4()
// 可以修改类中常量中的值, 因为他们指向的对象不是一个常量
p4.name = "hello xiaohange"
// 不可以修改类常量的指向
//p4 = Person4()  Error!


/*
 延迟存储属性
 Swift语言中所有的存储属性必须有初始值, 也就是当构造完一个对象后, 对象中所有的存储属性必须有初始值, 但是也有例外, 其中延迟存储属性可以将属性的初始化推迟到该属性第一次被调用的时候
 懒加载应用场景:
 1.有可能不会用到
 2.依赖于其它值
 */

class Line {
    var start:Double = 0.0
    var end:Double = 0.0
    
    // 1.如果不是 lazy属性, 定义的时候对象还没有初始化, 所以不能访问self;
    // 2.如果加上 lazy, 代表使用时才会加载, 也就是使用到length属性时才会调用self;
    // 3.而访问一个类的属性必须通过对象方法, 所以访问时对象已经初始化完成了, 可以使用self
    lazy var length: Double = self.getLength()
    
    // 通过闭包懒加载
    lazy var container: Array<AnyObject> = {
        print("懒加载")
        
        var arrrM:Array<Int> = []
//        return self.end - self.start   Error!
        return arrrM as [AnyObject]
    }()
    
    func getLength() -> Double
    {
        print("懒加载")
        return end - start
    }
}
var line = Line()
line.end = 200.0
//print(line.length())  Error!
print("创建对象完毕")
print(line.length)
var arrM = line.container
arrM.append("1" as AnyObject)
arrM.append(5 as AnyObject)
print(arrM)    // [1, 2, 3, 1, 5]


/*
 计算属性
 1.Swift中的计算属性不直接存储值, 跟存储属性不同, 没有任何的"后端存储与之对应"
 2.计算属性用于计算, 可以实现setter和getter这两种计算方法
 3.枚举不可以有存储属性, 但是允许有计算属性
 setter 对象.属性 = 值
 getter var value = 对象.属性
 */

struct Rect {
    var origion:(x: Double, y: Double) = (0, 0)
    var size:(w: Double, h: Double) = (0, 0)
    
    // 由于center的值是通过起点和宽高计算出来的, 所以没有必要提供一个存储属性
    var center:(x: Double, y:Double){
        
        get{
            return (origion.x + size.w/2, origion.y + size.h/2)
        }
        
        set{
            // 注意: 计算属性不具备存储功能, 所以不能给计算属性赋值, 如果赋值会发生运行时错误
            // 注意: setter可以自己传递一个参数, 也可以使用系统默认的参数newValue
            // 如果要使用系统自带的参数, 必须删除自定义参数
            origion.x = newValue.x - size.w / 2
            origion.y = newValue.y - size.h / 2
        }
    }
}
var r = Rect()
r.origion = (0, 0)
r.size = (100, 100)
//r.center = ((r.origion.x + r.size.w) / 2, (r.origion.y + r.size.h) / 2)    // 可以直接在结构体中获得, 此处可以省略
print("center.x = \(r.center.x) , center.y = \(r.center.y)")
r.center = (100, 100)
print("origion.x = \(r.origion.x) , origion.y = \(r.origion.y)")
print("center.x = \(r.center.x) , center.y = \(r.center.y)")


/*
 只读计算属性
 对应OC中的readonly属性, 所谓的只读属性就是只提供了getter方法, 没有提供setter方法
 */
class Line2 {
    var start: Double = 0.0
    var end: Double = 0.0
    
    // 只读属性, 只读属性必须是变量var, 不能是常量let
    // 比如想获取length, 只能通过计算获得, 而不需要外界设置, 可以设置为只读计算属性
    var leghth: Double {
        //只读属性可以省略get{}
//        get{
            return end - start
//        }
    }
}
var line2 = Line()
line2.end = 100
print(line2.length)

/*
 属性观察器,类似OC中的KVO, 可以用于监听属性什么时候被修改, 只有属性被修改才会调用
 有两种属性观察器:
 1.willSet, 在设置新值之前调用
 2.didSet, 在设置新值之后调用
 可以直接为除计算属性和lazy属性之外的存储属性添加属性观察器, 但是可以在继承类中为父类的计算属性提供属性观察器
 因为在计算属性中也可以监听到属性的改变, 所以给计算属性添加属性观察器没有任何意义
 */

class Line3{
    var start: Double = 0.0{
        willSet{
            print("willSet newValue = \(newValue)")
        }
        didSet{
            print("didSet oldValue = \(oldValue)")
        }
    }
    
    var end: Double = 0.0
}
var l = Line3()
l.start = 10.0


/*
 类属性
 在结构体和枚举中用static
 在类中使用class, 并且类中不允许将存储属性设置为类属性
 */
struct Person5 {
    //普通的属性是每个对象的一份
    var name: String = "hjq"
    //类属性是素有对象共用一份
    static var gender: String = "Man"
    static var age: Int{
        return 25
    }
    func show()
    {
        print("gender = \(Person5.gender) name = \(name)")
    }
}
var p5 = Person5()
//print("gender = \(p5.gender)")  Error!

Person5.gender = "women"

print("p5 gender = \(Person5.gender)")

var p6 = Person5()
// 类属性是所有对象共用一份
print("p6 gender = \(Person5.gender)")
p5.show()

//可以将计算属性设置为类属性
print("age = \(Person5.age)")


class Person6 {
    //普通的属性是每个对象一份
    var name: String = "hjq"
    //类中不允许将存储属性定义为类属性
//    class var gender: String = "man"   Error!
    //类中只能将计算属性定义为类属性
    class var age: Int {
        return 26
    }
    func show() {
        print("age = \(Person6.age)")
    }
}
var p7 = Person6()
print("p7 age = \(Person6.age)")
p7.show()

