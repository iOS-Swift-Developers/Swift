//
//  JQContentView.swift
//  JQPageView
//
//  Created by 韩俊强 on 2017/7/18.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit

@objc protocol JQContentViewDelegate : class {
    func contentView(_ contentView : JQContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
    
    @objc optional func contentViewEndScroll(_ contentView : JQContentView)
}

private let kContentCellID = "kContentCellID"

class JQContentView: UIView {

    // MARK: 对外属性
    weak var delegate : JQContentViewDelegate?
    
    // MARK: 定义属性
    fileprivate var childVcs : [UIViewController]!
    fileprivate weak var parentVc : UIViewController!
    fileprivate  var isForbidScrollDelegate : Bool = false
    fileprivate  var startOffsetX : CGFloat = 0
    
    // MARK: 控件属性
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = self.bounds
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }()
    
    // MARK: 构造函数
    init(frame : CGRect, childVcs : [UIViewController], parentViewController : UIViewController) {
        super.init(frame: frame)
        
        self.childVcs = childVcs
        self.parentVc = parentViewController
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置界面内容
extension JQContentView {
    fileprivate func setupUI() {
        // 1.将childVc添加到父控制器中
        for vc in childVcs {
            parentVc.addChildViewController(vc)
        }
        
        // 2.添加UICollectionView
        addSubview(collectionView)
    }
}

// MARK:- 遵守UICollectionViewDataSource的数据源代理方法
extension JQContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        // 2.设置Cell的内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

// MARK:- 遵守UICollectionViewDelegate协议
extension JQContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 2.定义获取需要的数据
        var progress : CGFloat = 0.0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 3.判断是向左滑还是向右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetInde
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全划出去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 4.将progress/sourceIndex/targetIndex 传递给titleView
        delegate?.contentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewEndScroll?(self)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.contentViewEndScroll?(self)
        }
    }
}

// MARK:- 对外暴露的方法
extension JQContentView {
    func setCurrentIndex(_ currentIndex: Int) {
        
        // 1.记录需要执行的代理方法
        isForbidScrollDelegate = true
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
