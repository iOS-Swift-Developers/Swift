//
//  OtherFilterViewController.swift
//  GPUImageDemo
//
//  Created by 韩俊强 on 2017/7/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import GPUImage

class OtherFilterViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    fileprivate let testImage : UIImage! = UIImage(named: "test.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "其他滤镜"
        
    }
    // 反色
    @IBAction func contraryColorAction(_ sender: UIButton) {
        myImageView.image = testImage
        let colorInvert = GPUImageColorInvertFilter()
        myImageView.image = addTarget(colorInvert, myImageView.image!)
    }
    
    // 灰度
    @IBAction func grayLevelAction(_ sender: UIButton) {
        myImageView.image = testImage
        let colorInvert = GPUImageSepiaFilter()
        myImageView.image = addTarget(colorInvert, myImageView.image!)
    }
    
    // 素描
    @IBAction func sketchAction(_ sender: UIButton) {
        myImageView.image = testImage
        let colorInvert = GPUImageSketchFilter()
        myImageView.image = addTarget(colorInvert, myImageView.image!)
    }
    
    // 浮雕
    @IBAction func reliefAction(_ sender: UIButton) {
        myImageView.image = testImage
        let colorInvert = GPUImageEmbossFilter()
        myImageView.image = addTarget(colorInvert, myImageView.image!)
    }
    
    private func addTarget(_ filter : GPUImageFilter, _ sourceImage : UIImage) -> UIImage {
        // 1.创建用于处理单张图片(类似美图秀秀中打开相册中的图片进行处理)
        let progressView = GPUImagePicture(image: sourceImage)
        
        // 2.创建滤镜
        progressView?.addTarget(filter)
        
        // 3.处理图像
        filter.useNextFrameForImageCapture()
        progressView?.processImage()
        
        // 4.获取最新的图像
        return filter.imageFromCurrentFramebuffer()
    }
}
