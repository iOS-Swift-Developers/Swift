//
//  main.swift
//  函数类型
//
//  Created by 韩俊强 on 2017/6/9.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 函数类型:
 类似于C语言的指向函数的指针
 类似于OC语言的block
 函数类型是由函数的参数类型和返回值类型组成的
 */

// 这两个函数类型为: (Int, Int) -> Int
func sum(a: Int, b: Int) -> Int
{
    return a + b
}

func sub(a: Int, b: Int) -> Int
{
    return a - b
}

// 可以利用函数类型定义函数变量和常量
var funcP:(Int, Int) -> Int = sum
//funcP = sub  // 赋与同一类型都可以
print(funcP(10,20))

// 函数类型可以作为函数的参数
func calFunc(a: Int, b: Int, Option:(Int, Int) -> Int) -> Int
{
    return Option(a, b)
}
print(calFunc(a: 10, b: 20, Option: sum))
print(calFunc(a: 10, b: 20, Option: sub))

// 函数类型可以作为返回值
func max(a: Int, b: Int) -> Int
{
    return a > b ? a : b
}
func min(a: Int, b: Int) -> Int
{
    return a > b ? b : a
}

func chooseFunc(getMax:Bool) -> (Int, Int) -> Int
{
    return getMax ? max : min
}

var funcP2:(Int, Int) -> Int = chooseFunc(getMax: true)
print(funcP2(10, 20))


