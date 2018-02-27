//
//  ViewController.swift
//  Swift_defer_Study
//
//  Created by 韩俊强 on 2018/2/27.
//  Copyright © 2018年 HaRi. All rights reserved.
//
//  Swift开发者组织，汇聚Swift开源项目与实用开发技巧，https://github.com/iOS-Swift-Developers
//  Objective-C | Swift交流！(手机加)QQ群:446310206|426087546

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

// Objective-C | Swift交流！(手机加)QQ群:446310206|426087546
/*
 1.defer 是干什么用的?
 
 很简单，用一句话概括，就是 defer block 里的代码会在函数 return 之前执行，无论函数是从哪个分支 return 的，还是有 throw，还是自然而然走到最后一行。
 
 这个关键字就跟 Java 里的 try-catch-finally 的 finally 一样，不管 try catch 走哪个分支，它都会在函数 return 之前执行。而且它比 Java 的 finally 还更强大的一点是，它可以独立于 try catch 存在，所以它也可以成为整理函数流程的一个小帮手。在函数 return 之前无论如何都要做的处理，可以放进这个 block 里，让代码看起来更干净一些~
 
 下面是 swift 文档上的例子：
 */
        var fridgeIsOpen = false
        let fridgeContent = ["milk", "eggs", "leftovers"]
        
        func fridgeContants(_ food: String) -> Bool {
            fridgeIsOpen = true
            defer {
                fridgeIsOpen = false
            }
            
            let result = fridgeContent.contains(food)
            return result
        }
        fridgeContants("banana")
        print(fridgeIsOpen)
        // 这个例子里执行的顺序是，先 fridgeIsOpen = true ，然后是函数体正常的流程，最后在 return 之前执行 fridgeIsOpen = false 。
        
/*************** 2.几个简单的使用场景 ************/
    /*
     1. try catch 结构
     
     最典型的场景，我想也是 defer 这个关键字诞生的主要原因吧：
     */
        func foo() {
            defer {
                print("finally")
            }
            do {
                throw NSError()
                print("impossible")
            } catch {
                print("handle error")
            }
        }
        //不管 do block 是否 throw error，有没有 catch 到，还是 throw 出去了，都会保证在整个函数 return 前执行 defer 。在这个例子里，就是先 print 出 "handle error" 再 print 出 "finally"。
    }
    
    
    // do block 里也可以写 defer :
    func fooSecond() {
        do {
            defer {
                print("finally")
            }
            throw NSError()
            print("impossible")
        } catch {
            print("handle error")
        }
    }
    //那么它执行的顺序就会是在 catch block 之前，也就是先 print 出 "finally" 再 print 出 "handle error"。
   
    /*
     2.清理工作、回收资源
     
     跟 swift 文档举的例子类似， defer 一个很适合的使用场景就是用来做清理工作。文件操作就是一个很好的例子：
     */
    // 关闭文件: 这样就不怕哪个分支忘了写，或者中间 throw 个 error，导致 fileDescriptor 没法正常关闭
    /*
    func fooThird() {
        let fileDescriptor = open(url.path, O_EVTONLY)
        defer {
            close(fileDescriptor)
        }
        // use fileDescriptor...
    }
    */
    
    // dealloc 手动分配的空间
    /*
    func fooFourth() {
        let valuePointer = UnsafeMutablePointer<T>.allocate(capacity: 1)
        defer {
            valuePointer.deallocate(capacity:1)
        }
        // use valuePointer
    }
    */
    
    // 加/解锁：下面是 swift 里类似 Objective-C 的 synchronized block 的一种写法，可以使用任何一个 NSObject 作 lock
    /*
    func fooFifth() {
        objc_sync_enter(lock)
        defer {
            objc_sync_exit(lock)
        }
        // do something...
    }
    */
    
    // 调 completion block: 这是一个让我感觉“如果当时知道 defer ”就好了的场景，就是有时候一个函数分支比较多，可能某个小分支 return 之前就忘了调 completion block，结果藏下一个不易发现的 bug。用 defer 就可以不用担心这个问题了：
    /*
    func fooSixth(completion: () -> Void) {
        defer {
            self.isLoading = false
            completion()
        }
        
        guard error == nil else { return }
        // handle success
    }
    */
    
    // 有时候 completion 要根据情况传不同的参数，这时 defer 就不好使了。不过如果 completion block 被存下来了，我们还是可以用它来确保执行后能释放：
    /*
    func fooSeventh() {
        defer {
            self.completion(.success(result))
        }
        if success {
            self.completion(.success(result))
        } else {
            self.completion(.error(error))
        }
    }
    */
    
    // 调 super 方法: 有时候 override 一个方法，主要目的是在 super 方法之前做一些准备工作，比如 UICollectionViewLayout 的 prepare(forCollectionViewUpdates:) ，那么我们就可以把调用 super 的部分放在 defer 里：
    /*
     func override fooEighth() {
        defer {
            super.fooEighth()
        }
        // some preparation befor super.fooEighth()...
    }
    */
    
/*************** 3.一些细节 ************/
    //1.任意 scope 都可以有 defer: 虽然大部分的使用场景是在函数里，不过理论上任何一个 { } 之间都是可以写 defer 的。比如一个普通的循环：
    /*
    var sumOfOdd = 0
    for i in 0...10 {
      defer {
       print("Look! It's \(i)")
      }
      if i % 2 == 0 {
        continue
     }
      sumOfOdd += i
    }
    */
    //2.continue 或者 break 都不会妨碍 defer 的执行。甚至一个平白无故的 closure 里也可以写 defer ：
//    {
//    defer { print("bye!") }
//    print("hello!")
//    }
    
    //3.必须执行到 defer 才会触发: 假设有这样一个问题：一个 scope 里的 defer 能保证一定会执行吗？ 答案是否……比如下面这个例子：
    /*
     func foo() throws {
      do {
        throw NSError()
        print("impossible")
       }
       defer {
        print("finally")
       }
     }
     try?foo()
     */
    
    //4.不会执行 defer，不会 print 任何东西。这个故事告诉我们，至少要执行到 defer 这一行，它才保证后面会触发。同样道理，提前 return 也是一样不行的：
    /*
    func foo() {
        guard false else { return }
        defer {
            print("finally")
        }
    }
    */
    
    //5.多个 defer: 一个 scope 可以有多个 defer，顺序是像栈一样倒着执行的：每遇到一个 defer 就像压进一个栈里，到 scope 结束的时候，后进栈的先执行。如下面的代码，会按 1、2、3、4、5、6 的顺序 print 出来。 但是我强烈建议不要这么写。我是建议一个 scope 里不要有多个 defer，感觉除了让读代码的人感觉混乱之外没有什么好处。
    /*
    func foo() {
        print("1")
        defer {
            print("6")
        }
        print("2")
        defer {
            print("5")
        }
        print("3")
        defer {
            print("4")
        }
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

