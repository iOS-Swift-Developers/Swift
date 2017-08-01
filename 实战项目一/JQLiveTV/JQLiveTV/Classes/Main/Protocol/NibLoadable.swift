//
//  NibLoadable.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit

protocol NibLoadable {
    
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibName : String? = nil) -> Self {
        let loadName = nibName == nil ? "\(self)" : nibName!
        
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
