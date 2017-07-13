//
//  main.swift
//  协议
//
//  Created by 韩俊强 on 2017/6/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/** 协议 **/

//// 1.定义协议

//格式:协议的定义方式与类, 结构体, 枚举的定义非常相似
protocol SomeProtocol {
    //协议方法
}

//协议可以继承一个或者多个协议
protocol SomeProtocol2:SomeProtocol {
    //协议定义
}

//结构体实现协议
struct SomeStrure : SomeProtocol,SomeProtocol2 {
    //结构体定义
}

//类实现协议和继承父类, 协议一般卸载父类后面
class SomeSuperclass {
    //父类定义
}
class SomeClass: SomeSuperclass, SomeProtocol{
    
    //子类定义
}

//// 2.协议的属性
// 协议不指定是否该属性应该是一个存储属性或者计算属性, 它只指定所需的名称和读写类型. 属性要求总是声明为变量属性, 用var关键字做前缀.

protocol ClassProtocol {
    static var present:Bool { get set}    //要求该属性可读可写,并且是静态的
    var subject:String { get }            //要求改属性可读
    var stName:String { get set}          //要求该属性可读可写
}

//定义类来实现协议
class MyClass : ClassProtocol {
    static var present = false     //如果没有实现协议的属性要求,会直接报错
    var subject = "Swift Protocol" //该属性设置为可读可写, 也是满足协议的要求
    var stName: String = "Class"
    
    func attendance() -> String {
        return "The \(self.stName) has secured 99% attendance"
    }
    
    func markSScured() -> String {
        return "\(self.stName) has \(self.subject)"
    }
}
//创建对象
var classa = MyClass()
print(classa.attendance())  // The Class has secured 99% attendance
print(classa.markSScured()) // Class has Swift Protocol

//// 3.协议普通方法实现
// 协议可以要求制定实例方法和类型方法被一致的类型实现. 这些方法被写为定义协议的一部分, 跟普通实例和类型方法完全一样, 但是没有大括号或方法体. 可变参数是允许的, 普通方法也遵循同样的规则, 不过不允许给协议方法参数指定默认值.

//定义协议, 指定方法要求
protocol RandomNumberGenerator {
    func random() -> Double  //实现该协议, 需要实现该方法
}

class LinerCongruentialGenerator : RandomNumberGenerator {
    var lastRandom = 45.0
    let m = 149998.0
    let a = 24489.0
    let c = 29879.0
    
    // 实现协议方法
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m)) //truncatingRemainder 替代旧方法 %
        return lastRandom / m
    }
}

let generator = LinerCongruentialGenerator()
print("随机数:\(generator.random())")    //随机数:0.545993946585954
print("再来随机数:\(generator.random())") //再来随机数:0.0449539327191029


//// 4.协议中实现构造函数
// 协议SomeProtocol中不仅可以声明方法/属性/下标, 还可以声明构造器, 但在Swift中, 除了某些特殊情况下, 构造器是不被子类继承的, 所以SomeClass中虽然能保证定义了协议要求的构造器, 但不能保证SomeClass的子类中也定义了协议要求的构造器. 所以我们需要在实现协议要求的构造器时, 使用required关键字确保SomeClass的子类也得实现这个构造器.

protocol TcpProtocol {
    // 初始化构造器要求
    init(aprot:Int)
}

class TcpClass: TcpProtocol {
    var aprot: Int
    required init(aprot: Int) {
        self.aprot = aprot
    }
}

var tcp = TcpClass(aprot: 20)
print(tcp.aprot)


// 例子: 举个简单的例子，有一只猫和狗，他们都属于宠物，用类去实现就要这样操作，定义一个父类叫做宠物，里面有喂食和玩耍两个方法，猫和狗都继承与宠物这个父类。这样操作自然可以实现，但是要知道，猫和狗不都是宠物，这里把宠物定义成父类就不是很合适，这里应该把宠物定义成协议就相对合适很多啦

//// 5.使用实例
// 宠物猫和宠物狗的例子，利用协议可以这样实现，声名个动物的父类，然后让猫和狗class都继承与动物class。在定义一个宠物的属性，里面有玩耍和喂食两个方法，让猫和狗都继承与宠物协议，实现代码如下：

protocol Pet {
    func payWith()
    func fed(food:String)
}

class Animal {
    var name:String = ""
    var birthPlace:String = ""
    init(name:String, birthPlace:String) {
        self.name = name
        self.birthPlace = birthPlace
    }
}

class Dog: Animal, Pet {
    func payWith() {
        print("🐶在玩耍")
    }

    func fed(food: String) {
        if food == "骨头" {
            print("🐶Happy")
        }else{
            print("🐶Sad")
        }
     }
}

