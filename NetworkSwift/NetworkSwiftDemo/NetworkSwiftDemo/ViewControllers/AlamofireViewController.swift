//
//  AlamofireViewController.swift
//  NetworkSwiftDemo
//
//  Created by 韩俊强 on 2017/8/29.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var array : NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Alamofire"
        self.array = ["Get无参数", "Get有参数", "Post无参数", "Post有参数"]
        
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
        switch indexPath.row {
            
        case 0:
            requestWithGet()
            break
        case 1:
            requestWithGetParams()
            break
        case 2:
            requestWithPost()
            break
        case 3:
            requestWithPostParams()
            break
        default:
            print("hello")
        }
    }

    // MARK: - GET
    func requestWithGet() {
        Alamofire.request("http://rapapi.org/mockjsdata/25204/get").responseJSON { (response) in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
    
    // MARK: - GET_Params
    func requestWithGetParams() {
        // NSURL
        let url:URL = URL(string: "http://rapapi.org/mockjsdata/25204/getWithParams?userName='xiaohange'&userPassword='88995'")!
        // NSURLRequest
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        // 请求的Header
        request.addValue("a566eb11f7dc9ff15ca78c2d93", forHTTPHeaderField: "apikey")
        // URLSession
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        let session:URLSession = URLSession(configuration: configuration)

        // NSURLSessionTask
        let dataTask:URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler:{ (data, response, error) -> Void in
            if (error == nil) {
                do {
                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    print(responseData)
                } catch {
                    
                }
            }
      })
     // 启动任务
     dataTask.resume()
    }
    
    // MARK: - POST
    func requestWithPost() {
        // NSURL
        let url:URL = URL(string: "http://rapapi.org/mockjsdata/25204/post")!
        
        // NSURLRequest
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "".data(using: String.Encoding.utf8)
        // NSURLSession
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        let session:URLSession = URLSession(configuration: configuration)
        
        // NSURLSessionTask
        let task:URLSessionDataTask = session.dataTask(with: request as URLRequest,completionHandler: { (data, request, error) -> Void in
            
            if error == nil {
                do {
                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    print(responseData)
                } catch {
                    
                }
            }
        })
        // 启动任务
        task.resume()
    }
    
    func requestWithPostParams() {
        // NSURL
        let url:URL = URL(string: "http://rapapi.org/mockjsdata/25204/postWithParams")!
        
        // NSURLRequest
        let request:NSMutableURLRequest = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        // 参数
        /*
        // 方法1:
        let paramsString = "userName=xiaohange&userPassword=88995"
        request.httpBody = paramsString.data(using: String.Encoding.utf8)
        */
        
        // 方法2:
        let paramsDic:NSDictionary = ["userName":"xiaohange", "userPassword":"88995"]
        do {
            let data:Data = try JSONSerialization.data(withJSONObject: paramsDic, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = data
        } catch {}
        
        // NSURLSession
        let configuration:URLSessionConfiguration = URLSessionConfiguration.default
        let session:URLSession = URLSession(configuration: configuration)
        
        // NSURLSessionTask
        let task:URLSessionDataTask = session.dataTask(with: request as URLRequest, completionHandler: {(data, requst, error) -> Void in
            if error == nil {
                do {
                    let responseData:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    print(responseData)
                } catch {
                    
                }
            }
       })
        task.resume()
    }
}
