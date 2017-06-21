//
//  main.swift
//  元祖
//
//  Created by 韩俊强 on 2017/6/1.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 元祖:
 在其它语言中很早就是有元祖这个概念, 但是对于OC程序员来说这是一个新的概念
 将多个相同或者不同类型的值用一个小括号括起来就是一个元祖
 */
let student = ("xiaohange",30,99.8)
print(student)
print(student.0)
print(student.1)
print(student.2)
/*
元祖其实和结构体很像, 只是不需要提前定义类型, 那么如果不定义类型元祖是什么类型呢?
元祖其实是符合类型, 小括号可以写任意类型
*/

let student1:(String, Int, Double) = ("hello",30,19.9)
/*
元祖的其他定义方式:指明应用元祖元素的名称
*/
let student2 = (name:"hi",age:20,core:99.2)
print(student2.name)
print(student2.age)
print(student2.core)

/*
元祖的其他定义方式:
通过指定的名称提取元祖对应的值, 会将对应位置的值赋值给对应位置的名称
*/
let (name, age, score) = ("xioahan", 30 ,99.9)
print(name)
print(age)
print(score)

/*
 如果不关心元祖中的某个值可以利用_通配符来忽略提取
*/
let (name1, age1, _) = ("hello", 30, 99.9)
print(name1)
print(age1)

/*
 以前没有元祖之前C和OC语言是通过传入指针或者凡是结构体的方式来返回多个值的,而有了元祖之后就可以实现让一个函数返回多个值
 */

