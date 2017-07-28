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

let DEFAULT_BUFFER_SIZE:Int = 4 * 1024

public class CodedOutputStream {
    private var output:OutputStream?
    internal var buffer:Buffer
    
    public init (stream:OutputStream!, data:Data) {
        self.output = stream
        buffer = Buffer(data:data)
    }
  
    public init(stream:OutputStream!, bufferSize:Int) {
        let data = Data(count: bufferSize)
        self.output = stream
        buffer = Buffer(data: data)
    }
   
    public init(stream:OutputStream) {
        let data = Data(count:DEFAULT_BUFFER_SIZE)
        self.output = stream
        buffer = Buffer(data: data)
    }
    
    public init(data:Data) {
        buffer = Buffer(data: data)
    }
    
    public func flush() throws {
        guard let output = output else {
            throw ProtocolBuffersError.outOfSpace
        }
        _ = buffer.flushToOutputStream(stream: output)
    }
   
    public func writeRawByte(byte aByte:UInt8) throws {
        while (!buffer.appendByte(byte: aByte)) {
            try flush()
        }
    }
    
    public func writeRawData(data:Data) throws {
        try writeRawData(data: data, offset:0, length: data.count)
    }
    public func writeRawData(data:Data, offset:Int, length:Int) throws {
        var aLength = length
        var aOffset = offset
        while (aLength > 0) {
            let written:Int = buffer.appendData(input: data, offset: aOffset, length: aLength)
            aOffset += written
            aLength -= written
            if (written == 0 || aLength > 0) {
                try flush()
            }
        }
    }
    
    public func writeDoubleNoTag(value:Double) throws {
        var returnValue:Int64 = 0
        returnValue = WireFormat.convertTypes(convertValue: value, defaultValue:returnValue)
        try writeRawLittleEndian64(value: returnValue)
    }
    
