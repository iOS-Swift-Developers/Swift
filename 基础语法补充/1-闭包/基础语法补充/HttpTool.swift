//
//  HttpTool.swift
//  基础语法补充
//
//  Created by 韩俊强 on 2017/7/13.
//  Copyright © 2017年 HaRi. All rights reserved.
//
//  闭包补充知识点

import UIKit

class HttpTool: NSObject {

    func loadData(finished: @escaping (_ jsonData : [String]) -> ()) ->() {
        DispatchQueue.global().async {
            
            () -> Void in
            print("发送异步网络请求,耗时操作:\(Thread.current)")
            
            //获取到的json结果数据
            let json = ["姓名", "年龄", "身高"];
            
            DispatchQueue.main.async {
                
                () -> Void in
                print("回到主线程, 将数据回调出去")
                finished(json)
            }
        }
    }
}
