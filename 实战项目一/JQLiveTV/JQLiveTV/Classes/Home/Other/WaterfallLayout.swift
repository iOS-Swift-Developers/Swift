//
//  WaterfallLayout.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//  欢迎加入iOS交流群: ①群:446310206 ②群:426087546

import UIKit

@objc protocol WaterfallLayoutDataSource : class {
    func waterfallLayout(_ latout : WaterfallLayout, indexPath : IndexPath) -> CGFloat
    @objc optional func numberOfColsInWaterfallLayout(_ layout : WaterfallLayout) -> Int
}

class WaterfallLayout: UICollectionViewFlowLayout {
    
    // MARK: 对外提供属性
    weak var dataSource : WaterfallLayoutDataSource?
    
    // MARK: 私有属性
    fileprivate lazy var attrsArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate var totalHeights : CGFloat = 0
    fileprivate lazy var colHeights : [CGFloat] = {
        let cols = self.dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        var colHeights = Array(repeating: self.sectionInset.top, count: cols)
        return colHeights
    }()
    fileprivate var maxH : CGFloat = 0
    fileprivate var startIndex = 0
}

extension WaterfallLayout {
    
    override func prepare() {
        super.prepare()
        
        // 1.获取item个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 2.获得列数
        let cols = dataSource?.numberOfColsInWaterfallLayout?(self) ?? 2
        
        // 3.计算Item的宽度
        let itemW = (collectionView!.bounds.width - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing) / CGFloat(cols)
        
        // 4.计算所有的item属性
        for i in startIndex..<itemCount {
            // 4.1.设置每一个Item位置相关的属性
            let indexPath = IndexPath(item: i, section: 0)
            
            // 4.2.根据位置创建Attributes属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 4.3.随机一个高度
            guard let height = dataSource?.waterfallLayout(self, indexPath: indexPath) else {
                fatalError("请设置数据源, 并实现对应的数据源方法")
            }
            
            // 4.4.取出最小列的位置
            var minH = colHeights.min()!
            let index = colHeights.index(of: minH)!
            minH = minH + height + minimumLineSpacing
            colHeights[index] = minH
            
            // 4.5.设置item属性
            attrs.frame = CGRect(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemW) * CGFloat(index), y: minH - height - self.minimumLineSpacing, width: itemW, height: height)
            attrsArray.append(attrs)
        }
        
        // 5.记录最大值
        maxH = colHeights.max()!
        
        // 6.给startIndex重新赋值
        startIndex = itemCount
    }
}

extension WaterfallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
}
