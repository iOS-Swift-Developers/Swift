//
//  FrostedGlassViewController.swift
//  GPUImageDemo
//
//  Created by 韩俊强 on 2017/7/21.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import GPUImage

class FrostedGlassViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "毛玻璃"
        
        let image = UIImage(named: "test.jpg")
        myImageView.image = generateBlurImage(image!)
    }
}

// MARK:- 生成毛玻璃
extension FrostedGlassViewController {
    fileprivate func generateBlurImage(_ sourceImage : UIImage) -> UIImage {
        // 1.创建图片处理的View
        let processView = GPUImagePicture(image: sourceImage)
        
        // 2.创建滤镜
        let blurFilter = GPUImageGaussianBlurFilter()
        blurFilter.texelSpacingMultiplier = 4.5
        blurFilter.blurRadiusInPixels = 4.5
        processView?.addTarget(blurFilter)
        
        // 3.处理图片
        blurFilter.useNextFrameForImageCapture()
        processView?.processImage()
        
        // 4.获取新的图片
        return blurFilter.imageFromCurrentFramebuffer()
    }
}
