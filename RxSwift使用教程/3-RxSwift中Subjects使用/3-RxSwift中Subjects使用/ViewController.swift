//
//  ViewController.swift
//  3-RxSwift中Subjects使用
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
        
        // 1.PulishSubject, 订阅者只能接受, 订阅之后发出的事情
        let pulishSub = PublishSubject<String>()
        pulishSub.onNext("20")
        pulishSub.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        pulishSub.onNext("HaRi")
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        
        // 2.ReplaySubject, 订阅者可以接受订阅之前的事件&订阅之后的事件
        let replaySub = ReplaySubject<String>.createUnbounded()
        replaySub.onNext("a")
        replaySub.onNext("b")
        replaySub.onNext("c")
        
        replaySub.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        replaySub.onNext("d")
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        
        // 3.BehaviorSubject, 订阅者可以接受, 订阅之前的最后一个事件
        let behaviorSub = BehaviorSubject(value: "a")
        
        behaviorSub.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        behaviorSub.onNext("e")
        behaviorSub.onNext("f")
        behaviorSub.onNext("g")
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        
        // 4.Variable
        
        /*
         Variable
             1> 相当于对BehaviorSubject进行装箱;
             2> 如果想将Variable当成Obserable, 让订阅者进行订阅时, 需要asObserable转成Obserable;
             3> 如果Variable打算发出事件, 直接修改对象的value即可;
             4> 当事件结束时, Variable会自动发出completed事件
        */
        let variable = Variable("a")
        
        variable.value = "b"
        
        variable.asObservable().subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        variable.value = "c"
        variable.value = "d"
        
    }
}

