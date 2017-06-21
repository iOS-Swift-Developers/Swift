//
//  main.swift
//  字符串常用方法
//
//  Created by 韩俊强 on 2017/6/1.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 计算字符串长度:
 C:
 char *stringValue = "abc李";
 printf("%tu", strlen(stringValue));
 打印结果6
 
 OC:
 NSString *stringValue = @"abc李";
 NSLog(@"%tu", stringValue.length);
 打印结果4, 以UTF16计算
*/
var stringVlaue = "abc韩"
print(stringVlaue.lengthOfBytes(using: String.Encoding.utf8))
// 打印结果:6, 和C语言一样计算字节数

/*
 字符串拼接
 C:
 char str1[] = "abc";
 char *str2 = "bcd";
 char *str = strcat(str1, str2);
 
 OC:
 NSMutableString *str1 = [NSMutableString stringWithString:@"abc"];
 NSString *str2 = @"bcd";
 [str1 appendString:str2];
 NSLog(@"%@", str1);
 
*/
var str1 = "abc"
var str2 = "hjq"
var str = str1 + str2
print(str)

/*
 格式化字符串
 C: 相当麻烦, 指针, 下标等方式
 OC:
 NSInteger index = 1;
 NSString *str1 = [NSMutableString stringWithFormat:@"http://ios.520it.cn/pic/%tu.png", index];
 NSLog(@"%@", str1);
*/
var index = 1
var str3 = "http://www.blog26.com/pic/\(index).png"
print(str3)

/*
 字符串比较:
 OC:
 NSString *str1 = @"abc";
 NSString *str2 = @"abc";
 if ([str1 compare:str2] == NSOrderedSame)
 {
 NSLog(@"相等");
 }else
 {
 NSLog(@"不相等");
 }
 
 if ([str1 isEqualToString:str2])
 {
 NSLog(@"相等");
 }else
 {
 NSLog(@"不相等");
 }
 
 Swift:(== / != / >= / <=), 和C语言的strcmp一样是逐个比较
*/

var str4 = "abc"
var str5 = "abc"
if str4 == str5
{
    print("相等")
}else
{
    print("不相等")
}

var str6 = "abd"
var str7 = "abc"
if str6 >= str7
{
    print("大于等于")
}else
{
    print("不大于等于")
}

/*
 判断前后缀
 OC:
 NSString *str = @"http://www.blog26.com";
 if ([str hasPrefix:@"http"]) {
 NSLog(@"是url");
 }
 
 if ([str hasSuffix:@".com"]) {
 NSLog(@"是天朝顶级域名");
 }
*/
var str8 = "http://www.blog26.com"
if str8.hasPrefix("www")
{
    print("是url")
}
if str8.hasSuffix(".com")
{
    print("是顶级域名")
}

/*
 大小写转换
 OC:
 NSString *str = @"abc.txt";
 NSLog(@"%@", [str uppercaseString]);
 NSLog(@"%@", [str lowercaseString]);
*/
var str9 = "abc.txt"
print(str9.uppercased())
print(str9.lowercased())

/*
 转换为基本数据类型
 OC:
 NSString *str = @"250";
 NSInteger number = [str integerValue];
 NSLog(@"%tu", number);
*/
var str10 = "250"
// 如果str不能转换为整数, 那么可选类型返回nil
// str = "250sd", 不能转换所以可能为nil
var numerber:Int? = Int(str10)
if numerber != nil
{
    print(numerber!) // 2.0可以自动拆包,3.0以后则不会
}









