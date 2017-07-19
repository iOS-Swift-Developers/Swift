//
//  ViewController.swift
//  JQPageView
//
//  Created by 韩俊强 on 2017/7/18.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    fileprivate func setupUI() {
        setupContentView()
    }
    fileprivate func setupContentView() {
        
        // 1.frame
        let pageViewFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.titles
        let titles = ["推荐", "跟着", "小韩哥", "学习Swift", "一定有收获", "加油!","推荐", "跟着", "小韩哥"]
        
        // 3.titleView样式
        let style = JQTitleStyle()
        style.titleHeight = 44
        style.isScrollEnable = true
        style.isNeedScale = true
        style.isShowCover = true
        
        // 4.初始化所有子控制器
        var childVcs = [TestViewController]()
        for _ in 0..<titles.count {
            let vc = TestViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        // 5.创建JQPageView
        let pageView = JQPageView(frame: pageViewFrame, titles: titles, style: style, childVCs: childVcs, parentVc: self)
        
        // 6.将pageView添加到控制器View中
        view.addSubview(pageView)
    }
}
