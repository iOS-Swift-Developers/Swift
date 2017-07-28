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

@_silgen_name("yudpsocket_server") func c_yudpsocket_server(_ host:UnsafePointer<Int8>,port:Int32) -> Int32
@_silgen_name("yudpsocket_recive") func c_yudpsocket_recive(_ fd:Int32,buff:UnsafePointer<UInt8>,len:Int32,ip:UnsafePointer<Int8>,port:UnsafePointer<Int32>) -> Int32
@_silgen_name("yudpsocket_close") func c_yudpsocket_close(_ fd:Int32) -> Int32
@_silgen_name("yudpsocket_client") func c_yudpsocket_client() -> Int32
@_silgen_name("yudpsocket_get_server_ip") func c_yudpsocket_get_server_ip(_ host:UnsafePointer<Int8>,ip:UnsafePointer<Int8>) -> Int32
@_silgen_name("yudpsocket_sentto") func c_yudpsocket_sentto(_ fd:Int32,buff:UnsafePointer<UInt8>,len:Int32,ip:UnsafePointer<Int8>,port:Int32) -> Int32
@_silgen_name("enable_broadcast") func c_enable_broadcast(_ fd:Int32)

open class UDPClient: YSocket {
    public override init(addr a:String,port p:Int){
        super.init()
        let remoteipbuff:[Int8] = [Int8](repeating: 0x0,count: 16)
        let ret=c_yudpsocket_get_server_ip(a, ip: remoteipbuff)
        if ret==0{
            if let ip=String(cString: remoteipbuff, encoding: String.Encoding.utf8){
                self.addr=ip
                self.port=p
                let fd:Int32=c_yudpsocket_client()
                if fd>0{
                    self.fd=fd
                }
            }
        }
    }
    /*
    * send data
    * return success or fail with message
    */
    open func send(data d:[UInt8])->(Bool,String){
        if let fd:Int32=self.fd{
            let sendsize:Int32=c_yudpsocket_sentto(fd, buff: d, len: Int32(d.count), ip: self.addr,port: Int32(self.port))
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
    open func send(str s:String)->(Bool,String){
        if let fd:Int32=self.fd{
            let sendsize:Int32=c_yudpsocket_sentto(fd, buff: s, len: Int32(strlen(s)), ip: self.addr,port: Int32(self.port))
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
    * enableBroadcast
    */
    open func enableBroadcast(){
        if let fd:Int32=self.fd{
            c_enable_broadcast(fd)

        }
    }
    /*
    *
    * send nsdata
    */
    open func send(data d:Data)->(Bool,String){
        if let fd:Int32=self.fd{
            var buff:[UInt8] = [UInt8](repeating: 0x0,count: d.count)
            (d as NSData).getBytes(&buff, length: d.count)
            let sendsize:Int32=c_yudpsocket_sentto(fd, buff: buff, len: Int32(d.count), ip: self.addr,port: Int32(self.port))
            if sendsize==Int32(d.count){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    open func close()->(Bool,String){
        if let fd:Int32=self.fd{
            _ = c_yudpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
    //TODO add multycast and boardcast
}

open class UDPServer:YSocket{
    public override init(addr a:String,port p:Int){
        super.init(addr: a, port: p)
        let fd:Int32 = c_yudpsocket_server(self.addr, port: Int32(self.port))
        if fd>0{
            self.fd=fd
        }
    }
    //TODO add multycast and boardcast
    open func recv(_ expectlen:Int)->([UInt8]?,String,Int){
        if let fd:Int32 = self.fd{
            var buff:[UInt8] = [UInt8](repeating: 0x0,count: expectlen)
            var remoteipbuff:[Int8] = [Int8](repeating: 0x0,count: 16)
            var remoteport:Int32=0
            let readLen:Int32=c_yudpsocket_recive(fd, buff: buff, len: Int32(expectlen), ip: &remoteipbuff, port: &remoteport)
            let port:Int=Int(remoteport)
            var addr:String=""
            if let ip=String(cString: remoteipbuff, encoding: String.Encoding.utf8){
                addr=ip
            }
            if readLen<=0{
                return (nil,addr,port)
            }
            let rs=buff[0...Int(readLen-1)]
            let data:[UInt8] = Array(rs)
            return (data,addr,port)
        }
        return (nil,"no ip",0)
    }
    open func close()->(Bool,String){
        if let fd:Int32=self.fd{
            _ = c_yudpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
}
