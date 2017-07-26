//
//  ViewController.swift
//  iOS实现推流
//
//  Created by 韩俊强 on 2017/7/26.
//  Copyright © 2017年 HaRi. All rights reserved.
//
// 真机测试
import UIKit
import LFLiveKit

class ViewController: UIViewController {
    
    lazy var session : LFLiveSession = {
       let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .low2, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        session?.preView = self.view
        return session!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // AMRK:- 查看本地ip
    // 终端: ifconfig | grep "inet" | grep -v 127.0.0.1
    // 端口: 1935 协议默认端口, 不要修改
    @IBAction func startRunningAction(_ sender: UIButton)
    {
        let stream = LFLiveStreamInfo()
        // 这里的 192.168.1.102 替换成你自己的ip地址
        stream.url = "rtmp://192.168.1.102:1935/rtmplive/room"
        session.startLive(stream)
        session.running = true
    }
    // 1.采集、2.滤镜处理、3.编码、4.推流、5.CDN分发、6.拉流、7.解码、8.播放、9.聊天互动。
}

