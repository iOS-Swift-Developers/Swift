//
//  main.swift
//  可选类型
//
//  Created by 韩俊强 on 2017/6/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 可选类型:
 可选类型的本质其实是一个枚举;
 None 没有值
 Some 有值
 格式: Optional<类型> 或者在类型后面加上?号
 由于可选类型在Swift中随处可见, 所有系统做了这个语法糖, 在类型后面加上?
 */

var opa: Optional<Int>
var opb: Int?

//基本类型变量, 在使用之前必须进行初始化, 否则报错;
//目的: 安全, 不管什么时候方法都是有意义的;
//普通变量和可选类型的区别, 普通变量只有一种状态, 有值;
//注意: Swift中的变量和 OC/C 的不一样, OC/C可以没有值, 是一个随机值;
var nora: Int
nora = 10
print(nora)

//Int *p
//NSLog("%d", *p)   Error!

//由于普通变量只有一种状态, 有局限性, 所以Swift设计了可选类型
print(opb as Any)

//可选类型安全吗? 安全! 可以通过可选绑定判断后再使用;
//Swift的发明者出于安全的考量, 当我们使用基本类型时完全不用考虑是否有值;
//当我们使用可选类型时, 总会记得先判断再使用, 让程序时刻了解哪些有值哪些没有值.
opb = 55
if let b = opb{
    print(b)
}


//Swift中的可选类型变量更贴近于OC中的普通变量
//NSData *data = [NSData .dataWithContentsOfMappedFile:@"/Users/hanjunqiang/Desktop/StudyEveryDay/H5/第一阶段/小说.html"];
//NSLog("%@", data);

var data:NSData? = NSData(contentsOfFile: "/Users/hanjunqiang/Desktop/StudyEveryDay/H5/第一阶段/小说.html") //测试地址, 换成你自己路径地址文件即可
//print(data as Any)


/*
 可选链: 通过可选类型的变量来调用相应的属性和方法;
 可选链的返回值是一个可选值
 格式:
 可选值?.属性
 可选值?.方法
 */

class Person {
    var name:String
    init(name:String) {
        self.name = name
    }
    func whoMan() -> String {
        print("my name is \(self.name)")
        return name
    }
    func show() {
        print("\(self.name)")
    }
}
var p0:Person?
var p1:Person = Person(name: "hjq")
p1.name = "han"
p1.show()

/** 如何通过可选类型来调用对应的方法和属性? **/

// 1:通过强制解包;  但是强制解包非常危险, 如果可选类型没有值, 会引发运行时错误
//p0!.name = "xiaohange"
//p0!.whoMan()

// 2:通过可选绑定, 代码繁琐, 但安全
if let b = p0{
    b.name = "hello Han"
    b.whoMan()
}

// 3.通过可选链, 如果?号前面变量没有值, 整个可选链会失效
// 更加简洁高效, 有利于使用可选类型
p0 = p1
p0?.name = "hi, HaRi"
var str:String? = p0?.whoMan()

//可选链的返回值会自动包装成一个可选值
//因为可选链可能失效, 所以返回值可能有值也可能没值, 想要表达有值或者没有纸只能用可选值, 所以返回值会自动包装成一个可选值
print(p0?.name as Any)
print(p0?.whoMan() as Any)
print(p1.name)
var a:String? = p0?.name
p0?.name = "haha"
var b:String? = p1.name


/*
 可选链调用下标引索:
 格式: 可选值?[]
 */
struct Student {
    var name:String = "han"
    var math:Double = 99.0
    var chinese:Double = 100.0
    var english:Double = 99.0
    //想要通过下标访问, 必须实现subscript方法;
    //如果想要通过下标访问, 必须实现get方法;
    //如果想要通过下标赋值, 必须实现set方法.
    subscript(course:String) ->Double?{
        get{
            switch course{
                case "math":
                return math
                case "chinese":
                return chinese
                case "english":
                return english
            default:
                return nil
            }
        }
        set{
            switch course{
            case "math":
                math = newValue!   //返回值可选类型!
            case "chinese":
                chinese = newValue!
            case "english":
                english = newValue!
            default:
                print("not found")
            }
        }
    }
}
var stu:Student? = Student()
//可选链调用下标引索不需要"."直接在?号后面加上[]即可
print(stu?["math"] as Any)

var arr:Array? = [1,2,3,4]
print(arr?[1] as Any)

//利用可选链赋值时, 要注意: 早些版本中不能利用可选链赋值
stu?.name = "hanjunqiang"
print(stu?.name as Any)

//利用可选链给下标赋值
stu?["chinese"] = 200.0
print(stu?["chinese"] as Any)

//判断赋值操作是否成功, 可选链的赋值操作也有返回值
//如果赋值成功会返回一个可选类型, 返回()?也就是Void? 代表成功, 返回nil代表失败
//let res1: = stu?.name = "xiaohange"
//let res1: ()? = stu?.name = "xiaohange"
//let res1: Void? = stu?.name = "xiaohange"
//print(res1)

stu = nil
let res: Void? = stu?.name = "HaRi"
print(res as Any)



/*
 多层可选链:
 单层: 可选值?.属性
 多层: 可选值?.属性.属性   或者    可选值?.属性.属性?.属性
 */
class A {
    var name:String = "han"
}
class B {
    var a1:A?
}
class C {
    var b1:B?
}
class D {
    var c1:C?
}
var a1 = A()
var b1 = B()
var c1 = C()
var d1 = D()

d1.c1 = c1
// 通过d直接给b赋值
// 由于D中的C是可选值, 所以需要在C后面加上?号
d1.c1?.b1?.a1 = a1

// 通过d直接获取a中的name
// 其实只需要在可选值后面加上?号即可, 如果可选值不存在, 那么后面的链接失效
print(d1.c1?.b1?.a1?.name as Any)



