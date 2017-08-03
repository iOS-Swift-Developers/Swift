//
//  ViewController.swift
//  Swift自定义Log
//
//  Created by 韩俊强 on 2017/8/3.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // 1.获取打印所在的文件
        // LastPathComponent: 获取最后一个路径
        let file = (#file as NSString).lastPathComponent
        
        // 2.获取打印所在的方法
        let funcName = #function
        
        // 3.获取打印所在的行数
        let lineNum = #line
        
//        print("\(file):[\(funcName)](\(#line)) - 123")
        */
        
        JQLog(message: 123)
    }
}

