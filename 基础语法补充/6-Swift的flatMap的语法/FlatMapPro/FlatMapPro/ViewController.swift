//
//  ViewController.swift
//  FlatMapPro
//
//  Created by 韩俊强 on 2018/2/5.
//  Copyright © 2018年 HaRi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
     * FlatMap是函数式编程中的另外一个用法，主要是用于处理多组数据合并一组，和归约是不同的.
     */
    // Readuce:一组数据里所有的元素合并成一个元素。
    // FlatMap:多组数据里的所有元素合并成一组数据。
    // Swift中有两个FlatMap方法，可以接收两种不同的Lambda表达式
    //1.transform: Element throws -> ElementOfResult? 返回值为Optional的ElementOfResult
    //2.transform: Element throws -> Sequence 返回值为Sequence，不为Optional
    //描述：ElementOfResult: Returns an array containing the non-nil results of calling the given transformation with each element of this sequence. Sequence: Returns an array containing the concatenated results of calling the given transformation with each element of this sequence.
    // 解释：ElementOfResult不改变内部元素，仅仅删除掉nil的选项；Sequence把所有元素内部的元素也进行Flat(压平，合并到一起，concatenated)，并且不允许存在nil，必须把nil替换为默认值。
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //简单EX：
        let couple = [[1,2,3],[4,5,6],nil,[8,9,]]
        let nonnil = couple.flatMap({ (number) -> [Int]? in
            return number //返回元素[Int],为Int数组,并把nil过滤掉
        })
        
        let flatten = couple.flatMap({ (nummber) -> [Int] in
            return nummber ?? [7]//把所有元素[Int],Int数组合并成一个数组,并把nil用[7]仅有一个元素7的Int数组替换
        })
        
        print(nonnil) //[[1, 2, 3], [4, 5, 6], [8, 9]]
        print(flatten)//[1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        //复杂EX：
        let complex = [[1,2,3],[4,5,6],nil,[8,9,nil]]
        let simple = complex.flatMap({ (number) -> [Int] in
            //首先去除数组[8,9,nil]里的nil
            let non_sub_nil = number?.flatMap({ (sub) -> Int? in
                return sub
            })
            //其次concatenated压平
            return non_sub_nil ?? [7]
        })
        print(simple)//[1, 2, 3, 4, 5, 6, 7, 8, 9]

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

