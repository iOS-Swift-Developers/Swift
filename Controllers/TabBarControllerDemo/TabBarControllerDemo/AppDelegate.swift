//
//  AppDelegate.swift
//  TabBarControllerDemo
//
//  Created by 韩俊强 on 2017/9/1.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vcArray = NSMutableArray()
        
        for i in 1...4 {
            let vc = UIViewController()
            vc.title = "视图\(i)"
            
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            vc.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
            let nav = UINavigationController(rootViewController: vc)
            vcArray.add(nav)
            
            // 设置标题及状态icon
            let tabBarItem = UITabBarItem(title: "第\(i)视图", image: UIImage.init(named: "tabbar0\(i)_normal"), selectedImage: UIImage.init(named: "tabbar0\(i)_selected"))
            vc.tabBarItem = tabBarItem
        }
        
        // Tabbar
        let tabbarController = UITabBarController()
        tabbarController.tabBar.barTintColor = UIColor.green
        
        // 注意:视图控制器超过5个时（不包含5）会自动生成一个more视图标签，用来控制第5、6、...以后的视图控制器。
        tabbarController.viewControllers = vcArray as! [UINavigationController]
        // 设置属性
        tabbarController.selectedIndex = 0
        tabbarController.tabBar.isUserInteractionEnabled = true
        tabbarController.tabBar.barTintColor = UIColor.white
        tabbarController.tabBar.backgroundImage = UIImage.init(named: "")
        tabbarController.tabBar.selectionIndicatorImage = UIImage.init(named: "")
        
        // 设置字体
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.black], for: UIControlState())
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.blue], for: UIControlState.selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 8.0)], for: UIControlState())
        // 字体偏移
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0.0, -5.0)
        // 设置图标选中颜色
        UITabBar.appearance().tintColor = UIColor.red
        
        self.window!.rootViewController = tabbarController
        self.window!.makeKeyAndVisible()

        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

