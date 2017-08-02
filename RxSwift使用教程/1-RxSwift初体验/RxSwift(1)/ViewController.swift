//
//  ViewController.swift
//  RxSwift(1)
//
//  Created by 韩俊强 on 2017/8/1.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var testBtn1: UIButton!
    @IBOutlet weak var testBtn2: UIButton!
    
    @IBOutlet weak var testFiled1: UITextField!
    @IBOutlet weak var testFiled2: UITextField!
    
    @IBOutlet weak var testLabel1: UILabel!
    @IBOutlet weak var testLabel2: UILabel!
    
    @IBOutlet weak var testScrollView: UIScrollView!
    
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.监听按钮点击
        // 1.1.传统方式
//        testBtn1.addTarget(self, action: #selector(btn1Click(_ :)), for: .touchUpInside)
//        testBtn2.addTarget(self, action: #selector(btn2Click), for: .touchUpInside)

        // 1.2.RxSwift方式
        testBtn1.rx.tap.subscribe { (event : Event<()>) in
             print("点击了按钮1")
        }.addDisposableTo(bag)
        
        testBtn2.rx.tap.subscribe { (event : Event<()>) in
             print("点击了按钮2")
        }.addDisposableTo(bag)
    
        
        // 2.监听UITextField的文字变化
        // 2.1传统做法, 设置代理
//        testFiled1.delegate = self
//        testFiled2.delegate = self
        
        // 2.2.RxSwift, 订阅文字的改变
        /*
        testFiled1.rx.text.subscribe{ (event : Event<String?>) in
            print(event.element!!)
        }.addDisposableTo(bag)
        
        testFiled2.rx.text.subscribe{ (event : Event<String?>) in
            print(event.element!!)
        }.addDisposableTo(bag)
        */
        /*
        testFiled1.rx.text.subscribe(onNext: { (str : String?) in
            print(str!)
        }).addDisposableTo(bag)
        
        testFiled2.rx.text.subscribe(onNext: { (str : String?) in
            print(str!)
        }).addDisposableTo(bag)
        */
        
        // 3.将UITextFiled文字该百年的内容显示在Label中
        /*
        testFiled1.rx.text.subscribe(onNext: { (str : String?) in
            self.testLabel1.text = str
        }).addDisposableTo(bag)
        
        testFiled2.rx.text.subscribe(onNext: { (str : String?) in
            self.testLabel2.text = str
        }).addDisposableTo(bag)
        */
        testFiled1.rx.text.bind(to: testLabel1.rx.text).addDisposableTo(bag)
        testFiled2.rx.text.bind(to: testLabel2.rx.text).addDisposableTo(bag)
        
        
        // 4.KVO
        // 4.1.传统方式
//        testLabel1.addObserver(self, forKeyPath: "text", options: .new, context: nil)
//        testLabel1.addObserver(self, forKeyPath: "frame", options: .new, context: nil)
//        testLabel2.addObserver(self, forKeyPath: "text", options: .new, context: nil)
        
        // 4.2.RxSwift方式
        testLabel1.rx.observe(String.self, "text").subscribe(onNext: { (str : String?) in
            print(str!)
        }).addDisposableTo(bag)
        
        testLabel2.rx.observe(CGRect.self, "frame").subscribe(onNext: { (frame : CGRect?) in
            print(frame!)
        }).addDisposableTo(bag)
        
        testLabel2.rx.observe(String.self, "text").subscribe(onNext: { (str : String?) in
            print(str!)
        }).addDisposableTo(bag)
        
        
        // 5.UIScrolloView的滚动
        testScrollView.contentSize = CGSize(width: 1000, height: 0)
        
        // 5.1.传统代理方法
//        testScrollView.delegate = self
        // 5.2.RxSwift方式
        testScrollView.rx.contentOffset.subscribe(onNext: { (point : CGPoint) in
            print(point)
        }).addDisposableTo(bag)
        
        
    }
    
    // MARK:- 传统监听属性
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if testLabel1.isEqual(object) {
            if keyPath == "text" {
                print("testLabel1文字改变")
            } else {
                print("testLabel1Frame改变")
            }
        } else {
            print("testLabel2文字改变")
        }
    }

}

// MARK:- 传统按钮监听
extension ViewController {
    @objc fileprivate func btn1Click(_ btn : UIButton) {
        print("按钮1发生了点击")
    }
    
    @objc fileprivate func btn2Click() {
        print("按钮2发生了点击")
    }
}

// MARK:- 传统的代理监听
extension ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == testFiled1 {
            print("第一个输入框发生变化")
        } else {
            print("第二个输入框发生变化")
        }
        
        return true
    }
}

// MARK:- 传统的代理监听
extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }
}

