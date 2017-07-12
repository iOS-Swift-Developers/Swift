//
//  main.swift
//  break-continue
//
//  Created by 韩俊强 on 2017/6/8.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 break: 跳出循环, 无论循环保持条件是否还为真都不会再执行循环
 continue: 跳出本次循环, 如果循环保持条件还为真还会继续执行循环
 
 OC:
 NSArray *arr = @[@1,@3, @5, @7, @8];
 for (NSNumber *num in arr) {
 if ([num isEqualTo:@(7)]) {
 NSLog(@"找到幸运数字");
 break;
 }
 NSLog(@"没有找到幸运数字");
 }
 
 NSArray *arr = @[@1,@3, @5, @7, @8];
 int count = 0;
 for (NSNumber *num in arr) {
 if (num.intValue % 2 != 0 ) {
 NSLog(@"不能被2整除");
 continue;
 }
 NSLog(@"能被2整除");
 count++;
 }
 NSLog(@"count = %d", count);
 */

var arr:Array<Int> = [1,2,3,4,5,6]
for num in arr{
    if num == 7
    {
        print("找到你了")
        break
    }
    print("没有找到")
}

var arr1:Array<Int> = [1,2,3,4,5,6,7,8]
var count:Int = 0
for num in arr1{
    if num % 2 != 0
    {
        print("不能被2整除")
        continue
    }
    print("能被2整除")
    count += 1
}
print("count = \(count)")







