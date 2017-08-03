//
//  ViewController.swift
//  Swift调用OC代码
//
//  Created by 韩俊强 on 2017/7/13.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.当你在Swift项目中创建OC类或者别的OC代码时, 会自动生成一个桥接 项目名称-Bridging-Header.h 文件, 如图: readMe.png ;
        
        //2.将需要调用的OC头文件写入桥接文件, 强打头文件注意书写正确, 编译一下, 即可调用;
        
        //3.调用示例如下:
        
        let p = Person()
        p.name = "小韩哥"
        
        let phone = Phone()
        phone.color = UIColor.blue
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

