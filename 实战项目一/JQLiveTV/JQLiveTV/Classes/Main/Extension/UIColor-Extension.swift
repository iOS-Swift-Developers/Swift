//
//  UIColor-Extension.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat){
        self.init(red : r / 255.0, green: g / 255.0, blue: b / 355.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g:  CGFloat(arc4random_uniform(256)), b:  CGFloat(arc4random_uniform(256)))
    }
}
