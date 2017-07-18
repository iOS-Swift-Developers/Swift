//
//  User.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

struct User {
    var name : String = ""
    var message : String = ""
    
    init?(data : Data) {
        guard let dictT = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] else {
            return nil
        }
        
        let dict = dictT?["args"] as? [String : Any]
        
        guard let name = dict?["username"] as? String else {
            return nil
        }
        
        guard let message = dict?["age"] as? String else {
            return nil
        }
        self.name = name
        self.message = message
    }
    
}

extension  User: Decodable {
    static func parse(_ data: Data) -> User? {
        return User(data: data)
    }
}




