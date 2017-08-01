//
//  JQNavigationController.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit

class JQNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.使用运行时, 打印手势中的所有属性
        guard let targets = interactivePopGestureRecognizer!.value(forKey: "_targets") as? [NSObject]  else { return }
        
        let targetObjc = targets[0]
        
        let target = targetObjc.value(forKey: "target")
        
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        
        view.addGestureRecognizer(panGes)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }
}
