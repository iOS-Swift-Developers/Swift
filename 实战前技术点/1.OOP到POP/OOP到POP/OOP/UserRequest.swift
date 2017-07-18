//
//  UserRequest.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class UserRequest: Requestable {

    var method: HttpMethod = .GET
    var URLString: String = "http://httpbin.org/get?username=coderwhy&age=18"
//    var path : String = "/users/onevcat"
//    var parameters : [String : Any] = [:]
    
    typealias ResultType = User
}
