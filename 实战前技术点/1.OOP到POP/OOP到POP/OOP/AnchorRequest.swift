//
//  AnchorRequest.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class AnchorRequest: Requestable {

    var URLString: String = ""
    var method: HttpMethod = .GET
    var host: String = "https://api.onevcat.com"
    var path: String =  "/users/onevcat"
    var parameters: [String : Any] = [:]
    
    typealias ResultType = Anchor
}
