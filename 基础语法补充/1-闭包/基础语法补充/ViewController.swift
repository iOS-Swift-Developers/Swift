//
//  ViewController.swift
//  基础语法补充
//
//  Created by 韩俊强 on 2017/7/13.
//  Copyright © 2017年 HaRi. All rights reserved.
// 
//  闭包补充知识点

import UIKit

class ViewController: UIViewController {
    
    var httpTool : HttpTool?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        httpTool = HttpTool()
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        httpTool?.loadData(finished: { (jsonData) in
            print("在控制器中拿到数据:\(jsonData)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

