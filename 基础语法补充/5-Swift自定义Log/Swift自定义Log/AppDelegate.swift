//
//  AppDelegate.swift
//  Swift自定义Log
//
//  Created by 韩俊强 on 2017/8/3.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        JQLog(message: 1)
        
        return true
    }
}

// T是动态类型
func JQLog<T>(message: T, file : String = #file, funcName:String = #function, lineNum : Int = #line){
    
    #if DEBUG
        
        // Build Settings --> swift flags --> 在debug后点击 + --> -D 自己起的名字
        let fileName = (file as NSString).lastPathComponent
        
        // 打印函数名
        print("\(fileName):(第\(lineNum)行) - \(message)")
    
    #endif
}
