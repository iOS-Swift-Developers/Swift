//
//  ViewController.swift
//  粒子动画&面向协议
//
//  Created by 韩俊强 on 2017/7/18.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Emitterable {

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         1.什么是粒子系统？
         粒子系统是由总体具有相同的表现规律，个体却随机表现出不同的特征的大量显示元素构成的集合。
         2.粒子定义有三要素
         2.1群体性：粒子系统是由“大量显示元素”构成的(例如雪、雨、一团雾等等)
         2.2统一性：粒子系统的每个元素具有相同的表现规律(例如下雨、下雪，方向都是从上向下)
         2.3随机性：粒子系统的每个元素又随机表现出不同特征(例如下雪，每个雪花下落的速度会有不同，大小会有不同、方向也会有略微的不同)
         3.应用:
         主播房间右下角粒子动画
         雪花/下雨/烟花等效果
         QQ生日快乐一堆表情的跳动
         
         4.粒子系统的使用
         步骤:
         4.1创建发射器
         4.2创建粒子, 设置粒子属性
         
         (这里我使用了协议将粒子动画封装起来, 在使用的VC遵守Emitterable协议即可使用)
         */
    }
    

    @IBAction func startOrStopEmitteringAction(_ sender: UIButton){
        
        sender.isSelected = !sender.isSelected
        
        if sender.currentTitle == "start" {
            sender.setTitle("stop", for: UIControlState(rawValue: 0))
        }else{
            sender.setTitle("start", for: UIControlState(rawValue: 0))
        }
        let point = CGPoint(x: sender.center.x, y: sender.center.y)
        
        sender.isSelected ? startEmittering(point) : stopEmittering()    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

