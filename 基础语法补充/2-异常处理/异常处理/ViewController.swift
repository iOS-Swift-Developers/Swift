//
//  ViewController.swift
//  异常处理
//
//  Created by 韩俊强 on 2017/7/13.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var manager = FileReadManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        do{
            let str = try manager.readFileContent("hello.txt")
            print(str as Any)
        }catch{
            let errorType = error as! FileReadError
            
            switch errorType {
            case FileReadError.fileNameNotNull:
                print("fileNameNotNull")
            case FileReadError.filePathNotFind:
                print("filePathNotFind")
            case FileReadError.fileDataError:
                print("fileDataError")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

