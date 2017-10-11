//
//  ViewController.swift
//  Swift4.0_Study
//
//  Created by 韩俊强 on 2017/10/11.
//  Copyright © 2017年 HaRi. All rights reserved.
//
/// 组织: https://github.com/iOS-Swift-Developers/Swift
///
/// iOS开发者交流群(官方付费群)：①群:446310206 ②群:426087546

import UIKit

/*
 Swift4.0 有哪些新改变呢？
 
 字符串String类型更加人性化，多行字符串文字，支持Range，也算集合类型
 改进的private的访问权限，私有访问修饰符
 更智能更安全的Key Value Coding 键值编码
 词典和集合
 归档和序列化
 单面范围
 通用下标
 MutableCollection.swapAt（ _ : _ )
 相关类型限制
 类和协议存在
 限制@objc推论
 */

class SwiftStudy: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // 1.字符串String类型更加人性化，多行字符串文字，支持Range，也算集合类型
        let galaxy = "Hi,XiaoHange"
        print(galaxy.count)      // 12
        print(galaxy.isEmpty)    // false
        print(galaxy.dropFirst())// i,XiaoHange
        print(galaxy.dropLast()) // Hi,XiaoHang
        let mStr = String(galaxy.reversed())
        print(mStr) //egnaHoaiX,iH
        
        // Filter out any none ASCII characters
        galaxy.filter { char in
            let isASCII = char.unicodeScalars.reduce( true, { $0 && $1.isASCII })
            return isASCII
        }
        
        print("=============更便捷的Range================")
        
        
        
        // 2.更便捷的Range
        // Swift3.0
        var str = "Hi, XiaoHanGe!"
        var index = str.index(of: " ")!
        let greeting = str[str.startIndex ..< index]
        index = str.index(index, offsetBy: 1) // index 下标 +1
        let name = str[index ..< str.endIndex]
        
        
        
        // Swift4.0
        var index1 = str.index(of: " ")!
        let greeting1 = str.prefix(upTo: index1)
        index1 = str.index(index1, offsetBy: 1)
        let name1 = str.suffix(from: index1)
        print(Array(str.enumerated()))
        print("======================\n")
        print(Array(zip(1..., str)))
        
        print("=============多行文字,通过一对三个双引号直接来赋值================")
            
        // 3.多行文字,通过一对三个双引号直接来赋值 """ """
        /// plist格式
        let plistInfo = """
        <?xml version="1.0" encoding="UTF-8"?>
        <plist version="1.0">
        <array>
           <dict>
              <key>title</key>
                  <string>小韩哥</string>
              <key>imageName</key>
                  <string>http://img.blog.csdn.net/20170217102843795</string>
           </dict>
        </array>
        </plist>
        """
        /// JSON格式
        let jsonInfo = """
        {
          "data": {
              "title": "小韩哥"
              "age": "23"
              "creat_at": "2017-10-11"
          }
        }
        """
        print(plistInfo)
        print(jsonInfo)
        
        print("=============集合用法================")
        
        // 4.集合用法
        // 字符串可以像集合那样进行遍历，直接通过.count知道字符串个数
        var str1 = "Hello, HaRi"
        print(str1.characters.count) // Swift3.0 写法
        print(str1.count)            // Swift4.0 写法
        /// 遍历
        str1.forEach {
            print($0)
        }
        
        
        
        
        // 5.改进的private的访问权限，私有访问修饰符
        /*
         Swift 3的一个元素，一些不太喜欢的是添加fileprivate
         。 从理论上讲，这是非常好的，但实际上它的使用往往会令人困惑。 目标是在成员本身中使用private的，并且在您想要在同一文件中的成员共享访问的情况下很少使用fileprivate。
         问题是Swift鼓励使用扩展将代码分解成逻辑组。 扩展被认为在原始成员声明范围之外，这导致对fileprivate的广泛需求。
         */
        struct SpaceCraft {
            private let warpCode : String
            fileprivate var name : String = "HaRi"
            
            init(warpCode: String) {
                self.warpCode = warpCode
            }
        }
        /*
        extension SpaceCraft {
            func goToWarpSpeed(warpCode: String) {
                if warpCode == self.warpCode { // Error in Swift 3 unless warpCode is fileprivate
                    print("Do it Scotty!")
                } else {
                    self.name += warpCode
                }
            }
        }
        */
        let enterprise = SpaceCraft(warpCode: "It's cool")
        ///enterprise.warpCode // error: 'warpCode' is inaccessible due to 'private' protection level enterprise.goToWarpSpeed(warpCode: "KirkIsCool") // "Do it Scotty!"
        /// 在extension文件里面也可以访问private的变量, fileprivate的变量了.
    
        
        
        
        
        // 6.更智能更安全的Key Value Coding 键值编码
        // 到目前为止，你可以参考函数而不调用它们，因为函数是Swift中的闭包. 你不能做的是保持对属性的引用, 而不实际访问属性保存的底层数据。
        struct Lightsber {
            enum Color {
                case blue, green, red
            }
            let color: Color
        }
        
        class ForceUser {
            var name: String
            var lightsaber: Lightsber
            var master: ForceUser?
            
            init(name: String, lightsaber: Lightsber, master: ForceUser? = nil) {
                self.name = name
                self.lightsaber = lightsaber
                self.master = master
            }
        }
        let sidious = ForceUser(name: "HaRi", lightsaber: Lightsber(color: .blue))
        let xiaoMing = ForceUser(name: "XiaoMing", lightsaber: Lightsber(color: .green))
        let xiaoLu = ForceUser(name: "XiaoLu", lightsaber: Lightsber(color: .red), master: xiaoMing)
        
        //在这种情况下, 你正在为ForceUser的name属性创建一个关键路径.然后通过将其传递给新的下标keyPath来使用此键路径.默认情况下,此下标现在可用于每种类型。
        //以下是使用关键路径深入到子对象，设置属性和构建关键路径引用的更多示例:
        /*
        // Create reference to the ForceUser.name key path
        let nameKeyPath = \ForceUser.name
        
        // Access the value from key path on instance
        let xiaoMingName = xiaoMing[KeyPath:nameKeyPath]  // "XiaoMing"
        
        // Use keypath directly inline and to drill down to sub objects
        let xiaoLuSaberColor = xiaoLu[KeyPath:\ForceUser.lightsaber.color] // red
        
        // Access a property on the object returned by key path
        let masterKeyPath = \ForceUser.master
        let xiaoLuMasterName = xiaoLu[KeyPath: masterKeyPath]?.name //xiaoMing
        
        // Change XiaoLu to the dark side using key path as a setter
        xiaoLu[KeyPath: masterKeyPath] = sidious
        xiaoLu.master?.name // HaRi
        // 通过 keyPath关键字来使用，*|*关键符号来获取key值,从而实现了键值编码
        */
        
        
        
        
        // 7.词典和集合
        let nearestStarNames = ["HaRi","XiaoLu","LeiLei","XiaoMing","GaoJin"]
        let nearestStarDistances = [4.24, 4.37, 4.37, 5.96, 7.78]
        
        // Dictionary from sequence of keys-values
        let stardistanceDict = Dictionary.init(uniqueKeysWithValues: zip(nearestStarNames, nearestStarDistances))
        print(stardistanceDict)
        // ["GaoJin": 7.78, "XiaoLu": 4.37, "HaRi": 4.24, "XiaoMing": 5.96, "LeiLei": 4.37]
        
        // 重复键处理
        // Random vote of people's favorite stars
        let favoriteStarVotes = ["HaRi","XiaoLu","LeiLei","XiaoMing","GaoJin"]
        
        // Merging keys with closure for conflicts
        let mergedKeysAndValues = Dictionary(zip(favoriteStarVotes, repeatElement(1, count: favoriteStarVotes.count)), uniquingKeysWith:+)
        // 上面的代码使用zip和速记+来通过添加两个冲突的值来解析重复的键。
        
        // 注意: 如果你不熟悉zip ，您可以在Apple的Swift文档中快速了解它过滤Dictionary和Set现在都可以将结果过滤到原始类型的新对象中:
        let closeStars = stardistanceDict.filter{ $0.value < 5.0 }
    
        // 字典映射
        // Dictionary获得了一个非常有用的方法来直接映射其值:
        let mappedCloseStars = closeStars.mapValues{ "\($0)" }
        
        // 字典默认值
        // 在Dictionary上访问某个值时, 常见的做法是使用nil coalescing运算符给出默认值,以防数值为nil
        let siriustance = mappedCloseStars["hello", default: "default"] // "default"
        
        // Subscript with a default value used for mutating
        var starWordsCount: [String: Int] = [:]
        for starName in nearestStarNames {
            let numWords = starName.split(separator: " ").count
            starWordsCount[starName, default: 0] += numWords
        }
        
        // 字典分组
        // Grouping sequences by computed key
        let starsByFirstLetter = Dictionary(grouping: nearestStarNames) { $0.first! }
        //当通过特定模式对数据进行分组时, 很方便
        
        // 预留容量
        starWordsCount.capacity
        starWordsCount.reserveCapacity(20)
        starWordsCount.capacity
        
        
        
        // 8.归档和序列化
        // 到目前为止, 在Swift中, 为了序列化和归档您的自定义类型, 您必须跳过一些环。对于class类型，你需要对NSObject进行子类化并实现NSCoding协议。
        // 像struct和enum这样的值类型需要许多hacks, 例如创建一个可以扩展NSObject和NSCoding的子对象
        
        struct CuriosityLog: Codable {
            enum Discovery: String, Codable {
                case rock, water, martian
                
            }
            var sol: Int
            var discoveries: [Discovery]
            
        }
        // Create a log entry for Mars sol 42
        let logSol42 = CuriosityLog(sol: 42, discoveries: [.rock, .rock, .rock, .rock])
        //在这个例子中，你可以看到，使Swift类型可Encodable和可Decodable所需的唯一Decodable是实现可编Codable协议。 如果所有属性都是Codable ，则协议实现由编译器自动生成
        
        let jsonEncoder = JSONEncoder()
        /*
        //注意：此提案的一部分仍在开发中, 未发布, 所以解码就不多举例
        // Encode the Date
        let jsonData = try jsonEncoder.encode(logSol42)
        // Create a String from the data
        let jsonString = String.init(data: jsonData, encoding: .utf8)
        */
        
        
        
        
        // 9.单面范围
        // 9.1为了减少冗长度并提高可读性，标准库现在可以使用单面范围来推断起始和终点索引。派上用场的一种方法是创建一个从索引到集合的开始或结束索引的范围：
        // Collection Subscript
        var planets = ["HaRi","XiaoLu","LeiLei","XiaoMing","GaoJin","Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
        let outsideAsteroudBelt = planets[4...] // Swift3.0  planets[4..<parents.endInde]
        let firstThree = planets[..<4] // Swift3.0 planets[parents.startInde..<4]
        // 以上可以看出, 单面范围减少了明确指定开始索引或结束索引的需要
        
        // 9.2无限序列: 当起始索引为可数类型时，它们还允许你定义无限Sequence
        var numberedPlanets = Array(zip(1..., planets))
        print(numberedPlanets)
        
        planets.append("Anmi")
        numberedPlanets = Array(zip(1..., planets))
        print(numberedPlanets)
        
        // 9.3模式匹配: 单面范围的另一个很好的用途是模式匹配
        func temperature(planetNumber: Int) {
            switch planetNumber {
            case ...2:
                print("8888")
            case 4...:
                print("7777")
            default:
                print("9999")
            }
        }
        temperature(planetNumber: 3)
        
        
        
        
        
        // 10.通用下标
        // 下标是使数据类型以简洁方式可访问的重要组成部分, 为了提高其有用性, 下标现在可以是通用的
        struct GenericDictionary<key: Hashable, Value> {
            private var data: [key: Value]
            
            init(data: [key: Value]) {
                self.data = data
            }
            
            subscript<T>(key: key) -> T? {
                return data[key] as? T
            }
        }
        // 在这个例子中, 返回类型是通用的, 你可以使用这个通用的下标, 如下所示:
        // Dictionary of type: [String: Any]
        var earthData = GenericDictionary(data: ["hisName":"Earth","waterHeight":20000])
        
        let hisName: String? = earthData["name"]
        
        let waterHeight: Int? = earthData["water"]
        
        
        // 11.MutableCollection.swapAt（ _ ： _ )
        // MutableCollection现在具有mutate方法swapAt(::), 交换给定索引值
        
        func bubbleSort<T: Comparable>(_ array: [T]) -> [T] {
            var sortedArray = array
            for i in 0..<sortedArray.count - 1 {
                for j in 1..<sortedArray.count {
                    if sortedArray[j-1] > sortedArray[j] {
                        sortedArray.swapAt(j-1, j) // New MutableCollection method
                    }
                }
            }
            return sortedArray
        }
          
        let resultArr = bubbleSort([3,1,6,2,4,9,5])
        print(resultArr)
        
        
        
        
        // 12.相关类型限制: 现在可以使用where子句来限制关联类型
        /*
        protocol Sequence {
            associatedtype Iterator : IteratorProtocol
            associatedtype SubSequence : Sequence where SubSequence.Iterator.Element == Iterator.Element
            
        }
        // 使用协议约束,许多associatedtype声明可以直接约束其值,而不必跳过环。https://github.com/apple/swift-evolution/blob/master/proposals/0142-associated-types-constraints.md
        */
        
        
        
        // 13.类和协议存在
        // 最终将其从Objective-C转换为Swift的功能是定义符合类和一组协议的类型的能力
        /*
        protocol MyProtocol {}
        class View{}
        class ViewSubclass: View, MyProtocol {
            var delegate: (View & MyProtocol)?
        }
        
        let myClass = MyClass()
        myClass.delegate = View()
        myClass.delegate = ViewSubclass()
        */
        // delegate的类型是View与Myprotocol 同时存在的类型, 我个人觉得可以把类和协议存在理解成一种自己新定义类型,把几个基本类型结合成一个新的对象。
        
        
        
        // 14.限制@objc推论
        // 要将Objective-C或Swift API公开, 请使用@objc编译器属性。
        // 在许多情况下，Swift编译器为您推断出这一点。 质量推理的三个主要问题是：
        // 1.潜在的二进制大小显着增加
        // 2.知道何时@objc会被推断不明显
        // 3.不经意间创建Objective-C选择器碰撞的机会增加。
        // Swift4.0 通过限制@objc的推论来解决这个问题; 这意味着在需要Objective-C的完整动态调度功能的情况下, 你需要使用@objc
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

