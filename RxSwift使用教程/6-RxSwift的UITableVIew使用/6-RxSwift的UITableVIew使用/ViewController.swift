//
//  ViewController.swift
//  6-RxSwift的UITableVIew使用
//
//  Created by 韩俊强 on 2017/8/2.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var bag : DisposeBag = DisposeBag()
    fileprivate var heros : [Hero] = [Hero]()
    
    fileprivate lazy var heroVM : HeroViewModel = HeroViewModel(searchText:self.searchText)
    var searchText: Observable<String> {
        return searchBar.rx.text.orEmpty.throttle(0.5, scheduler: MainScheduler.instance)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.取出调整底部内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 2.给tableView绑定数据
        heroVM.heroVariable.asObservable().bind(to: tableView.rx.items(cellIdentifier:"HeroCellID", cellType: UITableViewCell.self)) { row, hero, cell in
            cell.textLabel?.text = hero.name
            cell.detailTextLabel?.text = hero.intro
            cell.imageView?.image = UIImage.init(named: hero.icon)
        }.addDisposableTo(bag)
        
        //  3.监听UITableView的点击
        tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            print(indexPath)
        }).addDisposableTo(bag)
        
        
        tableView.rx.modelSelected(Hero.self).subscribe(onNext: { (hero : Hero) in
            print(hero.name)
        }, onError: { (error : Error) in
            print(error)
        }, onCompleted: { 
            
        }).addDisposableTo(bag)
        
        
    }
    
    @IBAction func itemAction(_ sender: UIBarButtonItem) {
        let hero = Hero(dict: ["icon" : "nss", "name" : "xiaohange", "intro" : "最强王者!!"])
        heroVM.heroVariable.value = [hero]
    }

}

