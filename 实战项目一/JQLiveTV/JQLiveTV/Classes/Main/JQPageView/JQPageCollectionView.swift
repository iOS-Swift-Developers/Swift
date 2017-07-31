//
//  JQPageCollectionView.swift
//  JQPageView
//
//  Created by 韩俊强 on 2017/7/19.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

protocol JQPageCollectionViewDataSource : class {
    func numberOfSections(in collectionView : UICollectionView) -> Int
    func pageCollectionView(_ collectionView : UICollectionView, numsOfItemsInSection section : Int) -> Int
    func pageCollectionView(_ collectionView : UICollectionView, cellForItemAtindexPath : IndexPath) -> UICollectionViewCell
}

@objc protocol JQPageCollectionViewDelegate : class {
    @objc optional func pageCollectionView(_ collectionView : UICollectionView, didSelected atIndexPath : IndexPath)
}

class JQPageCollectionView: UIView {

    // MARK:- 对外属性
    weak var dataSource : JQPageCollectionViewDataSource?
    weak var delegate : JQPageCollectionViewDelegate?
    
    // MARK:- 内部属性
    fileprivate var titles : [String]!
    fileprivate var style : JQTitleStyle!
    fileprivate var isTitleInTop : Bool = false
    fileprivate var layout : JQContentFlowLayout!
    
    fileprivate var titleView : JQTitleView!
    fileprivate var collectionView : UICollectionView!
    fileprivate var pageControl : UIPageControl!
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    init(frame: CGRect, titles : [String], style : JQTitleStyle, isTitleInTop : Bool, layout : JQContentFlowLayout) {
        super.init(frame: frame)
        
        self.titles = titles
        self.style = style
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
}

extension JQPageCollectionView {
    fileprivate func setupUI() {
        let titleH : CGFloat = 44
        let titleFrame = CGRect(x: 0, y: 0, width: frame.width, height: titleH)
        titleView = JQTitleView(frame: titleFrame, titles: titles, style: style)
        addSubview(titleView)
        titleView.delegate = self
        
        let  pageControlH : CGFloat = 20
        var pageControlFrame = CGRect(x: 0, y: 0, width: frame.width, height: pageControlH)
        pageControlFrame.origin.y = isTitleInTop ? frame.height - pageControlH : frame.height - titleH - pageControlH
        pageControl = UIPageControl(frame: pageControlFrame)
        pageControl.numberOfPages = 4
        pageControl.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        addSubview(pageControl)
        
        var collectionViewFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - titleH - pageControlH)
        collectionViewFrame.origin.y = isTitleInTop ? titleFrame.maxY : 0
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        addSubview(collectionView)
        
        setupUI()
    }
    
}


extension JQPageCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: collectionView) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numOfSection = dataSource?.pageCollectionView(collectionView, numsOfItemsInSection: section) ?? 0
        
        if section == 0 {
            let numOfPage = (numOfSection - 1) / (layout.cols * layout.rows) + 1
            pageControl.numberOfPages = numOfPage
        }
        
        return numOfSection
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.pageCollectionView(collectionView, cellForItemAtindexPath: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pageCollectionView?(collectionView, didSelected: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        collectionViewDidEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            collectionViewDidEndScroll()
        }
    }
    
    func collectionViewDidEndScroll() {
        
        // 获取该页第一个Cell
        let offsetX = collectionView.contentOffset.x
        let targetIndex = collectionView.indexPathForItem(at: CGPoint(x: offsetX + layout.sectionInset.left + 1, y: layout.sectionInset.top + 1))!
        
        pageControl.currentPage = (targetIndex.item) / (layout.cols * layout.rows)
        
        // 判断section发生改变
        if sourceIndexPath.section != targetIndex.section {
            titleView.setTitleWithProgress(1.0, sourceIndex: sourceIndexPath.section, targetIndex: targetIndex.section)
            
            sourceIndexPath = targetIndex
            
            let numOfSection = dataSource?.pageCollectionView(collectionView, numsOfItemsInSection: targetIndex.section) ?? 0
            let numOfPage = (numOfSection - 1) / (layout.cols * layout.rows) + 1
            pageControl.numberOfPages = numOfPage
        }
        
    }
}


extension JQPageCollectionView : JQTitleViewDelegate {
    func titleView(_ titleView: JQTitleView, selectedIndex index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        collectionView.contentOffset.x -= layout.sectionInset.left
        
        let numOfSection = dataSource?.pageCollectionView(collectionView, numsOfItemsInSection: indexPath.section) ?? 0
        let numOfPage = (numOfSection - 1) / (layout.cols * layout.rows) + 1
        pageControl.numberOfPages = numOfPage
        pageControl.currentPage = 0
        
        sourceIndexPath = indexPath
    }
}
