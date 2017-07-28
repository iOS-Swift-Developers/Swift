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


typealias ExtensionsValueType = Hashable & Equatable


open class ExtendableMessage : GeneratedMessage
{

    fileprivate var extensionMap:[Int32:Any] = [Int32:Any]()
    public var extensionRegistry:[Int32:ConcreateExtensionField] = [Int32:ConcreateExtensionField]()

    required public init()
    {
        super.init()
        
    }
    
    //Override
    override open class func className() -> String
    {
        return "ExtendableMessage"
    }
    override open func className() -> String
    {
        return "ExtendableMessage"
    }
    //
    
    public func isInitialized(object:Any) -> Bool
    {
        switch object
        {
        case let array as Array<Any>:
            for child in array
            {
                if (!isInitialized(object: child))
                {
                    return false
                }
            }
        case let array as Array<GeneratedMessage>:
            for child in array
            {
                if (!isInitialized(object: child))
                {
                    return false
                }
            }
        case let message as GeneratedMessage:
            return message.isInitialized()
        default:
            return true
        }
        
        return true
    }
    
    open func extensionsAreInitialized() -> Bool {
        let arr = Array(extensionMap.values)
        return isInitialized(object:arr)
    }
    
    internal func ensureExtensionIsRegistered(extensions:ConcreateExtensionField)
    {

        extensionRegistry[extensions.fieldNumber] = extensions
    }
    
    public func getExtension(extensions:ConcreateExtensionField) -> Any
    {
        ensureExtensionIsRegistered(extensions: extensions)
        if let value = extensionMap[extensions.fieldNumber]
        {
            return value
        }
        return extensions.defaultValue
    }
    public func hasExtension(extensions:ConcreateExtensionField) -> Bool
    {
        guard (extensionMap[extensions.fieldNumber] != nil) else
        {
            return false
        }
        return true
    }
    public func writeExtensionsTo(codedOutputStream:CodedOutputStream, startInclusive:Int32, endExclusive:Int32) throws
    {
        var keys = Array(extensionMap.keys)
        keys.sort(by: { $0 < $1 })
        for fieldNumber in keys {
            if (fieldNumber >= startInclusive && fieldNumber < endExclusive) {
                let extensions = extensionRegistry[fieldNumber]!
                let value = extensionMap[fieldNumber]!
                try extensions.writeValueIncludingTagToCodedOutputStream(value: value, output: codedOutputStream)
            }
        }
    }
    
    public func getExtensionDescription(startInclusive:Int32 ,endExclusive:Int32, indent:String) throws -> String {
        var output = ""
        var keys = Array(extensionMap.keys)
        keys.sort(by: { $0 < $1 })
        for fieldNumber in keys {
            if (fieldNumber >= startInclusive && fieldNumber < endExclusive) {
                let extensions = extensionRegistry[fieldNumber]!
                let value = extensionMap[fieldNumber]!
                output += try extensions.getDescription(value: value, indent: indent)
            }
            
        }
        return output
    }
    
    public func isEqualExtensionsInOther(otherMessage:ExtendableMessage, startInclusive:Int32, endExclusive:Int32) -> Bool {

        var keys = Array(extensionMap.keys)
        keys.sort(by: { $0 < $1 })
        for fieldNumber in keys {
            if (fieldNumber >= startInclusive && fieldNumber < endExclusive) {
                let value = extensionMap[fieldNumber]!
                let otherValue = otherMessage.extensionMap[fieldNumber]!
                return compare(lhs: value, rhs: otherValue)
            }
        }
        return true
    }
    
    private func compare(lhs:Any, rhs:Any) -> Bool
    {
        switch (lhs,rhs)
        {
        case (let value as Int32, let value2 as Int32):
            return value == value2
        case (let value as Int64, let value2 as Int64):
            return value == value2
        case (let value as Double, let value2 as Double):
            return value == value2
        case (let value as Float, let value2 as Float):
            return value == value2
        case (let value as Bool, let value2 as Bool):
            return value == value2
        case (let value as String, let value2 as String):
            return value == value2
        case (let value as Data, let value2 as Data):
            return value == value2
        case (let value as UInt32, let value2 as UInt32):
            return value == value2
        case (let value as UInt64, let value2 as UInt64):
            return value == value2
        case (let value as GeneratedMessage, let value2 as GeneratedMessage):
            return value == value2
        case (let value as [Int32], let value2 as [Int32]):
            return value == value2
        case (let value as [Int64], let value2 as [Int64]):
            return value == value2
        case (let value as [Double], let value2 as [Double]):
            return value == value2
        case (let value as [Float], let value2 as [Float]):
            return value == value2
        case (let value as [Bool], let value2 as [Bool]):
            return value == value2
        case (let value as [String], let value2 as [String]):
            return value == value2
        case (let value as Array<Data>, let value2 as Array<Data>):
            return value == value2
        case (let value as [UInt32], let value2 as [UInt32]):
            return value == value2
        case (let value as [UInt64], let value2 as [UInt64]):
            return value == value2
        case (let value as [GeneratedMessage], let value2 as [GeneratedMessage]):
            return value == value2
        default:
            return false
        }
    }
    
