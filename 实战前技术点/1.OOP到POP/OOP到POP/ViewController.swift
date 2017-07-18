//
//  ViewController.swift
//  OOP到POP
//
//  Created by 韩俊强 on 2017/7/17.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UserRequest().request { (user : User?) in
            if let user = user {
                print(user.name, user.message)
            }
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

