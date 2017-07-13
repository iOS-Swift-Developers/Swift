//
//  main.swift
//  泛型
//
//  Created by 韩俊强 on 2017/7/11.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation

/*
 泛型: 之前我们介绍数组和可选型的时候, 我们已接触到泛型, 泛型代码可以确保写出灵活的, 可重用的函数
 */

/// 在Swift中, 有参数的函数必须指定参数的类型, 现在有几个同名的函数实现相似的功能, 但是参数的类型不同, 例如:
/*
func show(para:Int) {
    print("Hello \(para)")
}
func show(para:String) {
    print("Hello \(para)")
}
func show(para:Double) {
    print("Hello \(para)")
}
*/

//1.虽然系统可以根据参数类型调用不同的参数, 但在定义上这种方法太过冗余. 泛型所带来的好处就是可以通过定义单个函数来实现上面的功能. 使用泛型作为参数的函数叫做泛型函数, 下面是与上例有相同的泛型函数定义:

func show<T>(para:T) {
    print("Hello \(para)")
}
show(para: "小韩哥") // 输出"Hello 小韩哥"
show(para: 12) //输出 "Hello 12"


//2.泛型函数在声明时使用了节点类型命名(通常情况下用字母 T, U, V 这样的大写字母来表示)来代替实际类型名(如: Int, String 或 Double). 节点类型在定义时不表示任何具体类型, 在函数被调用时会根据传入的实际类型来制定自身的类型. 另外需要指出的是, 如果函数的泛型列表只有一个 T, 虽然具体类型不需要指定, 但是每个节点类型的参数必须是相同类型的. 例如:
func show1<T>(para:T,para2:T){}
//在调用这个函数时, 两个参数必须是相同的类型:
show1(para: 1, para2: 2)
show1(para: "小花", para2: "小明")


//3.定义多个不同类型的泛型,则需要在街括号中加入多个节点:<T,U,V> ;

//你可以对节点进行一些限制, 比如要求泛类型遵守某些协议, Swift中数组的判等就是这样定义的:
//public func ==<Element : Equatable>(lhs: [Element], rhs: [Element]) ->Bool

//Element 是节点声明的, 它代表一个泛型, 可以看到这里的泛型名是Element, 相比上面的"T","U","V"长的多. 这是因为此处的 Element不仅仅是一个占位符的作用, 它还声明了这个泛型代表数组中的元素类型, 有具体的意义, 这种 API 的设计指的我们借鉴;

//4.有时候节点中的泛型需要有更多的限制, 需要使用 where 子句来补充约束条件:
/*
func anyCommonElements<T : SquenceType, U : SequenceType>(lhs : T, _ rhs : U) -> Bool where
    T.Generator.Element: Equatable,
    T.Generator.Element == U.Generator.Element{
    return false
}
 */



/*
 泛型协议
 */
// 这里的Element不仅仅体现泛型的优势, 还隐性的约束了两个方法的参数必须是相同类型的.
protocol SomeProtocol {
    associatedtype Element
    func elementMethod1(element: Element)
    func elementMethod2(element: Element)
}

struct TestStruct:SomeProtocol {
    func elementMethod1(element: String) {
        print("elementMethod1: \(element)")
    }
    func elementMethod2(element: String) {
        print("elementMethod2: \(element)")
    }
}

// 类似于associatedtype的还有 self 关键字, 代表了协议遵守着本身的类型, 适用于比较这类方法, 其必须传入另一个相同类型的参数才有意义:
protocol CanCompare {
    func isBigger(other:Self) -> Bool
}

struct BoxInt:CanCompare {
    var intValue:Int
    func isBigger(other: BoxInt) -> Bool {
        return self.intValue > other.intValue
    }
}
print(BoxInt(intValue: 3).isBigger(other: BoxInt(intValue: 2))) //true


/*
 泛型对象:
 */
struct TestStruct2< T: Comparable > {
    func elementMethod3(element:T){
        print("elementMethod3:\(element)")
    }
    
    func elemetMethod4(element:T){
        print("elementMethod4:\(element)")
    }
}
let test = TestStruct2<Int>()
test.elementMethod3(element: 1) //elementMethod3:1

//注意:如果你尝试在实现时"嵌套"一个泛型,那么会呆滞泛型无法被特化; 比如数组本身是泛型的,在声明数组类型时传入了另一个泛型, 那么你将无法初始化该数组:
struct TestStruct3< T:Comparable >{
    
    var array:[T] = [1,3,4,5] as! [T] // as! [T]  这样貌似就能解决了, 但是这样泛型就没有意义了
    
}

/*
 泛型方法: 方法中的泛型使用节点表示法, 使用域只在本方法内,接上面案例修改:
 */
struct TestStruct4 {
    func elementMethod1< T: Comparable >(element:T){
        print("===elementMethod3:\(element)")
    }
    
    func elemetMethod2< T: Comparable >(element:T){
        print("===elementMethod4:\(element)")
    }
}
let test2 = TestStruct4()
test2.elementMethod1(element: 1)
test2.elemetMethod2(element: "abc")


/*
 协议中的 where 关键字:`
 在之前我们已接触到 where关键字, where 可以和 for in 循环配合实现筛选, where同样可以在协议扩展中;
 */
protocol SomeProtocol2 {
    associatedtype OwnElement
    func elementMethod1(element:OwnElement)
    func elementMethod2(element:OwnElement)
}
extension SomeProtocol2 where Self:Collection {
    func showCount(){
        print(self.count)
    }
}
extension Array:SomeProtocol2{

    func elementMethod1(element: String) {
        print("elementMethod1:\(element)")
    }
    func elementMethod2(element: String) {
        print("elementMethod2:\(element)")
    }
}
[1,2,3].showCount() //3


/*
 泛型特化: LLVM 编译将 C 和 OC 的代码放在一个低级的容器中, 然后编译成机器代码; 运行泛型并不是很安全;
 */

//知识点补充:
//输出常量和变量, 可以用print(_:separator:terminator:)函数来输出当前常量或变量的值:
//print(_:separator:terminator:)是一个用来输出一个或多个值到适当输出区的全局函数。如果用 Xcode，print(_:separator:terminator:)将会输出内容到“console”面板上。separator和terminator参数具有默认值，因此调用这个函数的时候可以忽略它们。默认情况下，该函数通过添加换行符来结束当前行。如果不想换行，可以传递一个空字符串给terminator参数--例如，print(someValue, terminator:"")。

func and<T>(first:T,_ second:T) {
    print(first,second, separator: "+", terminator: "")
}
and(first: 3, 5)
and(first: "a", "b")

// 此时 LLVM 在编译时会把 and 函数特化为:
func and(first:Int,_ second:Int){
    print(first,second, separator: "+", terminator: "")
}
//以及
func and(first:String,_ second:String){
    print(first,second, separator: "+", terminator: "")
}



