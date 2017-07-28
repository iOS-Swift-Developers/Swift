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

public func ==(lhs:Field, rhs:Field) -> Bool
{
    var check = (lhs.variantArray == rhs.variantArray)
    check = check && (lhs.fixed32Array == rhs.fixed32Array)
    check = check && (lhs.fixed64Array == rhs.fixed64Array)
    check = check && (lhs.groupArray == rhs.groupArray)
    check = check && (lhs.lengthDelimited == rhs.lengthDelimited)
    return check
}

//public func ==(lhs:Array<Array<UInt8>>, rhs:Array<Array<UInt8>>) -> Bool
//{
//    if lhs.count == rhs.count
//    {
//        for (var i = 0; i < lhs.count; i++)
//        {
//            var lbytes = lhs[i]
//            var rbytes = rhs[i]
//            
//            if lbytes.count == rbytes.count
//            {
//                if lbytes == rbytes
//                {
//                    continue
//                }
//                else
//                {
//                    return false
//                }
//            }
//            else
//            {
//                return false
//            }
//        }
//        return true
//    }
//    return false
//}
//
//
//
//public func ==(lhs:Array<UInt8>, rhs:Array<UInt8>) -> Bool
//{
//    if lhs.count == rhs.count
//    {
//        for (var i = 0; i < lhs.count; i++)
//        {
//            var lbytes = lhs[i]
//            var rbytes = rhs[i]
//            if lbytes != rbytes
//            {
//                return false
//            }
//        }
//        return true
//    }
//    return false
//}

//public protocol FieldOverload
//{
//    func +=(inout left:Field, right:Int64)
//    func +=(inout left:Field, right:Int32)
//    func +=(inout left:Field, right:UInt64)
//    func +=(inout left:Field, right:UInt32)
//}

public func +=(left:Field, right:Int64)
{
    left.variantArray += [right]
}

public func +=(left:Field, right:Int32)
{
    var result:Int64  = 0
    result = WireFormat.convertTypes(convertValue: right, defaultValue:result)
    left.variantArray += [result]
}

public func +=(left:Field, right:UInt32)
{
    left.fixed32Array += [UInt32(right)]
}

public func +=(left:Field, right:UInt64)
{
    left.fixed64Array += [UInt64(right)]
}

final public class Field:Equatable,Hashable
{
    public var variantArray:Array<Int64>
    public var fixed32Array:Array<UInt32>
    public var fixed64Array:Array<UInt64>
    public var lengthDelimited:Array<Data>
    public var groupArray:Array<UnknownFieldSet>
    
  
    
    public init()
    {
        
        variantArray = [Int64](repeating: 0, count: 0)
        fixed32Array = [UInt32](repeating: 0, count: 0)
        fixed64Array = [UInt64](repeating: 0, count: 0)
        lengthDelimited = Array<Data>()
        groupArray = Array<UnknownFieldSet>()
    }
    
    public func getSerializedSize(fieldNumber:Int32) -> Int32
    {
        var result:Int32 = 0
    
        for value in variantArray
        {
            result +=  value.computeInt64Size(fieldNumber: fieldNumber)
        }
        
        for value in fixed32Array
        {
            result +=  value.computeFixed32Size(fieldNumber: fieldNumber)
        }
        
        for value in fixed64Array
        {
            result +=  value.computeFixed64Size(fieldNumber: fieldNumber)
        }

        for value in lengthDelimited
        {
            result += value.computeDataSize(fieldNumber: fieldNumber)
        }

        for  value in groupArray
        {
            result += value.computeUnknownGroupSize(fieldNumber: fieldNumber)
        }
        
        return result
    }
    
    public func getSerializedSizeAsMessageSetExtension(fieldNumber:Int32) -> Int32 {
        var result:Int32 = 0
        for value in lengthDelimited {
            result += value.computeRawMessageSetExtensionSize(fieldNumber: fieldNumber)
        }
        return result
    }
    
    public func writeTo(fieldNumber:Int32, output:CodedOutputStream) throws
    {

        for value in variantArray
        {
            try output.writeInt64(fieldNumber: fieldNumber, value:value)
        }
        for value in fixed32Array
        {
            try output.writeFixed32(fieldNumber: fieldNumber, value: value)
        }
        for value in fixed64Array
        {
            try output.writeFixed64(fieldNumber: fieldNumber, value:value)
        }
        for value in lengthDelimited
        {
            try output.writeData(fieldNumber: fieldNumber, value: value)
        }
        for value in groupArray
        {
            try output.writeUnknownGroup(fieldNumber: fieldNumber, value:value)
        }

    }
    
    public func getDescription(fieldNumber:Int32, indent:String) -> String
    {
        var outputString = ""
        for value in variantArray
        {
            outputString += "\(indent)\(fieldNumber): \(value)\n"
        }

        for value in fixed32Array
        {
            outputString += "\(indent)\(fieldNumber): \(value)\n"
        }

        for value in fixed64Array
        {
            outputString += "\(indent)\(fieldNumber): \(value)\n"
        }
        
        for value in lengthDelimited
        {
            outputString += "\(indent)\(fieldNumber): \(value)\n"
        }
        
        for value in groupArray
        {
            outputString += "\(indent)\(fieldNumber)[\n"
            outputString += value.getDescription(indent: indent)
            outputString += "\(indent)]"
        }
        return outputString

    }
    
    public func writeAsMessageSetExtensionTo(fieldNumber:Int32, codedOutputStream:CodedOutputStream) throws
    {
        for value in lengthDelimited
        {
            try codedOutputStream.writeRawMessageSetExtension(fieldNumber: fieldNumber, value: value)
        }
    }
    
    public var hashValue:Int {
        get {
            var hashCode = 0
            
            for value in variantArray
            {
                hashCode = (hashCode &* 31) &+ value.hashValue
            }
            for value in fixed32Array
            {
                hashCode = (hashCode &* 31) &+ value.hashValue
            }
            for value in fixed64Array
            {
                hashCode = (hashCode &* 31) &+ value.hashValue
            }
            for value in lengthDelimited
            {
                    hashCode = (hashCode &* 31) &+ value.hashValue
            }
            for value in groupArray
            {
                hashCode = (hashCode &* 31) &+ value.hashValue
            }
            return hashCode
        }
    }
    
}



public extension Field
{
    public func clear()
    {
        variantArray.removeAll(keepingCapacity: false)
        fixed32Array.removeAll(keepingCapacity: false)
        fixed64Array.removeAll(keepingCapacity: false)
        groupArray.removeAll(keepingCapacity: false)
        lengthDelimited.removeAll(keepingCapacity: false)
    }
    
    public func mergeFromField(other:Field) -> Field
    {
        if (other.variantArray.count > 0)
        {
            variantArray += other.variantArray
        }
        if (other.fixed32Array.count > 0)
        {
            fixed32Array += other.fixed32Array
        }
        if (other.fixed64Array.count > 0)
        {
            fixed64Array += other.fixed64Array
        }
        if (other.lengthDelimited.count > 0)
        {
            lengthDelimited += other.lengthDelimited
        }
        if (other.groupArray.count > 0)
        {
            groupArray += other.groupArray
        }
        
        return self
    }
    
}