    private func getHash<T>(lhs:T) -> Int!
    {
        switch lhs
        {
        case let value as Int32:
            return getHashValue(lhs: value)
        case let value as Int64:
            return getHashValue(lhs: value)
        case let value as UInt32:
            return getHashValue(lhs: value)
        case let value as UInt64:
            return getHashValue(lhs: value)
        case let value as Float:
            return getHashValue(lhs: value)
        case let value as Double:
            return getHashValue(lhs: value)
        case let value as Bool:
            return getHashValue(lhs: value)
        case let value as String:
            return getHashValue(lhs: value)
        case let value as GeneratedMessage:
            return getHashValue(lhs: value)
        case let value as Data:
            return value.hashValue
        case let value as [Int32]:
            return getHashValueRepeated(lhs: value)
        case let value as [Int64]:
            return getHashValueRepeated(lhs: value)
        case let value as [UInt32]:
            return getHashValueRepeated(lhs: value)
        case let value as [UInt64]:
            return getHashValueRepeated(lhs: value)
        case let value as [Float]:
            return getHashValueRepeated(lhs: value)
        case let value as [Double]:
            return getHashValueRepeated(lhs: value)
        case let value as [Bool]:
            return getHashValueRepeated(lhs: value)
        case let value as [String]:
            return getHashValueRepeated(lhs: value)
        case let value as Array<Data>:
            return getHashValueRepeated(lhs: value)
        case let value as [GeneratedMessage]:
            return getHashValueRepeated(lhs: value)
        default:
            return nil
        }
    }

    private func getHashValueRepeated<T>(lhs:T) -> Int! where T:Collection, T.Iterator.Element:Hashable & Equatable
    {
        var hashCode:Int = 0
        for vv in lhs
        {
            hashCode = (hashCode &* 31) &+ vv.hashValue
        }
        return hashCode
    }
    
    private func getHashValue<T>(lhs:T) -> Int! where T:Hashable & Equatable
    {
        return lhs.hashValue
    }
    
    public func hashExtensionsFrom(startInclusive:Int32, endExclusive:Int32) -> Int {
        var hashCode:Int = 0
        var keys = Array(extensionMap.keys)
        keys.sort(by: { $0 < $1 })
        for fieldNumber in keys {
            if (fieldNumber >= startInclusive && fieldNumber < endExclusive) {
                let value = extensionMap[fieldNumber]!
                hashCode = (hashCode &* 31) &+ getHash(lhs: value)!

            }
        }
        return hashCode
    }
    
    
    public func extensionsSerializedSize() ->Int32 {
        var size:Int32 = 0
        for fieldNumber in extensionMap.keys {
            let extensions = extensionRegistry[fieldNumber]!
            let value = extensionMap[fieldNumber]!
            size += extensions.computeSerializedSizeIncludingTag(value: value)
        }
        return size
    }
}

open class ExtendableMessageBuilder:GeneratedMessageBuilder
{
    override open var internalGetResult:ExtendableMessage {
        get
        {
            return ExtendableMessage()
        }
        
    }
    
    
    override open func checkInitialized() throws
    {
        let result = internalGetResult
        if (!result.isInitialized())
        {
            throw ProtocolBuffersError.invalidProtocolBuffer("Uninitialized Message")
        }
    }
    
    override open func checkInitializedParsed() throws
    {
        let result = internalGetResult
        if (!result.isInitialized())
        {
            throw ProtocolBuffersError.invalidProtocolBuffer("Uninitialized Message")
        }
    }
    
    override open func isInitialized() -> Bool
    {
        return internalGetResult.isInitialized()
    }
    @discardableResult
    override open func merge(unknownField: UnknownFieldSet) throws -> Self
    {
        let result:GeneratedMessage = internalGetResult
        result.unknownFields = try UnknownFieldSet.builderWithUnknownFields(copyFrom: result.unknownFields).merge(unknownFields: unknownField).build()
        return self
    }
    
