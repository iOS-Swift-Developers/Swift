// Protocol Buffers for Swift
//
// Copyright 2014 Alexey Khohklov(AlexeyXo).
// Copyright 2008 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License")
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

public typealias AnyClassType = GeneratedMessage.Type

public protocol ExtensionField 
{
    var fieldNumber:Int32 {get set}
    var extendedClass:AnyClassType {get}
    var wireType:WireFormat {get}
    func writeValueIncludingTagToCodedOutputStream(value:Any, output:CodedOutputStream) throws
    func computeSerializedSizeIncludingTag(value:Any) throws -> Int32
    func getDescription(value:Any, indent:String) throws -> String
    func mergeFrom(codedInputStream:CodedInputStream, unknownFields:UnknownFieldSet.Builder, extensionRegistry:ExtensionRegistry, builder:ExtendableMessageBuilder, tag:Int32) throws
    
}

public class ExtensionRegistry 
{
    private var classMap:[String : [Int32 : ConcreateExtensionField]]
    
    public init()
    {
        self.classMap = [:]
    }
    public init(classMap:[String : [Int32 : ConcreateExtensionField]])
    {
        self.classMap = classMap
    }
    
    public func getExtension(clName:AnyClassType, fieldNumber:Int32) -> ConcreateExtensionField? {
        
        let extensionMap = classMap[clName.className()]
        if extensionMap == nil
        {
            return nil
        }
        return extensionMap![fieldNumber]
    }
    
    public func addExtension(extensions:ConcreateExtensionField)
    {
        let extendedClass = extensions.extendedClass.className()
        var extensionMap = classMap[extendedClass]
        if extensionMap == nil
        {
            extensionMap = [Int32 : ConcreateExtensionField]()
           
        }
        extensionMap![extensions.fieldNumber] = extensions
        classMap[extendedClass] = extensionMap
        
    }
    
}
