//
//  main.swift
//  代理模式
//
//  Created by 韩俊强 on 2017/7/13.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 Swfit3.0中代理的使用方法:
 */

//// 一.视图界面中

// 1.制订协议(不谢NSObjectProtocol暂时不会报错, 但是写属性是无法写weak)
protocol DelegateName : NSObjectProtocol {
    //设置协议方法
    func method()
}
//在Swift中,制定协议需要遵守NSObjectProtocol协议, 除了类可以遵守协议, 结构体也可以遵守协议;

//在OC中我们制定协议, 通常继承自NSObject, 可以这样理解,所有继承自NSObject的对象都可以实现协议方法(同样我们也可以指定哪些对象可以实现我们制定的协议方法);

// 2.用weak定义代理
weak var delegate1 : DelegateName?

// 3.判断代理是否存在, 让代理去执行方法
func clickButton() {
    //"?"替代了responsed
    delegate1?.method()
}

//// 二.在控制器界面

/*! 由于在main函数里无法运行, 所以暂且注释;
class ViewController : UIViewController, DelegateName { // 1.遵守协议
    // 2.设置代理为self
    customView?.delegate1 = self
    
    // 3.实现协议方法
    func method(){
        print("实现协议方法")
    }
}
*/



// MARK: 例子: 购票

protocol BuyTicketDelegate : class {
    func buyTicket()
}

class Person {
    weak var delegate : BuyTicketDelegate?
    
    func goToShanghai(){
        delegate?.buyTicket()
    }
}

class YellowCattle : BuyTicketDelegate {
    func buyTicket() {
        print("黄牛党帮你买了一张站票")
    }
}

let yellowCattle = YellowCattle()
let person = Person()
person.delegate = yellowCattle
person.goToShanghai()

