//
//  main.swift
//  while
//
//  Created by 韩俊强 on 2017/6/8.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 while循环
 格式:while(循环保持条件){需要执行的语句}
 OC:
 int i = 0;
 int sum = 0;
 while (i <= 10) {
 sum = i++;
 }
 
 while (i <= 10)
 sum = i++;
 
 NSLog(@"%d", sum);
 如果只有一条指令while后面的大括号可以省略
 
 Swift:
 0.while后的圆括号可以省略
 1.只能以bool作为条件语句
 2.如果只有条指令while后面的大括号不可以省略
 */

var i:Int = 0
var sum:Int = 0
while (i <= 5)
{
    i += 1
    sum = i
}
print("\(sum)")

var i1:Int = 0
var sum1:Int = 0
while i1 <= 10
{
    i1 += 1
    sum1 = i1
}
print(sum1)

/*
do while循环
格式:do while(循环保持条件) {需要执行的语句}
OC:
int i = 0;
int sum = 0;
do {
    sum = i++;
} while (i <= 10);
NSLog(@"%d", sum);

int i = 0;
int sum = 0;
do
sum = i++;
while (i <= 10);
NSLog(@"%d", sum);
如果只有一条指令if后面的大括号可以省略

Swift2.0之后变为 repeat while, do用于捕捉异常
0.while后的圆括号可以省略
1.只能以bool作为条件语句
2.如果只有条指令do后面的大括号不可以省略
*/

var i2:Int = 0
var sum2:Int = 0
repeat{
    i2 += 1
    sum2 = i2
}while(i2 <= 10)
print(sum2)

var i3:Int = 0
var sum3:Int = 0
repeat{
    i3 += 1
    sum3 = i3
}while i3 <= 10
print(sum3)









