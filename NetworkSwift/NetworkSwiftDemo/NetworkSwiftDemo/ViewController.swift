//
//  ViewController.swift
//  NetworkSwiftDemo
//
//  Created by 韩俊强 on 2017/8/29.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array : NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "网络请求"
        self.array = ["NSURLSessionDataTask", "Alamofire"]
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        let text:String = self.array[indexPath.row] as! String
        cell!.textLabel!.text = text
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            let alamfireVC = AlamofireViewController()
            self.navigationController?.pushViewController(alamfireVC, animated: true)
        } else {
            let sessionDataTaskVC = SessionDataTaskViewController()
            self.navigationController?.pushViewController(sessionDataTaskVC, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

