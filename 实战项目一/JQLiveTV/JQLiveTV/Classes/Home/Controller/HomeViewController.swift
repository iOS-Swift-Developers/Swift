//
//  HomeViewController.swift
//  JQLiveTV
//
//  Created by 韩俊强 on 2017/7/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
        setupContentView()
    }
    
    fileprivate func setupNavigationBar() {
        let logoImage = UIImage(named: "home_icon_live")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        
        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(collectionItemClick))
        
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchFrame)
        navigationItem.titleView = searchBar
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        
        let searchField = searchBar.value(forKey: "_searchField") as? UITextField
        searchField?.textColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    fileprivate func setupContentView() {
        // 1.获取数据
        let homeTypes = loadTypesData()
        
        // 2.创建主题内容
        let  style = JQTitleStyle()
        style.isShowCover = true
        style.isScrollEnable = true
        let pageFrame = CGRect.init(x: 0, y: kNavigationBarHeight + kStatusBarHeight, width: kScreenWidth, height: kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 44)
        
        let titles = homeTypes.map({ $0.title })
        var childVcs = [AnchorViewController]()
        for type in homeTypes {
            let anchorVc = AnchorViewController()
            anchorVc.homeType = type
            childVcs.append(anchorVc)
        }
        let pageView = JQPageView(frame: pageFrame, titles: titles, style: style, childVCs: childVcs, parentVc: self)
        view.addSubview(pageView)
    }
    
    fileprivate func loadTypesData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var tempArray = [HomeType]()
        for dict in dataArray {
            tempArray.append(HomeType(dict: dict))
        }
        return tempArray
    }
}

// MARK:- 事件处理
extension HomeViewController {
    @objc fileprivate func collectionItemClick(){
        print("点击了主页右侧item按钮")
    }
}
