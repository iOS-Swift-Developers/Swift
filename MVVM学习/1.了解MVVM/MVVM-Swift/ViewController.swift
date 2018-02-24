//
//  ViewController.swift
//  MVVM-Swift
//
//  Created by 韩俊强 on 2018/2/23.
//  Copyright © 2018年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*
    简介
    MVVM是Model-View-ViewModel的简写，是由MVP（Model-View-Presenter）模式与WPF结合的应用方式时发展演变过来的一种新型架构框架。
    Model 用来获取数据并建立实体模型和基本的业务逻辑。提供数据获取接口供ViewModel调用，经数据转换和操作并最终映射绑定到View层某个UI元素的属性上
    View 用来创建显示的界面，不做任何业务逻辑，不处理操作数据。
    ViewModel 将View和Model联系起来，处理视图逻辑，操作数据，不做任何UI相关的事情。绑定数据到到相应的控件上，数据变化时自动更新UI。

    数据绑定
    MVVM模式使用的是数据绑定基础架构，这是MVVM设计模式的核心，在使用中，利用双向绑定技术，使得 Model 变化时，ViewModel 会自动更新，而 ViewModel 变化时，View 也会自动变化。ViewModel包含所有由UI特定的接口和属性，并有一个 ViewModel 的视图的绑定属性，当绑定的属性变化时，View会自动更新视图，所以可以把更新视图的逻辑放到ViewModel中，减少了Controller的代码，iOS实现这种绑定可以使用 通知 和 KVO。
    
    应用MVVM
    Controller 中只做了初始化TextViewModel和TextView，并把textView添加到当前Controller的view上。Controller的代码 so 简单、清晰、明了。
    */
    
    private lazy var textView: MyTextView = {
        let view = MyTextView(viewModel: self.textViewModel)
        view.frame = UIScreen.main.bounds
        return view
        
    }()
    
    private lazy var textViewModel: MyTextViewModel = {
    
        let model = MyTextViewModel()
        return model
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(textView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

