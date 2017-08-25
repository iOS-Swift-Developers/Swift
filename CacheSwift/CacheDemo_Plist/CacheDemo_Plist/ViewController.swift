//
//  ViewController.swift
//  CacheDemo_Plist
//
//  Created by 韩俊强 on 2017/8/25.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var filePathPlist:String = ""
    var textField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Plist"
        
        setupUI()
        
        let saveItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(saveAction))
        let readItem = UIBarButtonItem(title: "read", style: .done, target: self, action: #selector(ViewController.readinfo))
        let deleteItem = UIBarButtonItem(title: "del", style: .done, target: self, action: #selector(ViewController.deleteInfo))
        
        self.navigationItem.rightBarButtonItems = [saveItem, readItem, deleteItem]
    }

    func saveAction() {
        saveInfo(textField.text!)
    }
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge()
        }
    }
    
    func setupUI(){
        textField = UITextField(frame: CGRect(x: 10.0,y: 10.0,width: (self.view.frame.size.width - 10.0 * 2),height: 40.0))
        self.view.addSubview(textField)
        textField.textColor = UIColor.black
        textField.clearButtonMode = .whileEditing
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    // MARK - 保存
    func saveInfo(_ name : String) {
        if 0 <= name.characters.count {
            // 1.获取沙盒路径
            let home = NSHomeDirectory() as NSString
            // 2.拼接路径
            let docPath = home.appendingPathComponent("Documents") as NSString;
            // 3.获取文本文件路径
            filePathPlist = docPath.appendingPathComponent("data.plist")
            // 4.将数据写入文件中
            // 数组
            let dataSource = NSMutableArray()
            dataSource.add(name)
            let isSuccess = dataSource.write(toFile: filePathPlist, atomically: true)
 
            // 字典
            /*
            var dict = NSMutableDictionary(contentsOfFile: filePathPlist)
            if dict == nil {
                dict = NSMutableDictionary()
            }
            dict?.setObject(name, forKey: "name" as NSCopying)
            let isSuccess = dict!.write(toFile: filePathPlist, atomically: true)
            */
            // 二进制
            /*
            let data = name.data(using: UTF8)
            let isSuccess = dataSource.write(toFile: filePathPlist, atomically: true)
            */
            let alertView = UIAlertController(title: nil, message: (isSuccess ? "保存成功" : "保存失败"), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil);
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    // MARK - 读取
    func readinfo() -> String {
        // 数组
        let array = NSArray(contentsOfFile: filePathPlist)
        let text = array?.lastObject
        
        let alertView = UIAlertController(title: nil, message: "读取成功:\(text)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil);
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
        
        if text != nil {
            return text as! String
        }
       return ""
    }
    
    func deleteInfo() {
        let array = NSArray(contentsOfFile: filePathPlist) as! NSMutableArray
        array.removeAllObjects()
        let isSuccess = array.write(toFile: filePathPlist, atomically: true)
        
        let alertView = UIAlertController(title: nil, message: (isSuccess ? "删除成功" : "删除失败"), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil);
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

