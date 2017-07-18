//
//  Anchor.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

struct Anchor {
    var iconURL : String = ""
    var nickname : String = ""
    init(data : Data) {
        
    }
    
}

extension Anchor: Decodable {
    static func parse(_ data: Data) -> Anchor? {
        return Anchor(data: data)
    }
}
