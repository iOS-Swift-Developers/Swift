//
//  main.swift
//  字典
//
//  Created by 韩俊强 on 2017/6/8.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 字典定义: 键值对
 OC:
 NSDictionary *dict = [NSDictionary dictionaryWithObject:@"hjq" forKey:@"name"];
 NSLog(@"%@", dict);
 
 NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"name", @"hjq", @"age", @30, nil];
 NSLog(@"%@", dict);
 
 NSDictionary *dict = @{@"name":@"hjq", @"age":@25};
 NSLog(@"%@", dict);
 */

// key一定要是可以hash的(String, Int, Double, Bool), value没有要求
var dict = ["name":"hjq","age":25.5] as Any
print(dict)

//var dict1:Dictionary = ["name":"hjq","age":25.5] 废弃

var dict2:Dictionary<String,AnyObject> = ["name":"jq" as AnyObject,"age":25.5 as AnyObject]
print(dict2)

//var dict3:Dictionary<String:AnyObject> = ["name":"jq","age":34]  废弃

var dict4:[String:AnyObject] = ["name":"hjq" as AnyObject ,"age":30 as AnyObject ]
print(dict4)

//var dict5:[String:AnyObject] = Dictionary(dictionaryLiteral: ("name","hjq"),("age",28))
//print(dict5)  废弃

//3.0
//1.字典的定义使用[key:value,key:value]快速定义
let dic:[String:Any] = ["name":"zhang","age":12]
print(dic)

//数组字典
let arrDic:[[String:Any]] = [
  ["name":"hello","age":22],
  ["name":"hi","age":23]
]
print(arrDic)

//2.可变字典的增删改查
var dictionary:[String:Any] = ["name":"hjq","age":23]
print(dictionary)
/** key存在则为修改, key不存在则为添加 **/
//增加键值对
dictionary["score"] = 98
print(dictionary)

//修改键值对
dictionary["age"] = 80
print(dictionary)

//删除键值对
dictionary.removeValue(forKey: "name")
print(dictionary)

//删除键值对
// ps: 字典是通过key来定位的, 所有的key必须是可以 hash/哈希 的 (MD5是一种哈希, 哈希就是将字符串变成唯一的整数, 便于查找, 能提高字典遍历的速度)
//dictionary.removeValue(forKey: <#T##String#>)

//字典遍历
//写法一
for e in dictionary
{
    print("key = \(e.key) value = \(e.value)")
}

//写法二
for (key,value) in dictionary
{
    print("key = \(key) value = \(value)")
}

//字典合并
var dic5 = ["name":"hihello","age":23] as [String : Any]
let dic6 = ["teacher":"wang"]

for (key,value) in dic6
{
    dic5[key] = value
}
print(dic5)




