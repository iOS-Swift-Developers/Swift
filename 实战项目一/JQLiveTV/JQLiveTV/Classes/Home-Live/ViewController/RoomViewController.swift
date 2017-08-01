//
//  RoomViewController.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit
import Kingfisher
import IJKMediaFramework

class RoomViewController: UIViewController, Emitterable {
    
    @IBOutlet weak var bgImageViews: UIImageView!
    
    fileprivate var ijkPlayer : IJKFFMoviePlayerController?

    // MARK: 对外属性
    var anchor : AnchorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadAnchorLiveAddress()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ijkPlayer?.shutdown()
    }
}

// MARK:- 设置UI界面内容
extension RoomViewController {
    fileprivate func setupUI(){
        setupBlurView()
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageViews.bounds
        bgImageViews.addSubview(blurView)
    }
}

// MARK:- 请求主播信息
extension RoomViewController {
    fileprivate func loadAnchorLiveAddress() {
        // 1.获取请求url
        let URLString = "http://qf.56.com/play/v2/preLoading.ios"
        
        // 2.获取请求参数
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056", "signature" : "f69f4d7d2feb3840f9294179cbcb913f", "roomId" : anchor!.roomid, "userId" : anchor!.uid]
        
        NetworkTools.requestData(.GET, URLString: URLString, parameters: parameters, finishedCallback: { result in
            
            // 1.将result转成字典模型
            let resultDict = result as? [String : Any]
            
            // 2.从字典中取数据
            let infoDict = resultDict?["message"] as? [String : Any]
            
            // 3.获取请求直播地址URL
            guard let rURL = infoDict?["rUrl"] as? String else { return }
            
            // 4.请求直播地址
            NetworkTools.requestData(.GET, URLString: rURL, finishedCallback: { (result) in
                let resultDict = result as? [String : Any]
                let liveURLString = resultDict?["url"] as? String
                
                self.displayLiveView(liveURLString)
            })
        })
    }
    
    fileprivate func displayLiveView(_ liveURLString : String?) {
        // 1.获取直播地址
        guard let liveURLString = liveURLString else {
            return
        }
        
        // 2.使用IJKPlayer播放视频
        let options = IJKFFOptions.byDefault()
        options?.setOptionIntValue(1, forKey: "videotoolbox", of: kIJKFFOptionCategoryPlayer)
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: liveURLString, with: options)
        
        // 3.设置frame已经添加到其他View中
        if anchor?.push == 1 {
            ijkPlayer?.view.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: bgImageViews.bounds.width, height: bgImageViews.bounds.width * 3 / 4))
            ijkPlayer?.view.center = bgImageViews.center
        } else {
            ijkPlayer?.view.frame = bgImageViews.bounds
        }
        bgImageViews.addSubview(ijkPlayer!.view)
        ijkPlayer?.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // 4.开始播放
        ijkPlayer?.prepareToPlay()
    }
}

// MARK:- 事件监听
extension RoomViewController {
    @IBAction func closeAndBackAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func exitFiveBtnClickAction(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("评论")
            break
        case 1:
            print("分享")
            break
        case 2:
            print("送礼物")
            break
        case 3:
            print("更多")
            break
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            sender.isSelected ? startEmittering(point) : stopEmittering()
            print("点赞")
            break
        default:
            print("未处理")
        }
    }
}
