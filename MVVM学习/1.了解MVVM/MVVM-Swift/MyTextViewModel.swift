//
//  MyTextViewModel.swift
//  MVVM-Swift
//
//  Created by 韩俊强 on 2018/2/23.
//  Copyright © 2018年 HaRi. All rights reserved.
//

import UIKit
let kMyTextViewUpdateUI = "kMyTextViewUpdateUI"

class MyTextViewModel: NSObject {

    var textModel: TextModel!
    @objc dynamic var color: UIColor? //使用KVO监听的属性用dynamic关键字修饰
    
    override init() {
        super.init()
        textModel = TextModel()
        textModel.addObserver(self, forKeyPath: "color", options: [.old, .new], context: nil)
    }
    
    //模拟请求网络数据,在数据变化时实现自动更新UI
    
    public func requestData() {
        textModel.requestData()
    }
    
    deinit {
        textModel.removeObserver(self, forKeyPath: "color")
        
    }
}

extension MyTextViewModel {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            //这里只是介绍Model的作用,将逻辑判断放在VM中,减少了 Controller 中的代码量
            if textModel.colorName == "green" {
                color = UIColor.green
            } else {
               color = textModel.color
            }
        }
        //实现 VM 与 V 绑定的方式,使用通知或者 KVO
//        NotificationCenter.default.post(name: NSNotification.Name.init(kMyTextViewUpdateUI), object: nil)
        
    }
}

class TextModel: NSObject {
    var colorName: String?
    @objc dynamic var color: UIColor?
    
    //提供一个获取数据的接口给 ViewModel 调用
    func requestData() {
        //rundom Color
        let red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        let green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        let blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        let rundomColor = UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        colorName = String.init(describing: red)
        color = rundomColor
    }
    
}
