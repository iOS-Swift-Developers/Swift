//
//  ViewController.swift
//  SwiftJsonTest
//
//  Created by 韩俊强 on 2017/8/14.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        swift支持方法的重载;
        方法的重载:方法名称相同,但是参数不同.包括:
        1.参数的类型不同;
        2.参数的个数不同.
         */
        
        // 1.获取json文件路径
        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            print("没有获取到对应的文件路径")
            return
        }
        
        // 2.读取json文件中的内容
        guard let jsonData = NSData.init(contentsOfFile: jsonPath) else {
            print("没有获取到json文件中的数据")
            return
        }
        
        // 3.将Data转成数组
        // 如果在调用系统某个方法时,该方法最后有一个throws,说明该方法会抛出异常,那么需要对该异常进行处理
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) else {
            return
        }
        
        guard let dicArray = anyObject as?[[String : AnyObject]] else {
            return
        }
        
        // 4.遍历字典, 获取对应信息
        for dict in dicArray {
            // 4.1.获取控制器对应的字符串
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            
            // 4.2.获取控制器显示的title
            guard let title = dict["title"] as? String else {
                continue
            }
            
            // 4.3.获取控制器显示的图标名称
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            
            // 4.4.添加子控制器
            addChildViewController(childVCName: vcName, title: title, imageName: imageName)
        }
    }
    
    // 方法重载
    private func addChildViewController(childVCName : String, title : String, imageName : String) {
        
        // NSClassFromString("这里的名字是SwiftJsonTest.HomeViewController") // 根据字符串获取对应的Class：命名空间+.ViewController的名字
        
        // 如何修改命名空间 Target -> Build Settings -> Product Name, 可以在这里修改命名空间的名称,但是要注意,新修改的命名空间不能有中文,不能以数字开头并且不能包含"-"符号
        
        // 1.获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有命名空间")
            return
        }
        
        // 2.根据字符串获取对应的Class
        guard let childVCClass = NSClassFromString(nameSpace + "." + childVCName) else {
            print("没有获取到字符串对应的Class")
            return
        }
        
        // 3.将对应的AnyObject转成控制器的类型
        guard let childVCType = childVCClass as? UIViewController.Type else {
            print("没有获取到对应控制器的类型")
            return
        }
        
        // 4.创建对应的控制器对象
        let childVC = childVCType.init()
        
        // 5.设置子控制器的属性
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: "\(imageName)_unselected")
        childVC.tabBarItem.selectedImage = UIImage(named: "\(imageName)_selected")
        
        // 6.包装导航控制器
        let childNav = UINavigationController(rootViewController: childVC)
        
        // 7.添加控制器
        addChildViewController(childNav)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

