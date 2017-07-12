//
//  main.swift
//  for
//
//  Created by 韩俊强 on 2017/6/8.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 for循环
 格式: for (初始化表达式;循环保持条件;循环后表达式) {需要执行的语句}
 OC:
 int sum = 0;
 for (int i = 0; i <= 10; i++) {
 sum = i++;
 }
 NSLog(@"%d", sum);
 
 int sum = 0;
 int i = 0;
 for (; i <= 10; i++) {
 sum = i++;
 }
 NSLog(@"%d", sum);
 
 int sum = 0;
 int i = 0;
 for (; i <= 10; ) {
 sum = i++;
 i++;
 }
 NSLog(@"%d", sum);
 
 
 int sum = 0;
 int i = 0;
 for ( ; ; ) {
 sum = i++;
 i++;
 if (i > 10) {
 break;
 }
 }
 NSLog(@"%d", sum);
 
 int sum = 0;
 int i = 0;
 for ( ; ; ) {
 sum = i++;
 i++;
 NSLog(@"%d", sum);
 }
 如果只有一条指令for后面的大括号可以省略
 for后面的三个参数都可以省略, 如果省略循环保持语句, 那么默认为真
 
 
 Swift:
 0.for后的圆括号可以省略
 1.只能以bool作为条件语句
 2.如果只有条指令for后面的大括号不可以省略
 3.for后面的三个参数都可以省略, 如果省略循环保持语句, 那么默认为真
 
 */
// 2.0
//var sum:Int = 0
//for var i = 0; i <= 10 ; i++
//{
//    i += 1
//    sum = i
//}
//print(sum)

//var sum1:Int = 0
//var i1:Int = 0
//for ; i1 <= 10 ; i1++
//{
//    i1 += 1
//    sum1 = i1
//}
//print(sum1)

//var sum2:Int = 0
//var i2 = 0
//for ;i2 <= 10;
//{
//    i2 += 1
//    sum2 = i2
//}
//print(sum2)

//var sum3:Int = 0
//var i3 = 0
//for ; ;
//{
//    i3 += 1
//    sum3 = i3
//    if i3 > 10
//    {
//        break
//    }
//}
//print(sum3)

// 3.0 for in 代替

/*
 for in循环
 格式: for (接收参数 in 取出的参数) {需要执行的语句}
 for in含义: 从(in)取出什么给什么, 直到取完为止
 OC:
 for (NSNumber *i  in @[@1, @2, @3, @4, @5]) {
 NSLog(@"%@", i);
 }
 
 NSDictionary *dict = @{@"name":@"lnj", @"age":@30};
 for (NSArray *keys  in dict.allKeys) {
 NSLog(@"%@", keys);
 }
 
 NSDictionary *dict = @{@"name":@"lnj", @"age":@30};
 for (NSArray *keys  in dict.allValues) {
 NSLog(@"%@", keys);
 }
 
 Swift:
 for in 一般用于遍历区间或者集合
 */
var sum4:Int = 0
for i in 1..<10 // 会将区间的值一次赋值给i
{
    sum4 += i
}
print(sum4)

for dict in ["name":"xiaohange","age":23] as [String : Any]
{
    print(dict)
}

for (key, value) in ["name":"hjq", "age":24] as [String : Any]
{
    print("key = \(key) value = \(value)")
}

//这样就完成了对数组的遍历了, 但是还有另一个情况, 如果我们想知道每次遍历的索引怎么办呢,还有一种方法:
let numberList = [1,2,3,4]

for num in numberList.enumerated(){
    print("\(num.offset) \(num.element)")
}

for (index, item) in numberList.enumerated().reversed() {
    print(index,item)
}

//区间(Range)循环
var rs = "";
for i in 0...10 {
    rs += "\(i)"
}
print(rs)


/* --- 2017.07.12 更新 */
/* 0 ~ 50 的遍历 跨步 10
 此种方法相当于遍历开区间 0..<50, [0,50) 不会遍历最后一个数
 用法常见对数组的遍历，可防止数组取值越界
 */
for i in stride(from: 0, to: 50, by: 10) {
    print("i = \(i)")
}

/* 0 ~ 20  的遍历 跨步 5
 此种方法相当于遍历 0..<50 [0,50] 闭区间 会遍历最后一个数
 */
for j in stride(from: 0, through: 20, by: 5) {
    print("j = \(j)")
}

/*
 遍历元组 (实际跟遍历字典类似)
 */
let tupleArray = [("zhangShang",60,170.0),
                  ("liSi",77,175.0),
                  ("wangWu",80,180.0)]
for t in tupleArray {
    print("name : \(t.0), weight : \(t.1), height : \(t.2)")
}












