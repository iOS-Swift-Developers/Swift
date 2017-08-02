//
//  ViewController.swift
//  5-RxSwift资源释放
//
//  Created by 韩俊强 on 2017/8/2.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subject = BehaviorSubject(value: "a")
        subject.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        subject.onNext("b")
        
    }

}

