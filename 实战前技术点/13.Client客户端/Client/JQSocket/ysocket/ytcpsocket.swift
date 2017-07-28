/*
Copyright (c) <2014>, skysent
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
3. All advertising materials mentioning features or use of this software
must display the following acknowledgement:
This product includes software developed by skysent.
4. Neither the name of the skysent nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY skysent ''AS IS'' AND ANY
EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL skysent BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
import Foundation

@_silgen_name("ytcpsocket_connect") func c_ytcpsocket_connect(_ host:UnsafePointer<Int8>,port:Int32,timeout:Int32) -> Int32
@_silgen_name("ytcpsocket_close") func c_ytcpsocket_close(_ fd:Int32) -> Int32
@_silgen_name("ytcpsocket_send") func c_ytcpsocket_send(_ fd:Int32,buff:UnsafePointer<UInt8>,len:Int32) -> Int32
@_silgen_name("ytcpsocket_pull") func c_ytcpsocket_pull(_ fd:Int32,buff:UnsafePointer<UInt8>,len:Int32,timeout:Int32) -> Int32
@_silgen_name("ytcpsocket_listen") func c_ytcpsocket_listen(_ addr:UnsafePointer<Int8>,port:Int32)->Int32
@_silgen_name("ytcpsocket_accept") func c_ytcpsocket_accept(_ onsocketfd:Int32,ip:UnsafePointer<Int8>,port:UnsafePointer<Int32>) -> Int32

open class TCPClient:YSocket{
    /*
     * connect to server
     * return success or fail with message
     */
    open func connect(timeout t:Int)->(Bool,String){
        let rs:Int32=c_ytcpsocket_connect(self.addr, port: Int32(self.port), timeout: Int32(t))
        if rs>0{
            self.fd=rs
            return (true,"connect success")
        }else{
            switch rs{
            case -1:
                return (false,"qeury server fail")
            case -2:
                return (false,"connection closed")
            case -3:
                return (false,"connect timeout")
            default:
                return (false,"unknow err.")
            }
        }
    }
    /*
    * close socket
    * return success or fail with message
    */
    open func close()->(Bool,String){
        if let fd:Int32=self.fd{
            _ = c_ytcpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
    /*
    * send data
    * return success or fail with message
    */
    open func send(data d:[UInt8])->(Bool,String){
        if let fd:Int32=self.fd{
            let sendsize:Int32=c_ytcpsocket_send(fd, buff: d, len: Int32(d.count))
            if Int(sendsize)==d.count{
               return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    /*
    * send string
    * return success or fail with message
    */
    @discardableResult
    open func send(str s:String)->(Bool,String){
        if let fd:Int32=self.fd{
            let sendsize:Int32=c_ytcpsocket_send(fd, buff: s, len: Int32(strlen(s)))
            if sendsize==Int32(strlen(s)){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    /*
    *
    * send nsdata
    */
    @discardableResult
    open func send(data d:Data)->(Bool,String){
        if let fd:Int32=self.fd{
            var buff:[UInt8] = [UInt8](repeating: 0x0,count: d.count)
            (d as NSData).getBytes(&buff, length: d.count)
            let sendsize:Int32=c_ytcpsocket_send(fd, buff: buff, len: Int32(d.count))
            if sendsize==Int32(d.count){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    /*
    * read data with expect length
    * return success or fail with message
    */
    open func read(_ expectlen:Int, timeout:Int = -1)->[UInt8]?{
        if let fd:Int32 = self.fd{
            var buff:[UInt8] = [UInt8](repeating: 0x0,count: expectlen)
            let readLen:Int32=c_ytcpsocket_pull(fd, buff: &buff, len: Int32(expectlen), timeout: Int32(timeout))
            if readLen<=0{
                return nil
            }
            let rs=buff[0...Int(readLen-1)]
            let data:[UInt8] = Array(rs)
            return data
        }
       return nil
    }
}

open class TCPServer:YSocket{

      @discardableResult open func listen()->(Bool,String){
        
        let fd:Int32=c_ytcpsocket_listen(self.addr, port: Int32(self.port))
        if fd>0{
            self.fd=fd
            return (true,"listen success")
        }else{
            return (false,"listen fail")
        }
    }
    open func accept()->TCPClient?{
        if let serferfd=self.fd{
            var buff:[Int8] = [Int8](repeating: 0x0,count: 16)
            var port:Int32=0
            let clientfd:Int32=c_ytcpsocket_accept(serferfd, ip: &buff,port: &port)
            if clientfd<0{
                return nil
            }
            let tcpClient:TCPClient=TCPClient()
            tcpClient.fd=clientfd
            tcpClient.port=Int(port)
            if let addr=String(cString: buff, encoding: String.Encoding.utf8){
               tcpClient.addr=addr
            }
            return tcpClient
        }
        return nil
    }
    open func close()->(Bool,String){
        if let fd:Int32=self.fd{
            _ = c_ytcpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
}


