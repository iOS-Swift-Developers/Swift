//
//  UIColor-Extension.swift
//  瀑布流
//
//  Created by 韩俊强 on 2017/7/20.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

extension UIColor {
    convenience  init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g:  CGFloat(arc4random_uniform(256)), b:  CGFloat(arc4random_uniform(256)))
    }
}
