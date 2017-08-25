//
//  ViewController.swift
//  CacheDemo_Archive
//
//  Created by 韩俊强 on 2017/8/25.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 3.0 实现归档把模型保存到本地Document文件夹:
    // 3.1 获取本地Document路径,一般路径都设为全局变量,方便解档直接使用:
    let userAccountPath = "\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask,true).first!)/userAccount.data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userModel = Content()
        userModel.id = 419
        userModel.nickname = "小韩哥"
        userModel.phone = "1588888888"
        
        // 归档
        saveWriteNSKeyedArchiver(userModel: userModel)
        
        // 解档
        readWithNSKeyedUnarchiver { (model) in
            print(model.nickname!)
        }
    }
    
    // MARK - 归档
    func saveWriteNSKeyedArchiver(userModel : Content) {
        
        // 3.2 对获取到的模型进行归档操作,要注意模型必须是确定的类型,如果是可选类型会报发送未识别的消息的错误(切记)
        NSKeyedArchiver.archiveRootObject(userModel, toFile:userAccountPath)
    }
    
    // MARK: - 解档
    // 4.实现解档从Document文件夹获取本地模型数据
    // 4.1 判断Document文件夹下是否有已保存好的模型,有的话就解档取出模型
    func readWithNSKeyedUnarchiver(finished: @escaping (Content) ->()) -> () {
        DispatchQueue.global().async {
            () -> Void in
            if NSKeyedUnarchiver.unarchiveObject(withFile:self.userAccountPath) != nil {
                
                let userModel = (NSKeyedUnarchiver.unarchiveObject(withFile:self.userAccountPath) as? Content)!
                finished(userModel)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