    public func writeDouble(fieldNumber:Int32, value aValue:Double) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.fixed64)
        try writeDoubleNoTag(value: aValue)
    }
    
    public func writeFloatNoTag(value:Float) throws {
        var returnValue:Int32 = 0
        returnValue = WireFormat.convertTypes(convertValue: value, defaultValue:returnValue)
        try writeRawLittleEndian32(value: returnValue)
    }
    
    public func writeFloat(fieldNumber:Int32, value aValue:Float) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.fixed32)
        try writeFloatNoTag(value: aValue)
    }
    
    public func writeUInt64NoTag(value:UInt64) throws {
        var retvalue:Int64 = 0
        retvalue = WireFormat.convertTypes(convertValue: value, defaultValue:retvalue)
        try writeRawVarint64(value: retvalue)
    }
    
    public func writeUInt64(fieldNumber:Int32, value:UInt64) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.varint)
        try writeUInt64NoTag(value: value)
    }
    
    public func writeInt64NoTag(value:Int64) throws {
        try writeRawVarint64(value: value)
    }
    
    public func writeInt64(fieldNumber:Int32, value aValue:Int64) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.varint)
        try writeInt64NoTag(value: aValue)
    }
    
    public func writeInt32NoTag(value:Int32) throws {
        if value >= 0 {
            try writeRawVarint32(value: value)
        } else {
            try writeRawVarint64(value: Int64(value))
        }
    }
    
    public func writeInt32(fieldNumber:Int32, value:Int32) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.varint)
        try writeInt32NoTag(value: value)
    }
    
    public func writeFixed64NoTag(value:UInt64) throws {
        var retvalue:Int64 = 0
        retvalue = WireFormat.convertTypes(convertValue: value, defaultValue:retvalue)
        try writeRawLittleEndian64(value: retvalue)
    }
    
    public func writeFixed64(fieldNumber:Int32, value:UInt64) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.fixed64)
        try writeFixed64NoTag(value: value)
    }
    
    public func writeFixed32NoTag(value:UInt32) throws {
        var retvalue:Int32 = 0
        retvalue = WireFormat.convertTypes(convertValue: value, defaultValue:retvalue)
        try writeRawLittleEndian32(value: retvalue)
    }
    
    public func writeFixed32(fieldNumber:Int32, value:UInt32) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.fixed32)
        try writeFixed32NoTag(value: value)
    }
    
    public func writeBoolNoTag(value:Bool) throws {
        try writeRawByte(byte: value ? 1 : 0)
    }
    
    public func writeBool(fieldNumber:Int32, value:Bool) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.varint)
        try writeBoolNoTag(value: value)
    }
    
    public func writeStringNoTag(value:String) throws {
        let data = value.utf8ToData()
        try writeRawVarint32(value: Int32(data.count))
        try writeRawData(data: data)
    }
    
    public func writeString(fieldNumber:Int32, value:String) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.lengthDelimited)
        try writeStringNoTag(value: value)
    }
    
    public func writeGroupNoTag(fieldNumber:Int32, value:ProtocolBuffersMessage) throws {
        try value.writeTo(codedOutputStream: self)
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.endGroup)
    }
    
    public func writeGroup(fieldNumber:Int32, value:ProtocolBuffersMessage) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.startGroup)
        try writeGroupNoTag(fieldNumber: fieldNumber, value: value)
    }
    
    public func writeUnknownGroupNoTag(fieldNumber:Int32, value:UnknownFieldSet) throws {
        try value.writeTo(codedOutputStream: self)
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.endGroup)
    }
    
    public func writeUnknownGroup(fieldNumber:Int32, value:UnknownFieldSet) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.startGroup)
        try writeUnknownGroupNoTag(fieldNumber: fieldNumber, value:value)
    }
    
    public func writeMessageNoTag(value:ProtocolBuffersMessage) throws {
        try writeRawVarint32(value: value.serializedSize())
        try value.writeTo(codedOutputStream: self)
    }
    
    public func writeMessage(fieldNumber:Int32, value:ProtocolBuffersMessage) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.lengthDelimited)
        try writeMessageNoTag(value: value)
    }
    
    public func writeDataNoTag(data:Data) throws {
        try writeRawVarint32(value: Int32(data.count))
        try writeRawData(data: data)
    }
    
    public func writeData(fieldNumber:Int32, value:Data) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.lengthDelimited)
        try writeDataNoTag(data: value)
    }
    
    public func writeUInt32NoTag(value:UInt32) throws {
        var retvalue:Int32 = 0
        retvalue = WireFormat.convertTypes(convertValue: value, defaultValue:retvalue)
        try writeRawVarint32(value: retvalue)
    }
    
    public func writeUInt32(fieldNumber:Int32, value:UInt32) throws {
        try writeTag(fieldNumber: fieldNumber, format: WireFormat.varint)
        try writeUInt32NoTag(value: value)
    }
    
    public func writeEnumNoTag(value:Int32) throws {
        try writeRawVarint32(value: value)
    }
    
    public func writeEnum(fieldNumber:Int32, value:Int32) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.varint)
        try writeEnumNoTag(value: value)
    }
    
    public func writeSFixed32NoTag(value:Int32) throws {
        try writeRawLittleEndian32(value: value)
    }
    
    public func writeSFixed32(fieldNumber:Int32, value:Int32) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.fixed32)
        try writeSFixed32NoTag(value: value)
    }

    public func writeSFixed64NoTag(value:Int64) throws {
         try writeRawLittleEndian64(value: value)
    }
    
    public func writeSFixed64(fieldNumber:Int32, value:Int64) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.fixed64)
        try writeSFixed64NoTag(value: value)
    }
    
    public func writeSInt32NoTag(value:Int32) throws {
        try writeRawVarint32(value: WireFormat.encodeZigZag32(n: value))
    }
    
    public func writeSInt32(fieldNumber:Int32, value:Int32) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.varint)
        try writeSInt32NoTag(value: value)
    }
    
    public func writeSInt64NoTag(value:Int64) throws {
        try writeRawVarint64(value: WireFormat.encodeZigZag64(n: value))
    }
    
    public func writeSInt64(fieldNumber:Int32, value:Int64) throws {
        try writeTag(fieldNumber: fieldNumber, format:WireFormat.varint)
        try writeSInt64NoTag(value: value)
    }
    
    public func writeMessageSetExtension(fieldNumber:Int32, value:ProtocolBuffersMessage) throws {
        try writeTag(fieldNumber: WireFormatMessage.setItem.rawValue, format:WireFormat.startGroup)
        try writeUInt32(fieldNumber: WireFormatMessage.setTypeId.rawValue, value:UInt32(fieldNumber))
        try writeMessage(fieldNumber: WireFormatMessage.setMessage.rawValue, value: value)
        try writeTag(fieldNumber: WireFormatMessage.setItem.rawValue, format:WireFormat.endGroup)
    }
    
    public func writeRawMessageSetExtension(fieldNumber:Int32, value:Data) throws {
        try writeTag(fieldNumber: WireFormatMessage.setItem.rawValue, format:WireFormat.startGroup)
        try writeUInt32(fieldNumber: WireFormatMessage.setTypeId.rawValue, value:UInt32(fieldNumber))
        try writeData(fieldNumber: WireFormatMessage.setMessage.rawValue, value: value)
        try writeTag(fieldNumber: WireFormatMessage.setItem.rawValue, format:WireFormat.endGroup)
    }
    
    public func writeTag(fieldNumber:Int32, format:WireFormat) throws {
        try writeRawVarint32(value: format.makeTag(fieldNumber: fieldNumber))
    }
    
    public func writeRawLittleEndian32(value:Int32) throws {
        try writeRawByte(byte:UInt8(value & 0xFF))
        try writeRawByte(byte:UInt8((value >> 8) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 16) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 24) & 0xFF))
    }
    
    public func writeRawLittleEndian64(value:Int64) throws {
        try writeRawByte(byte:UInt8(value & 0xFF))
        try writeRawByte(byte:UInt8((value >> 8) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 16) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 24) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 32) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 40) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 48) & 0xFF))
        try writeRawByte(byte:UInt8((value >> 56) & 0xFF))
    }
    
    
    public func writeRawVarint32(value:Int32) throws {
        var valueToWrite = value
        while (true) {
            if ((valueToWrite & ~0x7F) == 0) {
                try writeRawByte(byte:UInt8(valueToWrite))
                break
            } else
            {
                try writeRawByte(byte: UInt8((valueToWrite & 0x7F) | 0x80))
                valueToWrite = WireFormat.logicalRightShift32(value:valueToWrite,spaces: 7)
            }
        }
    }
    
    public func writeRawVarint64(value:Int64) throws {
        var valueToWrite = value
        while (true) {
            if ((valueToWrite & ~0x7F) == 0) {
                try writeRawByte(byte:UInt8(valueToWrite))
                break
            } else {
                try writeRawByte(byte: UInt8((valueToWrite & 0x7F) | 0x80))
                valueToWrite = WireFormat.logicalRightShift64(value:valueToWrite, spaces: 7)
            }
        }
    }
}
