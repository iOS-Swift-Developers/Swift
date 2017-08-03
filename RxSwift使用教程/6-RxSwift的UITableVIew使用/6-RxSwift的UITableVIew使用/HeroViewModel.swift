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
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    lazy var heroVariable : Variable<[Hero]> = {
       return Variable(self.getHeroData())
    }()
    
    var searchText : Observable<String>
    
    init(searchText : Observable<String>) {
        self.searchText = searchText
        
        self.searchText.subscribe(onNext: { (str : String) in
            let heros = self.getHeroData().filter({ (hero : Hero) -> Bool in
                if str == "" { return  true }
                return hero.name.contains(str)
            })
            self.heroVariable.value = heros
        }).addDisposableTo(bag)
    }
    deinit {
        print("~~~")
    }
}

extension HeroViewModel {
    fileprivate func getHeroData() -> [Hero] {
        // 1.获取路径
        let path = Bundle.main.path(forResource: "heros.plist", ofType: nil)!
        
        // 2.读取文件内容
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        
        // 3.遍历所有的字典并且转成模型对象
        var heros : [Hero] = [Hero]()
        for dict in dataArray {
            heros.append(Hero(dict: dict))
        }
        return heros
    }
}
