//
//  ViewController.swift
//  RxSwift(2)
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
        
        // 1.创建一个never的Obserable, never就是创建一个sequence，但是不发出任何事件信号;
        let neverO = Observable<String>.never()
        neverO.subscribe{ (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        // 2.创建一个empty的Observable, empty就是创建一个空的sequence,只能发出一个completed事件;
        let emptyO = Observable<String>.empty()
        emptyO.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

        // 3.创建一个just的Obserable, just是创建一个sequence只能发出一种特定的事件，能正常结束;
        let justO = Observable.just("xiaohange")
        justO.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        // 4.创建一个of的Obserable, of是创建一个sequence能发出很多种事件信号;
        let ofO = Observable.of("a", "b", "c")
        ofO.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        // 5.创建一个from的Obserable, from就是从集合中创建sequence，例如数组，字典或者Set;
        let array = [1, 2, 3, 4, 5]
        let fromO = Observable.from(array)
        fromO.subscribe { (event : Event<Int>) in
            print(event)
        }.addDisposableTo(bag)
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        // 6.创建一个create的Obserable, 我们也可以自定义可观察的sequence，那就是使用create; create操作符传入一个观察者observer，然后调用observer的onNext，onCompleted和onError方法。返回一个可观察的obserable序列。
        let createO = createObserable()
        createO.subscribe { (event : Event<Any>) in
            print(event)
        }.addDisposableTo(bag)
        
        let myJustO = myJustObserable(element: "XiaoHange")
        myJustO.subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        
        // 7.创建一个Range的Obserable, count不能小于start, 否则crash;  ange就是创建一个sequence，他会发出这个范围中的从开始到结束的所有事件
        
        let rangeO = Observable.range(start: 1, count: 10)
        rangeO.subscribe { (event : Event<Int>) in
            print(event)
        }.addDisposableTo(bag)
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        
        
        // 8.repeatElement, 创建一个sequence，发出特定的事件n次
        let repeatO = Observable.repeatElement("Hello world!")
        repeatO.take(5).subscribe { (event : Event<String>) in
            print(event)
        }.addDisposableTo(bag)
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
        

    }

}

extension ViewController {
    fileprivate func createObserable() -> Observable<Any> {
        return Observable.create({ (observer : AnyObserver<Any>) -> Disposable in
            observer.onNext("xiaohange")
            observer.onNext("20")
            observer.onNext("1.78")
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
    
    fileprivate func myJustObserable(element : String) -> Observable<String> {
        return Observable.create({ (observer : AnyObserver<String>) -> Disposable in
            observer.onNext(element)
            observer.onCompleted()
            
            return Disposables.create()
        })
    }
}

