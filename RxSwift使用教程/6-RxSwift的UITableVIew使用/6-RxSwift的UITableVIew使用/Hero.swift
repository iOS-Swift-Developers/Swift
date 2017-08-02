//
//  Hero.swift
//  6-RxSwift的UITableVIew使用
//
//  Created by 韩俊强 on 2017/8/2.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class Hero: NSObject {
    var name : String = ""
    var icon : String = ""
    var intro : String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
}
