//
//  ViewController.swift
//  播放实时视频(AVPlayer)
//
//  Created by 韩俊强 on 2017/7/26.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 测试地址: @"https://raw.githubusercontent.com/iOS-Swift-Developers/Swift/master/%E5%AE%9E%E6%88%98%E5%89%8D%E6%8A%80%E6%9C%AF%E7%82%B9/10.JQPlayer-%E6%8B%89%E6%B5%81/test.mp4"
        
        // 1.创建AVPlayer
        let url = URL(string: "rtmp://192.168.1.102:1935/rtmplive/room");
        let player = AVPlayer(url: url!)
        
        // 2.创建图层
        let layer = AVPlayerLayer(player: player)
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
        
        // 3.播放视频
        player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

