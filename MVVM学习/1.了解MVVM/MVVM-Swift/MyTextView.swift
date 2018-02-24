//
//  MyTextView.swift
//  MVVM-Swift
//
//  Created by 韩俊强 on 2018/2/23.
//  Copyright © 2018年 HaRi. All rights reserved.
//

import UIKit

class MyTextView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    fileprivate lazy var button: UIButton = {
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        btn.setTitle("hello", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.titleLabel?.textColor = UIColor.white
        btn.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        return btn
    }()
    
    var textViewModel: MyTextViewModel!
    init(viewModel: MyTextViewModel) {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        textViewModel = viewModel
        //添加子视图
        setupSubViews()
        //绑定 ViewModel,使用通知或者 KVO
        bindingViewModel()
        //请求数据
        textViewModel.requestData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
//        NotificationCenter.default.removeObserver(self)
        textViewModel.removeObserver(self, forKeyPath: "color")
    }
    
   
}

private var myContext = 0
fileprivate extension MyTextView {
    func setupSubViews() {
        addSubview(button)
    }
    
    func bindingViewModel() {
        /*
        //使用通知
        NotificationCenter.default.addObserver(forName: NSNotification.Name.init(kMyTextViewUpdateUI), object: nil, queue: OperationQueue.main) { [weak self] notify in
            guard let strongSelf = self else {
                return
            }
            strongSelf.backgroundColor = strongSelf.textViewModel.color
        }
        */
        
        //使用 KVO, 监听 color 属性的变化
        textViewModel.addObserver(self, forKeyPath: "color", options: [.old, .new], context: &myContext)
    }
    
    @objc func buttonClick() {
        print("hello")
        textViewModel.requestData()
    }
}

extension MyTextView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "color" {
            backgroundColor = textViewModel.color
        }
    }
}