    override public func parse(codedInputStream:CodedInputStream ,unknownFields:UnknownFieldSet.Builder, extensionRegistry:ExtensionRegistry, tag:Int32) throws -> Bool {
        
        let message = internalGetResult
        let wireType = WireFormat.getTagWireType(tag: tag)
        let fieldNumber:Int32 = WireFormat.getTagFieldNumber(tag: tag)
        
        let extensions = extensionRegistry.getExtension(clName: type(of: message), fieldNumber: fieldNumber)
        
        if extensions != nil {
            if extensions!.wireType.rawValue == wireType {
                try extensions!.mergeFrom(codedInputStream: codedInputStream, unknownFields:unknownFields, extensionRegistry:extensionRegistry, builder:self, tag:tag)
                return true
            }
        }
        return try super.parse(codedInputStream: codedInputStream, unknownFields: unknownFields, extensionRegistry: extensionRegistry, tag: tag)
    }
    public func getExtension(extensions:ConcreateExtensionField) -> Any
    {
        return internalGetResult.getExtension(extensions: extensions)
    }
    public func hasExtension(extensions:ConcreateExtensionField) -> Bool {
        return internalGetResult.hasExtension(extensions: extensions)
    }
    @discardableResult
    public func  setExtension(extensions:ConcreateExtensionField, value:Any) throws -> Self  {
        let message = internalGetResult
        message.ensureExtensionIsRegistered(extensions: extensions)
        guard !extensions.isRepeated  else {
            throw ProtocolBuffersError.illegalArgument("Must call addExtension() for repeated types.")
        }
        message.extensionMap[extensions.fieldNumber] = value
        return self
    }
    @discardableResult
    public func addExtension<T>(extensions:ConcreateExtensionField, value:T) throws -> ExtendableMessageBuilder {
        
        let message = internalGetResult
        message.ensureExtensionIsRegistered(extensions: extensions)
        
        guard extensions.isRepeated else
        {
            throw ProtocolBuffersError.illegalArgument("Must call addExtension() for repeated types.")
        }        
        let fieldNumber = extensions.fieldNumber
        if let val = value as? GeneratedMessage
        {
            var list:[GeneratedMessage]! = message.extensionMap[fieldNumber] as? [GeneratedMessage] ?? []
            list.append(val)
            message.extensionMap[fieldNumber] = list
        }
        else
        {
            var list:[T]! = message.extensionMap[fieldNumber] as? [T] ?? []
            list.append(value)
            message.extensionMap[fieldNumber] = list
        }
        
        return self
    }
    @discardableResult
    public func setExtension<T>(extensions:ConcreateExtensionField, index:Int32, value:T) throws -> Self {
        let message = internalGetResult
        message.ensureExtensionIsRegistered(extensions: extensions)
        guard extensions.isRepeated else {
            throw ProtocolBuffersError.illegalArgument("Must call setExtension() for singular types.")
        }
        let fieldNumber = extensions.fieldNumber
        if let val = value as? GeneratedMessage
        {
            var list:[GeneratedMessage]! = message.extensionMap[fieldNumber] as? [GeneratedMessage] ?? []
            list[Int(index)] = val
            message.extensionMap[fieldNumber] = list
        }
        else
        {
            var list:[T]! = message.extensionMap[fieldNumber] as? [T] ?? []
            list[Int(index)] = value
            message.extensionMap[fieldNumber] = list
        }
        return self
    }

    @discardableResult
    public func  clearExtension(extensions:ConcreateExtensionField) -> Self {
        let message = internalGetResult
        message.ensureExtensionIsRegistered(extensions: extensions)
        message.extensionMap.removeValue(forKey: extensions.fieldNumber)
        return self
    }

    private func mergeRepeatedExtensionFields<T>(otherList:T, extensionMap:[Int32:Any], fieldNumber:Int32) -> [T.Iterator.Element] where T:Collection
    {
        var list:[T.Iterator.Element]! = extensionMap[fieldNumber] as? [T.Iterator.Element] ?? []
        list! += otherList
        return list!

    }
    
    public func mergeExtensionFields(other:ExtendableMessage) throws {
        let thisMessage = internalGetResult
        guard thisMessage.className() == other.className() else {
            throw ProtocolBuffersError.illegalArgument("Cannot merge extensions from a different type")
        }
        if other.extensionMap.count > 0 {
            var registry = other.extensionRegistry
            for fieldNumber in other.extensionMap.keys {
                let thisField = registry[fieldNumber]!
                
                let value = other.extensionMap[fieldNumber]!
                if thisField.isRepeated {
                    switch value
                    {
                    case let values as [Int32]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [Int64]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [UInt64]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [UInt32]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [Bool]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [Float]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [Double]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [String]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as Array<Data>:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    case let values as [GeneratedMessage]:
                        thisMessage.extensionMap[fieldNumber] = mergeRepeatedExtensionFields(otherList: values, extensionMap: thisMessage.extensionMap, fieldNumber: fieldNumber)
                    default:
                        break
                    }
                }
                else
                {
                    thisMessage.extensionMap[fieldNumber] = value
                }
                
            }
        }
    }

}


