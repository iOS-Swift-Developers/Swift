//
//  ViewController.swift
//  播放Gif
//
//  Created by 韩俊强 on 2017/7/26.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {
    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var myImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadGifImage(imageView: myImageView, imageName: "demo.gif")
       loadGifImage(imageView: myImageView2, imageName: "demo1.gif")
    }
    
    func loadGifImage(imageView : UIImageView, imageName : NSString) -> Void {
        // 1.加载Gif图片, 并转成Data类型
        guard let path = Bundle.main.path(forResource: imageName as String, ofType: nil) else { return }
        guard let data = NSData.init(contentsOfFile: path) else {
            return
        }
        
        // 2.从data中取出数据, 将data转成CGImageSource
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
        let imageCount = CGImageSourceGetCount(imageSource)
        
        // 3.遍历所有的图片
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0
        for i in 0..<imageCount {
            // 3.1.取出图片
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { return }
            let image = UIImage(cgImage: cgImage)
            if i == 0 {
                imageView.image = image
            }
            images.append(image)
            
            // 3.2.取出持续时间
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary else { continue }
            guard let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary else { continue }
            guard let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        
        // 4.设置imageView的属性
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = 10
        
        // 5.开始播放
        imageView.startAnimating()
    }
}

