//
//  main.swift
//  数组的基本使用
//
//  Created by 韩俊强 on 2017/6/7.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 数组定义:
 OC:
 有值数组
 NSArray *arr0 = @[@1, @2, @3];
 NSArray *arr1 = [NSArray arrayWithObjects:@1, @2, @3, nil];
 NSLog(@"%@", arr1);
 
 空数组
 NSArray *arr2 = @[];
 NSArray *arr3 = [NSArray array];
 NSLog(@"%@", arr3);
 
 不可变数组:NSArray
 可变数组:NSMutableArray
*/

//有值数组
var arr0 = [1,2,3]
var arr1: Array = [1,2,3]
var arr2: Array<Int> = [1,2,3]
var arr3: [Int] = [1,2,3]
// var arr4: Int[] = [1,2,3] // 早期写法 已废弃

//空数组
//var arr5 = [] // 已废弃
var arr6 = [Int]()
var arr7 = Array<Int>()
print(arr7)

//不可变数组
let arr8 : [Int] = []
//可变数组
var arr9 : [String] = [String]()

/*
 元素类型
 OC:
 NSArray *arr = @[@1, @"lnj", @1.75];
 NSLog(@"%@", arr);
*/
var arr10 = [1,"hjq",1.65] as [Any]
print(arr10)
print(arr10[2])
// 打印结果:  [1, "hjq", 1.6499999999999999]
// 1.65

//如果想明确表示数组中存放的是不同类型的数据, 可以使用Any关键字, 表示数组中可以存放不同类型的数据
var arr11:Array<Any> = [1,"hjq",1.75]
print(arr11)
print(arr11[2])
// 打印结果:  [1, "hjq", 1.75]
// 1.75

/*
 数组操作
 1.获取长度
 OC:
 NSArray *arr = @[@1, @2, @3];
 NSLog(@"%tu", arr.count);
*/
var arr12 = [1,2,3]
print(arr12.count)

/*
 2.判断是否为空
 OC:
 NSArray *arr = @[];
 NSLog(@"%d", arr.count != 0);
*/
var arr13 = [1,2,3]
print(arr13.isEmpty)

/*
 3.检索
 OC:
 NSArray *arr = @[@1, @2, @3];
 NSLog(@"%@", arr[0]);
*/
var arr14 = [1,2,3,4]
print(arr14[0])

/*
 4.追加
 OC:
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 [arr addObject:@4];
 NSLog(@"%@", arr);
*/
var arr15 = [1,2,3]
arr15.append(4)
print(arr15)

var arr16 = [1,2,3]
arr16 += [4]
print(arr16)
arr16 += arr16[0...1] // 也可以借助自己数组元素追加
print(arr16)

/*
 5.插入
 OC:
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 [arr insertObject:@4 atIndex:0];
 NSLog(@"%@", arr);
*/
var arr17 = [1,2,3]
arr17.insert(4, at: 0)
print(arr17)

/*
 6.更新
 OC:
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 arr[0] = @8;
 NSLog(@"%@", arr);
*/
var arr18 = [1,2,3]
arr18[0] = 0
print(arr18)

/*
 7.删除
 OC:
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 [arr removeObject:@1];
 NSLog(@"%@", arr);
 
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 [arr removeLastObject];
 NSLog(@"%@", arr);
 
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 [arr removeAllObjects];
 NSLog(@"%@", arr);
*/
var arr19 = [1,2,3]
arr19.remove(at: 0)
print(arr19)

var arr20 = [1,2,3,4]
arr20.removeLast()
print(arr20)

var arr21 = [1,2,3,4]
arr21.removeFirst()
print(arr21)

var arr22 = [1,2,3,4]
arr22.removeAll(keepingCapacity: true) // 是否保持容量, 如果为true, 即使删除了容量依然存在, 容量是2的倍数
print(arr22)
print(arr22.capacity)
//注意: 如果数组是一个不可变数组不能更新/插入和删除
//第一个版本的不可变数组是可以修改的

/*
 Range
 OC:
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 [arr removeObjectsInRange:NSMakeRange(0, 2)];
 NSLog(@"%@", arr);
*/

//移除某区间位置的数组元素
var arr23 = [1,2,3]
//arr22.removeRange(Range(start: 0, end: 1)) 2.0写法 已废弃
arr23.removeSubrange(0...1)
print(arr23)

var arr24 = [1,2,3]
arr24.replaceSubrange(0..<1, with: [8])
print(arr24)

// 其实Range就是半闭区间
var range = 0...5
//range = 99 // 通过报错可以推断出类型
print(range) // 通过答应也可以推断出类型

/// 这个知识点需要再探索一次 range
//var range1:Range<Int> = 0...5
//var range2:Range<String>; // 必须遵守ForwardIndexType协议
// start 起点 end 终点
//var range3:Range<Int> = Range(start: 0, end: 5)
//var range4:Range<Int> = 0..<5

//print(range3)
//print(range4)







