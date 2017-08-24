//
//  ViewController.swift
//  CacheDemo1
//
//  Created by 韩俊强 on 2017/8/24.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    var textFiled = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "NSUserDefault"
        let saveItem = UIBarButtonItem(title: "save", style: .done, target: self, action: #selector(save))
        let readItem = UIBarButtonItem(title: "read", style: .done, target: self, action: #selector(ViewController.readInfo))
        let deleteItem = UIBarButtonItem(title: "del", style: .done, target: self, action: #selector(ViewController.deleteInfo))
        
        self.navigationItem.rightBarButtonItems = [saveItem, readItem, deleteItem]
        
        setupUI()
        
    }
    
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 保存
    func saveInfo(_ name : String){
        if 0 <= name.characters.count  {
            let userDefault = UserDefaults.standard
            userDefault.set(name, forKey: "name")
            userDefault.synchronize()
            
            let alert = UIAlertController(title: nil, message: "保存成功", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - 读取
    func readInfo() -> String {
        let userDefault = UserDefaults.standard
        let name = userDefault.object(forKey: "name") as? String
        
        let alert = UIAlertController(title: nil, message: "读取成功:\(name)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        if (name != nil) {
            return name!
        }
        return ""
    }
    
    // MARK: - 删除
    func deleteInfo() {
        let userDefault = UserDefaults.standard
        userDefault.removeObject(forKey: "name")
        
        let alert = UIAlertController(title: nil, message: "删除成功", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupUI(){
        textFiled = UITextField(frame: CGRect(x: 10, y: 10, width: 200, height: 30))
        self.view.addSubview(textFiled)
        textFiled.clearButtonMode = .whileEditing
        textFiled.returnKeyType = .done
        textFiled.delegate = self
        textFiled.textColor = UIColor.red
        textFiled.layer.borderColor = UIColor.black.cgColor
        textFiled.layer.borderWidth = 1.0
    }
    
    func save() {
        self.saveInfo(textFiled.text!)
    }

}

