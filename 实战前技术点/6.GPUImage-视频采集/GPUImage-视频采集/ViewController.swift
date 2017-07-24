//
//  ViewController.swift
//  GPUImage-视频采集
//
//  Created by 韩俊强 on 2017/7/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import GPUImage
import AVKit

class ViewController: UIViewController {
    @IBOutlet weak var beautyViewBottomCons: NSLayoutConstraint! // 弹窗底部距离
    
    // MARK:- 懒加载
    fileprivate lazy var camera : GPUImageVideoCamera? = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPresetHigh, cameraPosition: .front)
    
    // 创建预览图层
    fileprivate lazy var preview : GPUImageView = GPUImageView(frame: self.view.bounds)
    
    // 初始化滤镜
    let bilateralFiter = GPUImageBilateralFilter()  // 磨皮
    let exposureFilter = GPUImageExposureFilter()   // 曝光
    let brightnessFilter = GPUImageBrightnessFilter() // 美白
    let satreationFilter = GPUImageSaturationFilter() // 饱和
    
    // MARK:- 计算属性
    var fileURL : URL {
        return URL(fileURLWithPath: "\(NSTemporaryDirectory())123.mp4")
    }
    
    // 创建写入对象
    fileprivate lazy var movieWriter : GPUImageMovieWriter = {
       [unowned self] in
        // 创建写入对象
        let writer = GPUImageMovieWriter(movieURL: self.fileURL, size: self.view.bounds.size)
        
        return writer!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCaptureAction()
    }
    
    fileprivate func startCaptureAction() {
        print(fileURL)
        
        // 删除上一次的文件
        let manager = FileManager.default
        try! manager.removeItem(at: fileURL)
        
        // 1.设置camera方向
        camera?.outputImageOrientation = .portrait
        camera?.horizontallyMirrorFrontFacingCamera = true
        
        // 2.创建预览的View
        view.insertSubview(preview, at: 0)
        
        // 3.获取滤镜组
        let filterGroup = getGroupFilters()
        
        // 4.设置GPUImage的响应链
        camera?.addTarget(filterGroup)
        filterGroup.addTarget(preview)
        
        // 5.开始采集视频
        camera?.startCapture()
        
        // 6.设置writer的属性 是否对视频进行编码
        movieWriter.encodingLiveVideo = true
        
        // 将writer设置成滤镜的target
        filterGroup.addTarget(movieWriter)
        
        // 设置cmera的编码
        camera?.delegate = self
        camera?.audioEncodingTarget = movieWriter
        movieWriter.startRecording()
    }
    
    fileprivate func getGroupFilters() -> GPUImageFilterGroup {
        // 1.创建滤镜组(用于存放各种滤镜: 美白, 磨皮, 曝光, 饱和等)
        let fileterGroup = GPUImageFilterGroup()
        
        // 2.创建滤镜(设置铝产能的依赖关系)
        bilateralFiter.addTarget(brightnessFilter)
        brightnessFilter.addTarget(exposureFilter)
        exposureFilter.addTarget(satreationFilter)
        
        // 3.设置滤镜组链 初始&终点 的filter
        fileterGroup.initialFilters = [bilateralFiter]
        fileterGroup.terminalFilter = satreationFilter
        
        return fileterGroup
    }
}

// MARK:- 控制方法
extension ViewController {
    // 翻转
    @IBAction func rotateCameraAction(_ sender: UIButton) {
        camera?.rotateCamera()
    }
    
    //
    @IBAction func adjustBeautyEffect(_ sender: UIButton) {
        adjustBeautyView(constant: 0)
    }
    
    // 完成
    @IBAction func finishedBeautyEffect(_ sender: UIButton) {
        adjustBeautyView(constant: -250)
    }
    
    private func adjustBeautyView(constant : CGFloat) {
        beautyViewBottomCons.constant = constant
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
    }
    
    // 开启美颜
    @IBAction func switchBeautyEffect(_ sender: UISwitch) {
        if sender.isOn {
            camera?.removeAllTargets()
            let group = getGroupFilters()
            camera?.addTarget(group)
            group.addTarget(preview)
        } else {
            camera?.removeAllTargets()
            camera?.addTarget(preview)
        }
    }
    
    // 磨皮
    @IBAction func changeBilateralAction(_ sender: UISlider) {
        bilateralFiter.distanceNormalizationFactor = CGFloat(sender.value) * 8
    }
    
    // 曝光
    @IBAction func changeExposureAction(_ sender: UISlider) {
        // -10 ~ 10
        exposureFilter.exposure = CGFloat(sender.value) * 20 - 10
    }
    
    // 美白
    @IBAction func changeBrightness(_ sender: UISlider) {
        // -1 ~ 1
        brightnessFilter.brightness = CGFloat(sender.value) * 2 - 1
    }
    
    // 饱和
    @IBAction func changeSatureation(_ sender: UISlider) {
        satreationFilter.saturation = CGFloat(sender.value * 2)
    }
}

extension ViewController {
    // 结束直播
    @IBAction func stopRecordingAction(_ sender: UIButton) {
        camera?.stopCapture()
        preview.removeFromSuperview()
        movieWriter.finishRecording()
    }
    // 播放视频
    @IBAction func playVideoAction(_ sender: UIButton) {
        print(fileURL)
        let playerVc = AVPlayerViewController()
        playerVc.player = AVPlayer(url: fileURL)
        present(playerVc, animated: true, completion: nil)
    }
}

extension ViewController : GPUImageVideoCameraDelegate {
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        print("成功采集到画面")
    }
}

