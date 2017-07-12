//
//  main.swift
//  Swift4.0KVC和KVO
//
//  Created by 韩俊强 on 2017/7/12.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation


/*
 Swift4语法 需要在xcode9 iOS11运行
 */


/*
 struct 也支持 KVC
 */

/*
struct ValueType {
    var name:String
}
var object = ValueType(name: "小韩哥")
let name =  \ValueType.name

//set
object[keyPath: name] = "Swift4"
//get
let valueOfName = object[keyPath:name]
*/



/*
 KVO: 目前依然只有 NSObject 才支持KVO
 */
//注意:被观察的属性需要用dynamic修饰，否则也无法观察到。
//一个好消息是不需要在对象被回收时手动 remove observer。但是这也带来了另外一个容易被忽略的事情：观察的闭包没有被强引用，需要我们自己添加引用，否则当前函数离开后这个观察闭包就会被回收了。
/*
class OCClass: NSObject {
    dynamic var name:String
    init(name : String) {
        self.name = name
    }
}


func TestKVO() {
    var swiftClass : OCClass!
    var ob: NSKeyValueOperator!
    
    swiftClass = OCClass(name: "OC")
    ob = swiftClass.observe(\.name){
        (ob, changed) in
        let
         new = ob.name
        print(new)
    }
    swiftClass.name = "Swift4"
}
TestKVO()
*/



