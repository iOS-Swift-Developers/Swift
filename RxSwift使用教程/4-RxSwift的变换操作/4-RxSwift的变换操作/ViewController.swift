//
//  ViewController.swift
//  4-RxSwift的变换操作
//
//  Created by 韩俊强 on 2017/8/2.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import RxSwift

struct Student {
    var score : Variable<Double>
    
}

class ViewController: UIViewController {
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.Swift中如何使用map
        let array = [1, 2, 3, 4]
        
        /*
        var tempArray = [Int]()
        for num in array {
            tempArray.append(num * num)
        }
        let array2 = array.map { (num : Int) -> Int in
            return num * num
        }
        print(array)
        print(array2)
        */
        let array2 = array.map({$0 * $0})
        print(array2)
        
        // 2.在RxSwift中map函数的使用
        Observable.of(1, 2, 3, 4).map { (num : Int) -> Int in
            return num * num
            }.subscribe { (event : Event<Int>) in
            print(event)
        }.addDisposableTo(bag)
        
        
        print("~~~~~~~~~~~~~~~~~~~~~~~~~")

        
        // 3.flatMap使用
        let stu1 = Student(score: Variable(90))
        let stu2 = Student(score: Variable(100))
        
        let studentVariable = Variable(stu1)
        
        //Swift-flatMap
        studentVariable.asObservable().flatMap { (stu : Student) -> Observable<Double> in
            return stu.score.asObservable()
            }.subscribe { (event : Event<Double>) in
            print(event)
        }.addDisposableTo(bag)
        
        studentVariable.value = stu2
        stu2.score.value = 0
        stu1.score.value = 200
        
        
        
        
    }

}

