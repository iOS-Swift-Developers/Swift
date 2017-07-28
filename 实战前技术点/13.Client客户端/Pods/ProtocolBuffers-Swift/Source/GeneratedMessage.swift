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

public protocol GeneratedMessageProtocol: ProtocolBuffersMessage
{
    static func parseFrom(data: Data) throws -> Self
    static func parseFrom(data: Data, extensionRegistry:ExtensionRegistry) throws -> Self
    static func parseFrom(inputStream:InputStream) throws -> Self
    static func parseFrom(inputStream:InputStream, extensionRegistry:ExtensionRegistry) throws -> Self
    static func parseFrom(codedInputStream:CodedInputStream) throws -> Self
    static func parseFrom(codedInputStream:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> Self
}

open class GeneratedMessage:AbstractProtocolBuffersMessage
{
    public var memoizedSerializedSize:Int32 = -1
    required public init()
    {
        super.init()
       self.unknownFields = UnknownFieldSet(fields: [:])
    }
    
    //Override
    open class func className() -> String
    {
        return "GeneratedMessage"
    }
    open func className() -> String
    {
        return "GeneratedMessage"
    }
    open override class func classBuilder() -> ProtocolBuffersMessageBuilder
    {
        return GeneratedMessageBuilder()
    }
    open override func classBuilder() -> ProtocolBuffersMessageBuilder
    {
        return GeneratedMessageBuilder()
    }
    //
}

open class GeneratedMessageBuilder:AbstractProtocolBuffersMessageBuilder
{
    open var internalGetResult:GeneratedMessage
    {
        get
        {
            return GeneratedMessage()
        }
        
    }
    
    override open var unknownFields:UnknownFieldSet
    {
        get
        {
            return internalGetResult.unknownFields
        }

        set (fields)
        {
            internalGetResult.unknownFields = fields
        }
        
    }
    public func checkInitialized() throws
    {
        let result = internalGetResult
        
        guard result.isInitialized() else
        {
            throw ProtocolBuffersError.invalidProtocolBuffer("Uninitialized Message")
        }
    }
    
    public func checkInitializedParsed() throws
    {
        let result = internalGetResult
        guard result.isInitialized() else
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
    public func parse(codedInputStream:CodedInputStream ,unknownFields:UnknownFieldSet.Builder, extensionRegistry:ExtensionRegistry, tag:Int32) throws -> Bool {
        return try unknownFields.mergeFieldFrom(tag: tag, input:codedInputStream)
    }
}

extension GeneratedMessage:CustomDebugStringConvertible
{
    public var debugDescription:String {
            return description
    }
}

extension GeneratedMessage:CustomStringConvertible
{
    public var description:String {
        get {
            var output:String = ""
            output += try! getDescription(indent: "")
            return output
        }
    }
}

extension GeneratedMessageBuilder:CustomDebugStringConvertible
{
    public var debugDescription:String {
        return internalGetResult.description
    }
}
extension GeneratedMessageBuilder:CustomStringConvertible {
    public var description:String {
        get {
            return internalGetResult.description
        }
    }
}

