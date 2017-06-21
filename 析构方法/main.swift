//
//  main.swift
//  析构方法
//
//  Created by 韩俊强 on 2017/6/20.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 析构方法:
 对象的内存被回收前被隐式调用的方法, 对应OC的dealloc方法
 主要执行一些额外操作, 例如释放一些持有资源, 关闭文件, 断开网络等
 */
class FileHandle {
    var fd:Int32? // 文件描述符
    //指定构造器
    init(path:String) {
        //需要打开的文件路径, 打开方式(只读)
        //open方法是UNIX的方法
        let ret = open(path, O_RDONLY)
        if ret == -1 {
            fd = nil
        }else{
            fd = ret
        }
        print("对象被创建")
    }
    //析构方法
    deinit {
        //关闭文件
        if let ofd = fd {
            close(ofd)
        }
        print("对象被销毁")
    }
}
var fh:FileHandle? = FileHandle(path: "/Users/hanjunqiang/Desktop/StudyEveryDay/H5/第一阶段/小说.html") //测试地址, 换成你自己路径地址文件即可
fh = nil


/*
 析构方法的自动继承
 父类的析构方法会被自动调用, 不需要子类管理
 */
class Person {
    var name:String
    init(name:String) {
        self.name = name
        print("Person init")
    }
    deinit {
        print("Person deinit")
    }
}

class SuperMan: Person {
    var age:Int
    init(age:Int) {
        self.age = age
        super.init(name: "hjq")
    }
    deinit {
        //如果父类的析构方法不会被自动调用, 那么我们还需要关心父类
        //但是如果这样做对子类是比较苦逼的
        print("SuperMan deinit")
    }
}
var sm:SuperMan? = SuperMan(age: 25)
sm = nil


