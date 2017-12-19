//
//  ViewController.swift
//  SortedArrayTest
//
//  Created by 韩俊强 on 2017/12/18.
//  Copyright © 2017年 HaRi. All rights reserved.
//

/*
 Swift开发者组织，汇聚Swift开源项目与实用开发技巧，Objective-C | Swift交流！官方付费QQ群:446310206|426087546
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testInitUnsortedSorts()
        testInitSortedDoesntResort()
        testSortedArrayCanUseArbitraryComparisonPredicate()
        testConvenienceInitsUseLessThan()
        testInsertAtBeginningPreservesSortOrder()
        testInsertInMiddlePreservesSortOrder()
        testInsertAtEndPreservesSortOrder()
        testInsertAtBeginningReturnsInsertionIndex()
        testInsertInMiddleReturnsInsertionIndex()
        testInsertAtEndReturnsInsertionIndex()
        testInsertInEmptyArrayReturnsInsertionIndex()
        testInsertEqualElementReturnsCorrectInsertionIndex()
        testInsertContentsOfPreservesSortOrder()
        testIndexOfFindsElementInMiddle()
        testIndexOfFindsFirstElement()
        testIndexOfFindsLastElement()
        testIndexOfReturnsNilWhenNotFound()
        testIndexOfReturnsFirstMatchForDuplicates()
        testsContains()
        testMin()
        testMax()
        testCustomStringConvertible()
        testCustomDebugStringConvertible()
        testFilter()
        testRemoveAtIndex()
        testRemoveSubrange()
        testRemoveFirst()
        testRemoveFirstN()
        testRemoveLast()
        testRemoveLastN()
        testRemoveAll()
        testRemoveElementAtBeginningPreservesSortOrder()
        testRemoveElementInMiddlePreservesSortOrder()
        testRemoveElementAtEndPreservesSortOrder()
        testIsEqual()
        testIsNotEqual()
    }
    
    func testInitUnsortedSorts() {
        let sut = SortedArray.init(unsorted: [3,2,4,1,5], areInIncreasingOrder: < )
        print(sut) //[1, 2, 3, 4, 5]
    }
    
    func testInitSortedDoesntResort() {
        // Warning: this is not a valid way to create a SortedArray
        let sut = SortedArray(sorted: [3,2,1])
        print(sut) //[3, 2, 1]
    }
    
    func testSortedArrayCanUseArbitraryComparisonPredicate() {
        struct Person {
            var firstName: String
            var lastName: String
        }
        let a = Person.init(firstName: "A", lastName: "Joe")
        let b = Person.init(firstName: "B", lastName: "HaRi")
        let c = Person.init(firstName: "C", lastName: "Lockey")
        
        var sut = SortedArray<Person> { $0.firstName > $1.lastName }
        sut.insert(contentsOf: [b,a,c])
        print(sut.map { $0.firstName }) //["B", "A", "C"]
    }
    
    func testConvenienceInitsUseLessThan() {
        let sut = SortedArray(unsorted: ["a","c","b"])
        print(sut)//["a", "b", "c"]
    }
    
    func testInsertAtBeginningPreservesSortOrder() {
        var sut = SortedArray(unsorted: 1...3)
        sut.insert(0)
        print(sut)//[0, 1, 2, 3]
    }
    
    func testInsertInMiddlePreservesSortOrder() {
        var sut = SortedArray(unsorted: 1...5)
        sut.insert(4)
        print(sut)//[1,2,3,4,4,5]
    }
    
    func testInsertAtEndPreservesSortOrder() {
        var sut = SortedArray(unsorted: 1...3)
        sut.insert(5)
        print(sut)//[1,2,3,5]
    }

    func testInsertAtBeginningReturnsInsertionIndex() {
        var sut = SortedArray(unsorted: [1,2,3])
        let index = sut.insert(0)
        print(index) //0
    }
    
    func testInsertInMiddleReturnsInsertionIndex() {
        var sut = SortedArray(unsorted: [1,2,3,5])
        let index = sut.insert(4)
        print(index) //3
    }
    
    func testInsertAtEndReturnsInsertionIndex() {
        var sut = SortedArray(unsorted: [1,2,3])
        let index = sut.insert(100)
        print(index) //3
    }
    
    func testInsertInEmptyArrayReturnsInsertionIndex() {
        var sut = SortedArray<Int>()
        let index = sut.insert(10)
        print(index) //0
    }
    
    func testInsertEqualElementReturnsCorrectInsertionIndex() {
        var sut = SortedArray(unsorted: [3,1,0,2,1])
        let index = sut.insert(1)
        print(index) //index == 1 || index == 2 || index == 3
    }
    
    func testInsertContentsOfPreservesSortOrder() {
        var sut = SortedArray(unsorted: [10,9,8])
        sut.insert(contentsOf: (7...11).reversed())
        print(sut) //[7,8,8,9,9,10,10,11]
    }
    
    func testIndexOfFindsElementInMiddle() {
        let sut = SortedArray(unsorted: ["a","z","r","k"])
        let index = sut.index(of: "k")
        print(index as Any)//1
    }
    
    func testIndexOfFindsFirstElement() {
        let sut = SortedArray(sorted: 1..<10)
        let index = sut.index(of: 1)
        print(index as Any)//0
    }
    
    func testIndexOfFindsLastElement() {
        let sut = SortedArray(sorted: 1..<10)
        let index = sut.index(of: 9)
        print(index as Any)//8
    }
    
    func testIndexOfReturnsNilWhenNotFound() {
        let sut = SortedArray(unsorted: "Hello World".characters)
        let index = sut.index(of: "h")
        print(index as Any)
    }
    
    func testIndexOfReturnsFirstMatchForDuplicates() {
        let sut = SortedArray(unsorted: "abcabcabc".characters)
        let index = sut.index(of: "c")
        print(index as Any) //6
    }
    
    func testsContains() {
        let sut = SortedArray(unsorted: "Lorem ipsum".characters)
        print(sut.contains(" "))
        print(sut.contains("a"))
    }
    
    func testMin() {
        let sut = SortedArray(unsorted: -10...10)
        print(sut.min() as Any)//-10
    }
    
    func testMax() {
        let sut = SortedArray(unsorted: -10...(-1))
        print(sut.max() as Any)//-1
    }
    
    func testCustomStringConvertible() {
        let sut = SortedArray(unsorted: ["a", "c", "b"])
        let description = String(describing: sut)
        print(description)//["a", "b", "c"] (sorted)
    }
    
    func testCustomDebugStringConvertible() {
        let sut = SortedArray(unsorted: ["a", "c", "b"])
        let description = String(reflecting: sut)
        print(description)//["a", "b", "c"] (sorted)
    }
    
    func testFilter() {
        let sut = SortedArray(unsorted: ["a", "b", "c"])
        print(sut.filter { $0 != "a" }) //["b", "c"]
    }
    
    func testRemoveAtIndex() {
        var sut = SortedArray(unsorted: [3,4,2,1])
        let removedElement = sut.remove(at: 1)
        print(sut)//[1,3,4]
        print(removedElement) //2
    }
    
    func testRemoveSubrange() {
        var sut = SortedArray(unsorted: ["a","d","c","b"])
        sut.removeSubrange(2..<4)
        print(sut)//["a","b"]
    }
    
    func testRemoveFirst() {
        var sut = SortedArray(unsorted: [3,4,2,1])
        let removedElement = sut.removeFirst()
        print(sut)//[2,3,4]
        print(removedElement)//1
    }
    
    func testRemoveFirstN() {
        var sut = SortedArray(unsorted: [3,4,2,1])
        sut.removeFirst(2)
        print(sut)//[3,4]
    }
    
    func testRemoveLast() {
        var sut = SortedArray(unsorted: [3,4,2,1])
        let removedElement = sut.removeLast()
        print(sut)//[1,2,3]
        print(removedElement)//4
    }
    
    func testRemoveLastN() {
        var sut = SortedArray(unsorted: [3,4,2,1])
        sut.removeLast(2)
        print(sut)//[1,2]
    }
    
    func testRemoveAll() {
        var sut = SortedArray(unsorted: ["a","d","c","b"])
        sut.removeAll()
        print(sut)//[]
    }
    
    func testRemoveElementAtBeginningPreservesSortOrder() {
        var sut = SortedArray(unsorted: 1...3)
        sut.remove(1)
        print(sut)//[2,3]
    }
    
    func testRemoveElementInMiddlePreservesSortOrder() {
        var sut = SortedArray(unsorted: 1...5)
        sut.remove(4)
        print(sut)//[1,2,3,5]
    }
    
    func testRemoveElementAtEndPreservesSortOrder() {
        var sut = SortedArray(unsorted: 1...3)
        sut.remove(3)
        print(sut)//[1,2]
    }
    
    func testIsEqual() {
        let sut = SortedArray(unsorted: [3,2,1])
        print(sut == SortedArray(unsorted: 1...3))//true
    }
    
    func testIsNotEqual() {
        let sut = SortedArray(unsorted: 1...3)
        print(sut != SortedArray(unsorted: 1...4))//true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

