//
//  ViewController.swift
//  JQGiftAnimation
//
//  Created by 韩俊强 on 2017/7/28.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var giftDigitLabel: JQGiftDigitLabel!
    
    fileprivate lazy var giftContainerView : JQGiftContainerView = JQGiftContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        giftContainerView.frame = CGRect(x: 0, y: 150, width: 250, height: 90)
        giftContainerView.backgroundColor = UIColor.lightGray
        view.addSubview(giftContainerView)
    }

    @IBAction func sendGift1Action(_ sender: UIButton) {
        let gift1 = JQGiftModel(senderName: "小韩哥", senderURL: "icon4", giftName: "土豪红包", giftURL: "prop_h")
        giftContainerView.showGiftMdel(gift1)
        
    }
    
    @IBAction func sendGift2Action(_ sender: UIButton) {
        let gift2 = JQGiftModel(senderName: "小鹿", senderURL: "icon2", giftName: "豪华飞机", giftURL: "prop_f")
        giftContainerView.showGiftMdel(gift2)
    }
    
    @IBAction func sendGift3Action(_ sender: UIButton) {
        let gift3 = JQGiftModel(senderName: "奥巴马", senderURL: "icon3", giftName: "保时捷", giftURL: "prop_g")
        giftContainerView.showGiftMdel(gift3)
    }

}

