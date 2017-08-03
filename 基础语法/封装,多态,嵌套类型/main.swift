//
//  main.swift
//  封装,多态,嵌套类型
//
//  Created by 韩俊强 on 2017/8/3.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 * 封装: 通常把隐藏属性,方法和方法实现细节的过程称为封装
 
 1.隐藏属性和方法
 使访问控制修饰符将类和其他属性方法封装起来, 常用的有: public, internal, private
 
 public:   从外部模块和本模块都能访问;
 internal: 只有本模块能访问;
 private:  只有本文件可以访问, 本模块的其他文件不能访问;
 */

public class Student {
    public var name : String
    internal var age : Int
    private var score : Int
    
    init(name : String,age : Int,score : Int) {
        self.age = age
        self.name = name
        self.score = score
    }
    
    public func sayHi(){
      print("Hello!")
    }
    
    private func getScore() {
        print("我的分数是: \(score)")
    }
}

let student = Student.init(name: "xiaohange", age: 21, score: 100)
student.sayHi()
//student.getScore() //不能访问


/*
 * 多态: 指允许使用一个父类类型的变量或者常量来引用一个子类类型的对象. 根据被引用子类对象特征的不同, 得到不同的运行结果, 即使用父类的类型来调用子类的方式;
*/

class Animal {
    func say() {
        print("动物叫")
    }
}

class Cat: Animal {
    override func say() {
        print("猫叫")
    }
}

class Dog: Animal {
    override func say() {
        print("够叫")
    }
}

let animal1:Animal = Cat()
let animal2:Animal = Dog()
print(animal1)
print(animal2)
animal1.say()
animal2.say()



/*
 * 嵌套类型: Swift允许在一个类型中嵌套定义另一个类型, 可以在枚举类型, 类和结构体中定义支持嵌套的类型;
*/

struct Car {
    var brand: String?
    var color: Color
    
    enum Color {
        case Red,White,Orange,Green,Gray
    }
    
}
let car = Car(brand: "劳斯莱斯", color: Car.Color.Gray)
print(car.color) // 打印 Gray

