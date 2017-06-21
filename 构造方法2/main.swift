//
//  main.swift
//  构造方法2
//
//  Created by 韩俊强 on 2017/6/19.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 继承与构造方法:
 指定构造与便利构造器方法
 */

class Person {
    var name:String
    var age:Int
    //指定构造方法都是以init开头
    init(name:String, age:Int)
    {
        self.name = name
        self.age = age
    }
    //1.如果是值类型没问题, 称之为构造器代理;
    //2.但是如果是引用类型报错, 需要在前面加上 convenience关键字;
    //3.被convenience关键字修饰的构造方法称之为便利构造器, 通过调用其他构造方法来初始化;
    //4.反而言之, 便利构造器中一定是调用其他构造方法初始化的, 一定要出现self.init
    convenience init()
    {
        self.init(name: "hjq", age: 26)
    }
    //类可以拥有多个构造方法
    init(name:String)
    {
        self.name = name
        self.age = 0
        //不能再指定构造方法中调用便利构造器方法
        //换言之,指定构造方法中不能出现self.init
//        self.init()
    }
    
    convenience init(age:Int)
    {
        //可以在便利构造器中调用指定构造器
//        self.init(name: "hjq", age: 24)
        self.init()
    }
    // 便利构造器不能和指定构造器同名
    //    convenience init(name:String)
    //    {
    //    }
}


/** 派生类的构造方法 **/

class Man {
    var name:String
    //指定构造方法
    init(name:String)
    {
        self.name = name
    }
    convenience init(){
        self.init(name: "hjq")
    }
}
class SuperMan: Man {
    var age:Int
    
    // 注意:
    // 1.默认情况下构造方法不会被继承
    // 2.基类的存储属性只能通过基类的构造方法初始化
    // 3.初始化存储属性时必须先初始化当前类再初始化父类
    // 4.不能通过便利构造方法初始化父类, 只能通过调用指定构造方法初始化父类
    //指定构造器
    init(age:Int) {
        self.age = age
        super.init(name: "han")
//        super.init()
    }
}

/*
 构造器间的调用规则:
 1.指定构造器必须调用其直接父类的"指定构造器"
 2.便利构造器必须调用同类中的其他便利构造器(指定或者便利)
 3.便利构造器必须最终调用一个指定构造器结束(无论指定还是便利, 最终肯定调用一个指定构造器)
 4.指定构造器总是横向代理(父类)
 5.便利构造器总是横向代理(子类)
 */

class Man2 {
    var name:String
    //指定构造器
    init(name:String) {
        self.name = name
    }
    convenience init(){
        self.init(name: "HaRi")
    }
}
class SuperMan2: Man2 {
    var age:Int
    //指定构造器
    init(age:Int) {
        self.age = age
        super.init(name: "xiaohange")
    }
    convenience init()
    {
        self.init(age: 25)
    }
    convenience  init(name: String, age: Int) {
        //调用子类构造器一定能够初始化所有属性
//        self.init(age: 30)
        //便利构造器中只能通过self.init来初始化, 不能使用 super.init
        //因为调用父类构造器不一定完全初始化所有属性(子类持有)
//        super.init(name: "han")
        self.init()
    }
}

/*
 两段式构造----构造过程可以划分为两个阶段:
 1.确保当前类和父类所有存储属性都被初始化;
 2.做一些其他初始化操作.
 好处:
 1.可以防止属性在被初始化前访问;
 2.可以防止属性被其他另外一个构造器意外赋值.
 注意:
 构造器的初始化永远是在所有类的第一阶段初始化完毕后才会开始第二阶段.
 
 编译器安全检查:
 1.必须先初始化子类特有属性, 再向上代理父类指定构造方法初始化父类属性;
 2.只能在调用完父类指定构造器后才能访问父类属性;
 3.在便利构造器中, 必须先调用通类其他构造方法后才能访问属性;
 4.第一阶段完成前不能访问父类属性, 也不能引用 self 和调用任何实例方法
 */

class Man3 {
    var name:String
    //指定构造方法
    init(name:String) {
        self.name = name
    }
    //便利构造方法
    convenience init(){
        self.init(name: "hello world")
    }
}

