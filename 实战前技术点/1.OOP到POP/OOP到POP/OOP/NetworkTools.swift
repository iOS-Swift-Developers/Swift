//
//  NetworkTools.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

enum HttpMethod : String {
    case GET
    case POST
}

class NetworkTools {
    
}

extension NetworkTools {
    func request(method : HttpMethod, host : String, path : String, parameters : [String : Any], completion : @escaping (Data?) -> Void) {
        // 1.创建URL
        let url = URL(string: host + path)
        
        // 2.创建request对象
        let request = URLRequest(url: url!)
        
        // 3.通过URLSession发送请求
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            completion(data)
        }
        
        // 4.发起请求
        task.resume()
    }
}
