//
//  main.swift
//  数组其他操作
//
//  Created by 韩俊强 on 2017/6/8.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 数组的批量操作
 OC:
 NSMutableArray *arr = [NSMutableArray arrayWithObjects:@1, @2, @3, nil];
 NSRange range = NSMakeRange(0, 2);
 // [arr replaceObjectsInRange:range withObjectsFromArray:@[@99, @88]];
 [arr replaceObjectsInRange:range withObjectsFromArray:@[@99, @88, @77, @66]];
 NSLog(@"%@", arr);
 */
var arr = [1,2,3]
//arr[0...1] = [99,98]
//arr[0...1] = [99,88,77]
//等价于上一行代码
arr.replaceSubrange(0...1, with: [99,88,77])
print(arr)

/*
 4.遍历
 OC:
 NSArray *arr = @[@1, @2, @3];
 for (int i = 0; i < arr.count; i++) {
 NSLog(@"%@", arr[i]);
 }
 
 for (NSNumber *number in arr) {
 NSLog(@"%@", number);
 }
 */
var arr1 = [1,2,3]
// 2.0
//for var i = 0 ; i < arr1.count ; i++
//{
//    print(arr1[i])
//}
// 3.0
for i in 0..<arr1.count
{
    print(arr1[i])
}
for number in arr1
{
    print(number)
}

//取出数组中某个区间范围的值
var arr2 = [1,2,3]
for number in arr2[0..<3]
{
    print(number)
}






