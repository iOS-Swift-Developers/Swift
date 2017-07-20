//
//  ViewController.swift
//  瀑布流
//
//  Created by 韩俊强 on 2017/7/20.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class ViewController: UIViewController {
    
    
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = JQWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        
       return collectionView
    }()
    
    fileprivate lazy var cellCount : Int = 30
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
    }
}

// MARK:- 数据源代理方法
extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        if indexPath.item == cellCount - 1 {
            cellCount += 30
            collectionView.reloadData()
        }
        return cell
    }
}

// MARK:- JQWaterfallLayoutDataSource代理方法
extension ViewController : JQWaterfallLayoutDataSource {
    func numberOfCols(_ waterfall: JQWaterfallLayout) -> Int {
        return 3
    }
    func waterfall(_ waterfall: JQWaterfallLayout, item: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 100)
    }
}

