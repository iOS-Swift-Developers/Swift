//
//  main.swift
//  协议
//
//  Created by 韩俊强 on 2017/6/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/** 协议 **/

// 格式:协议的定义方式与类, 结构体, 枚举的定义非常相似
protocol SomeProtocol {
    // 协议方法
}

// 遵守协议
class SomeClass: NSObject, SomeProtocol{
    // 类的内容
    // 实现协议中的方法
}
