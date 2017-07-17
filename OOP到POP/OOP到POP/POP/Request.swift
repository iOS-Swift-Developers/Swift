//
//  Request.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import Foundation

protocol Requestable {
    var method : HttpMethod { get }
    var URLString : String { get }
//    var path : String { get }
//    var parameters : [String : Any] { get }
    
    associatedtype ResultType : Decodable
}

extension Requestable {
    func request(completion: @escaping (ResultType?) -> Void) {
        // 1.创建URL
        let url = URL(string: URLString)
        
        // 2.创建request对象
        let request = URLRequest(url: url!)

        // 3.通过URLSession发送请求
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            completion(ResultType.parse(data!))
        }
        
        // 4.发起请求
        task.resume()
    }
}

protocol Decodable {
    static func parse(_ data : Data) -> Self?
}
