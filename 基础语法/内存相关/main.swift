//
//  main.swift
//  内存相关
//
//  Created by 韩俊强 on 2017/6/20.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 Swift内存管理:
 1.管理引用类型的内存, 不会管理值类型, 值类型不需要管理;
 2.内存管理原则: 当没任何强引用指向对象, 系统会自动销毁对象(默认情况下所有的引用都是强引用);
 3.如果做到该原则: ARC 自动回收内存
 */

class Person {
    var name:String
    init(name:String) {
        self.name = name
    }
    deinit {
        print("Person deinit")
    }
}
var p:Person? = Person(name: "xiaohange")
//p = nil


/** weak弱引用 **/
class Person2 {
    var name:String
    init(name:String) {
        self.name = name
    }
    deinit {
        print("Person2 deinit")
    }
}
//强引用, 引用计数+1
var strongP = Person2(name: "hjq") //1
var strongP2 = strongP //2

//1.弱引用, 引用计数不变;
//2.如果利用weak修饰变量, 当对象释放后会自动将变量设置为nil;
//3.所以利用weak修饰的变量必定是一个可选类型, 因为只有可选类型才能设置为nil.
weak var weakP:Person2? = Person2(name: "hjq")
if let p = weakP{
    print(p)
}else{
    print(weakP as Any)
}

/*
 unowned无主引用, 相当于OC unsafe_unretained
 unowned和weak的区别:
 1.利用unowned修饰的变量, 对象释放后不会设置为nil, 不安全;
   利用weak修饰的变量, 对象释放后会设置为nil;
 2.利用unowned修饰的变量, 不是可选类型; 利用weak修饰的变量, 是可选类型;
 什么时候使用weak?
 什么时候使用unowned?
 */

class Person3 {
    var name:String
    init(name:String) {
        self.name = name
    }
    deinit {
        print("Person3 deinit")
    }
}
unowned var weakP3:Person3 = Person3(name: "hjq")


/*
 循环引用:
 ARC不是万能的, 它可以很好的解决内存问题, 但是在某些场合不能很好的解决内存泄露问题;
 例如: 两个或者多个对象之间的循环引用问题
 */

//例1:
class Apartment {
    let number:Int      //房间号
    var tenant:Person4? //租客
    init(number:Int) {
        self.number = number
    }
    deinit {
        print("\(self.number) deinit")
    }
}

class Person4 {
    let name:String
    weak var apartment: Apartment? //公寓
    init(name:String) {
        self.name = name
    }
    deinit {
        print("\(self.name) deinit")
    }
}

var p4:Person4? = Person4(name: "han")
var a4:Apartment? = Apartment(number: 888)

p4!.apartment = a4 //人有一套公寓
a4!.tenant = p4!   //公寓中住着一个人
// 两个对象没有被销毁, 但是我们没有办法访问他们了, 这就出现了内存泄露!
p4 = nil
a4 = nil



//例2:
class CreaditCard {
    let number:Int
    //信用卡必须有所属用户;
    //当某一个变量或常量必须有值, 一直有值, 那么可以使用unowned修饰
    unowned let person:Person5
    init(number:Int, person:Person5) {
        self.number = number
        self.person = person
    }
    deinit {
        print("\(self.number) deinit")
    }
}
class Person5 {
    let name:String
    var card:CreaditCard? //人不一定有信用卡💳
    init(name:String) {
        self.name = name
    }
    deinit {
        print("\(self.name) deinit")
    }
}
var p5:Person5? = Person5(name: "XiaoHange")
var cc:CreaditCard? = CreaditCard(number: 18888, person: p5!)
p5 = nil
cc = nil


