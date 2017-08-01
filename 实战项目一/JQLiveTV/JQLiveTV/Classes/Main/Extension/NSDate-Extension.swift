//
//  NSDate-Extension.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import Foundation

extension Date {
    static func getCurrentTime() -> String{
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
