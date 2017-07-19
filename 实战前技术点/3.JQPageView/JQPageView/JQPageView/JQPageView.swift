//
//  JQPageView.swift
//  JQPageView
//
//  Created by 韩俊强 on 2017/7/18.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class JQPageView: UIView {
    
    // MARK: 定义属性
    fileprivate var titles : [String]!
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    fileprivate var style : JQTitleStyle!
    
    fileprivate var titleView : JQTitleView!
    fileprivate var contentView : JQContentView!
    
    // MARK: 自定义构造函数
    init(frame : CGRect, titles : [String], style : JQTitleStyle, childVCs : [UIViewController], parentVc : UIViewController) {
        super.init(frame: frame)
        
//        assert(titles.count == childVcs.count, "标题和控制前个数不同!") // 测试
        self.style = style
        self.titles = titles
        self.childVcs = childVCs
        self.parentVc = parentVc
        
        parentVc.automaticallyAdjustsScrollViewInsets = false
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置UI界面内容
extension JQPageView {
    fileprivate func setupUI() {
        let titleH : CGFloat = style.titleHeight
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView  = JQTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.delegate = self
        addSubview(titleView)
        
        let contentFrame = CGRect(x: 0, y: titleH, width: frame.width, height: frame.height - titleH)
        contentView = JQContentView(frame: contentFrame, childVcs: childVcs, parentViewController: parentVc)
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.delegate = self
        addSubview(contentView)
    }
}

// MARK:- 设置JQContentView的代理
extension JQPageView : JQContentViewDelegate {
    func contentView(_ contentView: JQContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func contentViewEndScroll(_ contentView: JQContentView) {
        titleView.contentViewDidEndScroll()
    }
}

// MARK:- 设置JQTitleView的代理
extension JQPageView : JQTitleViewDelegate {
    func titleView(_ titleView: JQTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}
