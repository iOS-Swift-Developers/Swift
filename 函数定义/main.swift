//
//  main.swift
//  函数定义
//
//  Created by 韩俊强 on 2017/6/8.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
函数: 完成某个特定任务的代码块, 给代码起一个合适的名称, 称为函数名称; 以后需要执行代码块只需要利用函数名称调用即可.
格式:
func 函数名称(参数名:参数类型, 参数名:参数类型,...) -> 函数返回值 {函数实现部分}

OC:
- (void)sayHello
{
NSLog(@"hello");
}
- (void)sayWithName:(NSString *)name
{
NSLog(@"hello %@", name);
}
- (void)sayWithName:(NSString *)name age:(NSInteger)age
{
NSLog(@"hello %@ , I'm %tu years old", name, age);
}
- (NSString *)info
{
return @"name = lnj, age = 30";
}
- (NSString *)infoWithName:(NSString *)name age:(NSInteger)age
{
return [NSString stringWithFormat:@"name = %@, age = %tu", name, age];
}

Person *p = [[Person alloc] init];
[p sayHello];
[p sayWithName:@"lnj"];
[p sayWithName:@"lnj" age:30];
NSLog(@"%@", [p info]);
NSLog(@"%@", [p infoWithName:@"xiaohange" age:23]);
*/

// 无参无返回值
func say()->Void
{
    print("Hello")
}

func say1() // 如果没有返回值可以不写
{
    print("Hi")
}
say()
say1()

// 有参无返回值
func sayWithName(name:String)
{
    print("hello \(name)")
}
sayWithName(name: "xiaohange")

func sayWitchName1(name:String, age:Int) -> Void {
    print("hello \(name), I'm \(age) years old")
}
sayWitchName1(name: "baobao", age: 20)

// 无参有返回值
func info() -> String
{
    return "name = hjq, age = 28"
}
print(info())

// 有参有返回值
func info(name:String, age:Int) -> String
{
    return "name = \(name), age = \(age)"
}
print(info(name: "HaRi", age: 26))

/********** 嵌套函数 **********/
func showArray(array:[Int])
{
    for number in array {
        print("\(number)")
    }
}
showArray(array: [1,2,3,4,5])

/* 苹果自带api
func swap( a:inout Int, b:inout Int) // 2.0 是 func swaping(inout a:Int, inout b:Int) 废弃
{
    let temp = a
    a = b
    b = temp
}
*/

/*********** 冒泡排序,插入排序,选择排序,快速排序 ***********/
// 冒泡排序
func bubbleSort(array:inout [Int])
{
    func swap( a:inout Int, b:inout Int)
    {
        let temp = a
        a = b
        b = temp
    }
    for _ in 0..<array.count {  // 用不到的参数可以用 _ 代替
        for j in 0..<(array.count-1) {
            if array[j] > array[j + 1] {
//                let temp = array[j]
//                array[j] = array[j + 1]
//                array[j + 1] = temp
                swap(a: &array[j], b: &array[j + 1])
                
            }
        }
    }
    
}
var arr:Array<Int> = [10, 23, 22, 40, 6]
bubbleSort(array: &arr)
showArray(array: arr)

// 插入排序
var arr1:Array<Int> = [10, 34, 23, 9, 12]
for i in (0..<arr1.count) {
    
    var key = arr1[i]
    
    var j = i - 1
    
    while j >= 0 {
        
        if arr1[j] > key {
            arr1[j + 1] = arr1[j]
            arr1[j] = key
        }
        j -= 1
    }
}
print(arr1)

// 选择排序
var arr2:Array<Int> = [100, 304, 203, 90, 102]
for i in (0..<arr2.count - 1) {
    
    //    print(i)
    
    var index = i
    
    for j in (i..<arr2.count) {
        
        if arr2[index] > arr2[j] {
            
            index = j
        }
    }
    let tmp = arr2[i]
    arr2[i] = arr2[index]
    arr2[index] = tmp
    
}
print(arr2)


/*********** 两种快速排序: ***********/

// quick sort1
var array = [66,13,51,76,81,26,57,69,23]
func partition( list:inout [Int],left:Int,right:Int) -> Int{
    
    var pivot_index = left
    let piovt = list[left]
    
    for i in (left ... right) {
        
        print(i)
        
        if list[i] < piovt {
            
            pivot_index += 1
            
            if pivot_index != i {
                
                swap(&list[pivot_index], &list[i])
                
            }
        }
     }
    swap(&list[left], &list[pivot_index])
    return pivot_index
}
func quickSortArray( list:inout [Int],left:Int,right:Int) -> Void{
    
    if left < right {
        
        let pivot_index = partition(list: &list, left: left, right: right)
        
        quickSortArray(list: &list, left: left, right: pivot_index - 1)
        quickSortArray(list: &list, left: pivot_index + 1, right: right)
    }
}
quickSortArray(list: &array, left: 0, right: array.count - 1)
showArray(array: array)

// quick sort 2
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    let pivot = a[a.count/2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    return quicksort(less) + equal + quicksort(greater)
}

let list1 = [ 10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26 ]
print(quicksort(list1))





