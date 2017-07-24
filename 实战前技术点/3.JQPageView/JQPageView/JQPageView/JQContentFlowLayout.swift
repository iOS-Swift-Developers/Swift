//
//  JQContentFlowLayout.swift
//  JQPageView
//
//  Created by 韩俊强 on 2017/7/19.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class JQContentFlowLayout: UICollectionViewFlowLayout {
    
    var cols : Int = 4
    var rows : Int = 2
    
    private lazy var attrsArray : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    private lazy var maxW : CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(cols) - 1) * minimumInteritemSpacing) / CGFloat(cols)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - CGFloat(rows - 1) * minimumLineSpacing) / CGFloat(rows)
        
        // 1.获取数据的多少组
        let sectionCount = collectionView!.numberOfSections
        
        // 2.给每组数据进行布局
        var pageNum = 0
        for section in 0..<sectionCount {
            let itemCount = collectionView!.numberOfItems(inSection: section)
            for item in 0..<itemCount {
                let indexPath = IndexPath(item: item, section: section)
                let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let page = item / (cols * rows)
                let index = item % (cols * rows)
                
                let x = (sectionInset.left + CGFloat(index % cols) * (itemW + minimumInteritemSpacing)) + collectionView!.bounds.width * CGFloat((page + pageNum))
                let y = sectionInset.top + CGFloat(index / cols) * (itemH + minimumLineSpacing)
                
                attrs.frame = CGRect(x: x, y: y, width: itemW, height: itemH)
                
                attrsArray.append(attrs)
            }
            
            let sectionNum = (itemCount - 1) / (cols * rows) + 1
            
            pageNum += sectionNum
        }
        
        // 3.计算最大的width
        maxW = CGFloat(pageNum) * collectionView!.bounds.width
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxW, height: 0)
    }
}
