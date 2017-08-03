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


//---------集合-字典---------

//1.字典的定义和创建
var airPorts:Dictionary<String,String> = ["TYO":"Tokyo","DUB":"Dublin"]
//2.字典的增加与替换
var dict = ["name":"刘德华","age":18,"height":180] as [String : Any]
print("dict：\(dict)")
//针对name的键修改
dict["name"] = "CoderSun"
print("修改name之后的dict：\(dict)")
//dict没有属性的直接加入
dict["gender"] = "男"
print("加入gender之后的dict：\(dict)")
//3.字典的合并
var dict2 = ["title":"老大"];

for (k,v) in dict2 {
    dict[k] = v;
}

print(dict)
//获取key对应的值
print("获取key对应的值：\(dict["gender"] ?? "nan")")
//移除一个key和其对应的值
dict.removeValue(forKey:"title")
print("移除一个元素之后的dict：\(dict)")

//的获取所有key和获取所有value //
print("未强转之前的所有key:\(dict.keys)")    // 打印出来还是字典，所以这里需要强制转换下
print("强转之后的所有key:\(Array(dict.keys))")
print(Array(dict.values))

//4.编程题
//4.1创建一个数组，增加10个元素，然后遍历将每个元素输出

var array6 = [String]()
array6.append("1")
array6.append("2")
array6.append("3")
array6.append("4")
array6.append("5")
array6.append("6")
array6.append("7")
array6.append("8")
array6.append("9")
array6.append("10")
print("array6：\(array6)")


for i in array6 {
    print(i)
}

print("--------------")

//4.2创建一个整型的Set，并随机添加10个数字，然后将Set中的元素按顺序打印出来

var set1 = Set<String>()
set1.insert("1")
set1.insert("2")
set1.insert("3")
set1.insert("4")
set1.insert("5")
set1.insert("6")
set1.insert("7")
set1.insert("8")
set1.insert("9")
set1.insert("10")

for i in set1.sorted() {
    print(i)
}

print("--------------")

//4.3 创建一个字典，往里面添加5个学员的学好和姓名，然后按键值打印出来


var studentDic = Dictionary <String,String>()

studentDic["1"] = "Lucy"
studentDic["2"] = "John"
studentDic["3"] = "Smith"
studentDic["4"] = "Aimee"
studentDic["5"] = "Amanda"

for (id,name) in studentDic {
    print(id,name)
}





