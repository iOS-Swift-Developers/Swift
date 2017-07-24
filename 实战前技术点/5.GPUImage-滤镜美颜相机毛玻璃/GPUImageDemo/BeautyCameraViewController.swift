//
//  BeautyCameraViewController.swift
//  GPUImageDemo
//
//  Created by 韩俊强 on 2017/7/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

// 真机测试哦!

import UIKit
import GPUImage

class BeautyCameraViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    fileprivate var stillCamera : GPUImageStillCamera!
    fileprivate var filter : GPUImageBrightnessFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "美颜相机"
        
        // 1.创建相机
        stillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .front)
        stillCamera?.outputImageOrientation = .portrait
        
        // 2.创建滤镜
        filter = GPUImageBrightnessFilter()
        filter.brightness = 0.3
        stillCamera?.addTarget(filter)
        
        // 3.创建显示实时画面的View
        let showView = GPUImageView(frame: view.bounds)
        view.insertSubview(showView, at: 0)
        filter.addTarget(showView)
        
        // 4.默认进来就开始拍摄
        stillCamera?.startCapture()
    }

    // 翻转
    @IBAction func rotateCameraAction(_ sender: UIButton) {
        stillCamera?.rotateCamera()
    }
    
    // 开始拍摄
    @IBAction func startAction(_ sender: UIButton) {
        stillCamera?.startCapture()
    }
    
    // 停止拍摄 - 保存到系统相册
    @IBAction func stopAction(_ sender: UIButton) {
        stillCamera?.capturePhotoAsImageProcessedUp(toFilter: filter, withCompletionHandler: { (image : UIImage?, error : Error?) in
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.stillCamera?.stopCapture()
        })
    }
}
