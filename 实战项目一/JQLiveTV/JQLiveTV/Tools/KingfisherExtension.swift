//
//  KingfisherExtension.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ URLString : String?, _ placeHolderName : String?) {
        
        guard let URLString = URLString else { return }
        
        guard let placeHolderName = placeHolderName else { return }
        
        guard let url = URL(string: URLString) else { return }
        
        kf.setImage(with: url, placeholder: UIImage.init(named: placeHolderName))
    }
}