class SuperMan3: Man3 {
    var age:Int
    init(age:Int) {
        print("SuperMan第一阶段开始")
        //对子类引入的属性初始化
        self.age = age
        
        //代码会报错, 因为调用self.name之前还没有对父类的name进行初始化
        //即便在这个地方修改, 也会被后面的初始化语句覆盖
//        if age > 30 {
//            self.name = "hjq"
//        }
        //对父类引入的属性进行初始化
        super.init(name: "han")
        
        print("SuperMan第二阶段开始")
        if age > 30 {
            self.name = "hello xiaohange"
        }
    }
}
class MonkeyMan: SuperMan3 {
    var height:Double
    init(height:Double) {
        print("MokeyMan第一阶段开始")
        //对子类引入的属性初始化
        self.height = 100.0
        //对父类引入的属性进行初始化
        super.init(age: 40)
        
        print("MokeyMan第二阶段开始")
        if height < 110.0 {
            self.age = 40
        }
    }
}
var m = MonkeyMan(height: 31)


/** 重写指定构造方法:子类的构造方法和父类的一模一样 **/
class Man4 {
    var name:String
    init(name:String) {
        self.name = name
    }
}
class SuperMan4: Man4 {
    var age:Int
    init() {
        self.age = 25
        super.init(name: "xiaohange")
    }
    
    //将父类的指定构造器重写成一个便利构造器, 必须加上override关键字, 表示重写父类方法
    convenience override init(name: String) {
        self.init(name: name)
        self.age = 50
    }
}


/** 便利构造方法不存在重写 **/
class Man5 {
    var name:String
    init(name:String) {
        self.name = name
    }
    convenience init(){
        self.init(name:"hello")
    }
}

class SuperMan5: Man5 {
    var age:Int
    init(age:Int) {
        self.age = age
        super.init(name: "hi")
    }
    //1.Swift中便利构造方法不存在重写, 如果加上override关键字, 系统会去查找父类中有没有和便利构造方法一样的指定构造方法, 有旧不报错, 没有就报错
    //2.为什么便利构造器不能重写呢? 因为便利构造器只能横向代理, 只能调用当前类的其它构造方法或指定方法, 不可能调用super. 所以不存在重写
    //3.也就是说子类的便利构造方法不能直接访问父类的便利构造方法, 所以不存在重写的概念
    convenience init(){
        self.init(age: 30)
    }
}
//早期版本中如果字符类中有同名便利构造器会报错, 现在则不会.
var sm = SuperMan5()
print("name = \(sm.name)  age = \(sm.age)")



/*
 构造方法的自动继承:
 1.如果子类中没有定义构造器, 且子类所有的存储属性都有缺省值, 会继承父类中所有的构造方法(包括便利构造器);
 2.如果子类中只是重写所有的指定构造器, 不管子类中的存储属性是否有缺省值, 都不会继承父类的其他构造方法;
 3.如果子类重写了父类中的指定构造器, 不管子类中的存储属性是否有缺省值, 都会同时继承父类中的所有便利方法.
 */
class Person6 {
    var name:String
    var age:Int
    init(name:String, age:Int) {
        self.name = name
        self.age = age
    }
    init(name:String) {
        self.name = name
        self.age = 0
    }
    convenience init()
    {
        self.init(name: "HaRi")
    }
}
class SuperMan6: Person6 {
    var height:Double
    init(height:Double) {
        self.height = height
        super.init(name: "han", age: 25)
    }
    override init(name: String, age: Int) {
        self.height = 178.0
        super.init(name: name, age: age)
    }
    override init(name: String) {
        self.height = 178.0
        super.init(name: name)
    }
}
// 如果子类中没有定义任何构造器, 且子类中所有的存储属性都有缺省值, 会继承父类中所有的构造方法(包括便利构造器)
// 父类的存储属性是由父类的构造器初始化, 子类的存储属性是由缺省值初始化的
//var sm = SuperMan6(name: "han", age: 30)
//var sm = SuperMan6(name: "hjq")
//var sm = SuperMan6()
//print(sm.height)

// 如果子类中只是重写了父类中的某些指定构造器, 不管子类中的存储属性是否有缺省值, 都不会继承父类中的其它构造方法
//var sm = SuperMan(height: 198.0)

// 如果子类重写了父类中所有的指定构造器, 不管子类中的存储属性是否有缺省值, 都会同时继承父类中的所有便利方法
var sm6 = SuperMan6()



/*
 必须构造器:
 只要在构造方法的前面加上一个 required 关键字, 那么所有的子类(后续子类)只要定义了构造方法都必须实现该构造方法
 */
class Person7 {
    var name:String
    required init(name:String){
        self.name = name
    }
}
class SuperMan7: Person7 {
    var age:Int
    init() {
        self.age = 24
        super.init(name: "hjq")
    }
    required init(name: String) {
        self.age = 24
        super.init(name: name)
    }
}
var sm7 = SuperMan7(name: "hjq")