class Cat: Animal, Pet {
    func fed(food: String) {
        if food == "鱼" {
            print("🐱Happy")
        }else{
            print("🐱Sad")
        }
    }
    func payWith() {
        print("🐱在玩耍")
    }
}

let dog = Dog(name: "狗狗小累累", birthPlace: "河南")
dog.payWith()
dog.fed(food: "骨头")

let cat = Cat(name: "猫猫小可爱", birthPlace: "北京")
cat.payWith()
cat.fed(food: "鱼")

//注意：同时继承父类和协议的时候，父类要写在前面


//// 5.typealias与协议结合的使用
// typealias的作用是给类型进行扩展, 它与协议放在一起使用会碰撞出不一样的火花

//1.typealias 的基本使用

//extension Double {
//    var km : Length {
//        return self * 1000.0
//    }
//    var m : Length {
//        return self;
//    }
//    var cm : Length {
//        return self / 100
//    }
//}
//
//let runDistance:Length = 3.14.km // 3140

//2.typealias结合协议使用
//定义一个协议, 代表重量, 但是它的类型要根据继承与它的类或结构体定义, 协议代码如下:

protocol WeightCalculble {
    
    associatedtype WeightType
    
    var weight:WeightType{get}
    
}

// 这里weight属性的类型就抛出来了, 便于继承协议的类或结构体来定义

class iPhone7 : WeightCalculble {
    
    typealias WeightType = Double
    
    var weight:WeightType{
        
        return 0.1314
    }
}

class ship: WeightCalculble {
    
    typealias WeightType = Int
    
    let weight: WeightType
    
    init(weight: Int) {
        
        self.weight = weight
    }
}

//这里定义了两个类，一个是iPhone7，一个是Ship，都继承于协议WeightCalculable，但是weight的类型大不相同。iPhone7的weight属性是Double类型的，Ship的weight属性是Int类型的。

// 最后这段代码，用于扩充Int类型，自定义了t字段来代表吨

extension Int {
    
    typealias Weight = Int
    
    var t:Weight {
        
        return 1_000 * self
    }
}


//// 6.协同协议的使用
// 我们还可以继承于系统协议来定义系统方法，这里简单极少介绍三种常用系统协议
// 1、Equatable协议用于自定义”==”来实现操作

class Person:Equatable , Comparable, CustomStringConvertible {
    /// Returns a Boolean value indicating whether the value of the first
    /// argument is less than that of the second argument.
    ///
    /// This function is the only requirement of the `Comparable` protocol. The
    /// remainder of the relational operator functions are implemented by the
    /// standard library for any type that conforms to `Comparable`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func <(lhs: Person, rhs: Person) -> Bool {
        return false
    }
    
    var name:String
    var age:Int
    
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    
    var description: String {
        return "name" + ",age:" + String(age)
    }
}
func ==(left: Person, right: Person) ->Bool {
    
    return left.name == right.name && left.age == right.age
}

let personA = Person(name: "a", age: 10)
let personB = Person(name: "b", age: 20)
personA == personB
personA != personB
//注意：func == 方法要紧跟协议下面写，否则编译器会报错


// 2、Comparable协议用于自定义比较符号来使用的
func <(left: Person, right: Person) -> Bool {
    
    return left.age < right.age
}
let personC = Person(name:"c",age:9)
let personD = Person(name:"d",age:10)
//注意，在定义比较符号后，很多方法也会同时修改便于我们使用，例如排序方法

let person1 = Person(name:"a",age:9)

let person2 = Person(name:"a",age:12)

let person3 = Person(name:"a",age:11)

var  arrPerson = [person1,person2,person3]

arrPerson.sort()  //此时arrPerson ： [person1,person3,person2]


// 3.CustomStringConvertible协议用于自定义打印

class PersonClass2:CustomStringConvertible {
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    static func ==(lhs: PersonClass2, rhs: PersonClass2) -> Bool {
        return false
    }
    var name:String
    var age:Int
    
    init(name:String,age:Int) {
        
        self.name = name
        self.age = age
    }
    var description: String {
        
        return"name: "+name + ",age:" + String(age)
    }
}
//重写description 讲自定义打印格式return出来

print(person1) //name: ,age:9

////协议是swift非常重要的一部分,苹果甚至为了它单独出来——–面向协议编程,利用协议的优点和灵活性可以使整个项目结构更加灵活,拥有更加易于延展的架构.

//// 协议的扩展补充  以下一般不会这么写, 因为没什么意义
protocol ShareString {
    func methodForOverride()
    func methodWithoutOverride()
}

extension ShareString {
    func methodForOverride(){
        print("😋")
    }
    func methodWithoutOverride(){
        print("======")
        methodForOverride()
        print("------")
    }
}
extension String:ShareString {
    func methodForOverride() {
        print(self)
    }
}

let hello:ShareString = "hello"
hello.methodForOverride()
hello.methodWithoutOverride()


