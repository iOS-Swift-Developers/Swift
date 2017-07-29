//
//  ViewController.swift
//  Client
//
//  Created by 韩俊强 on 2017/7/27.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

/*
 1> 获取到服务器对应的IP/端口号
 2> 使用Socket, 通过IP/端口号和服务器建立连接
 3> 开启定时器, 实时让服务器发送心跳包
 4> 通过sendMsg, 给服务器发送消息: 字节流 --> headerData(消息的长度) + typeData(消息的类型) + MsgData(真正的消息)
 5> 读取从服务器传送过来的消息(开启子线程)
 */

//关于ProtocolBuffers: http://blog.csdn.net/qq_31810357/article/details/76252480

//关于测试: 与Server服务端配合测试监听: addr 和 port 要一致!
//addr: 是你mac的ip地址, port端口: 可以自定义, 建议4位大于2000的端口, 否则有可能被占用!

class ViewController: UIViewController {
    
    fileprivate lazy var socket : JQSocket = JQSocket(addr: "192.168.1.102", port: 1935)
    
    fileprivate var timer : Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if socket.connectSever() {
            
            print("连接成功")
            
            socket.startReadMsg()
            
            timer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
            RunLoop.main.add(timer,forMode: .commonModes)
        } else {
            print("连接失败")
        }
    }
    
    deinit {
        timer.invalidate()
        timer = nil
    }
    
    /*
     进入房间 = 0
     离开房间 = 1
     文本 = 2
     礼物 = 3
     */
    
    @IBAction func joinRoomAction(_ sender: UIButton) {
        socket.sentJoinRoom()
        print("进入房间")
    }
    
    @IBAction func leaveRoomAction(_ sender: UIButton) {
        socket.sendLeaveRoom()
        print("离开房间")
    }

    @IBAction func sendTextAction(_ sender: UIButton) {
        socket.sendTextMsg(message: "小韩哥的文本消息")
        print("发送文本")
    }
    
    @IBAction func sendGiftAction(_ sender: UIButton) {
        socket.sendGiftMsg(giftName: "保时捷", giftURL: "http://www.baidu.com", giftCount: 100000)
        print("发送礼物🎁")
    }
}

extension ViewController{
    @objc fileprivate func sendHeartBeat() {
        socket.sendHeartBeat()
    }
}
