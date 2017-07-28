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

internal struct Buffer {
    internal var buffer:[UInt8]
    var position:Int = 0
    var tail:Int = 0
    
    init(data:Data) {
        buffer = [UInt8](data)
    }
    func freeSpace() -> Int {
        var res:Int = 0
        
        if position < tail {
            res = tail - position
        }
        else {
            let dataLength = buffer.count
            res = (dataLength - position) + tail
        }
        
        if tail != 0 {
            res -=  1
        }
        return res
    }
    
    mutating func appendByte(byte:UInt8) -> Bool {
        if freeSpace() < 1 {
            return false
        }
        buffer[position] = byte
        position+=1
        return true
    }

    mutating func appendData(input:Data, offset:Int, length:Int) -> Int {
        var totalWritten:Int = 0
        var aLength = length
        var aOffset = offset
        var inputs = [UInt8](input)
//        let pointer = UnsafeMutablePointerUInt8From(data: buffer)
        if position >= tail {
            totalWritten = min(buffer.count - position, aLength)
            memcpy(&buffer + Int(position), &inputs + Int(aOffset), Int(totalWritten))
//            buffer[position..<(position+totalWritten)] = input[aOffset..<input.count]
            
//            input.copyBytes(to: pointer + position, from: aOffset..<aOffset + totalWritten)
            position += totalWritten
            
            if totalWritten == aLength {
                return aLength
            }
            aLength -= totalWritten
            aOffset += totalWritten
            
        }
        
        let freeSpaces = freeSpace()
        
        if freeSpaces == 0 {
            return totalWritten
        }
        
        if position == buffer.count {
            position = 0
        }
        
        let written = min(freeSpaces, aLength)
        
        memcpy(&buffer + position, &inputs + Int(aOffset), Int(written))
        
//        input.copyBytes(to: pointer + position, from: aOffset..<aOffset + written)
        position += written
        totalWritten += written
        
        return totalWritten
    }
    
    mutating func flushToOutputStream(stream:OutputStream) -> Int {
        var totalWritten:Int = 0
        

        if tail > position {
            
            let written:Int = stream.write(&buffer + tail, maxLength:buffer.count - tail)
            if written <= 0 {
                return totalWritten
            }
            totalWritten += written
            tail += written
            if tail == buffer.count {
                tail = 0
            }
        }
        
        if tail < position {
            let written = stream.write(&buffer + tail, maxLength:position - tail)
            if written <= 0 {
                return totalWritten
            }
            totalWritten += written
            tail += written
        }
        if tail == position {
            tail = 0
            position = 0
        }
        if position == buffer.count && tail > 0 {
            position = 0
        }
        if tail == buffer.count {
            tail = 0
        }
        
        return totalWritten
    }
    
    
}
