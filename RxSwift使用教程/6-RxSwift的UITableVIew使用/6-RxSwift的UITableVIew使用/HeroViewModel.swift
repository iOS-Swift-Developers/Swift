//
//  HeroViewModel.swift
//  6-RxSwift的UITableVIew使用
//
//  Created by 韩俊强 on 2017/8/2.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import RxSwift

class HeroViewModel {
    
    var herosObserable : Variable<[Hero]> = {
        
       let path = Bundle.main.path(forResource: "heros.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var heros : [Hero] = [Hero]()
        for dict in dataArray {
            heros.append(Hero(dict: dict))
        }
        return Variable(heros)
    }()
}
