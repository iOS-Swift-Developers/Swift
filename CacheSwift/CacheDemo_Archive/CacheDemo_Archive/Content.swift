//
//  Content.swift
//  CacheDemo_Archive
//
//  Created by 韩俊强 on 2017/8/25.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

// 1.1 需要遵循NSCoding协议

// 1.2 需要实现func encode(with aCoder: NSCoder){}归档方法

// 1.3 需要实现 required init(coder aDecoder: NSCoder){}解档方法

// 1.4 重写init方法

class Content: NSObject, NSCoding {
    
    var id:Int?
    
    var nickname:String?
    
    var phone:String?
    
    var account:String?
    
    var password:String?
    
    var type:Int?
    
    var icon:String?
    
    var attentionnumber:Int?
    
    var registertime:String?
    
    var qrcode:String?
    
    var signature:String?
    
    var dynamicstruts:Int?
    
    var score:Int?
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(id, forKey:"id")
        
        aCoder.encode(nickname, forKey:"nickname")
        
        aCoder.encode(phone, forKey:"phone")
        
        aCoder.encode(account, forKey:"account")
        
        aCoder.encode(password, forKey:"password")
        
        aCoder.encode(type, forKey:"type")
        
        aCoder.encode(icon, forKey:"icon")
        
        aCoder.encode(attentionnumber, forKey:"attentionnumber")
        
        aCoder.encode(registertime, forKey:"registertime")
        
        aCoder.encode(qrcode, forKey:"qrcode")
        
        aCoder.encode(signature, forKey:"signature")
        
        aCoder.encode(dynamicstruts, forKey:"dynamicstruts")
        
        aCoder.encode(score, forKey:"score")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        id = aDecoder.decodeObject(forKey:"id")as?Int
        
        nickname = aDecoder.decodeObject(forKey:"nickname")as?String
        
        phone = aDecoder.decodeObject(forKey:"phone")as?String
        
        account = aDecoder.decodeObject(forKey:"account")as?String
        
        password = aDecoder.decodeObject(forKey:"password")as?String
        
        type = aDecoder.decodeObject(forKey:"type")as?Int
        
        icon = aDecoder.decodeObject(forKey:"icon")as?String
        
        attentionnumber = aDecoder.decodeObject(forKey:"attentionnumber")as? Int
        
        registertime = aDecoder.decodeObject(forKey:"registertime")as?String
        
        qrcode = aDecoder.decodeObject(forKey:"qrcode")as?String
        
        signature = aDecoder.decodeObject(forKey:"signature")as?String
        
        dynamicstruts = aDecoder.decodeObject(forKey:"dynamicstruts")as? Int
        
        score = aDecoder.decodeObject(forKey:"score")as?Int
    }
    
    override init() {
    
    super.init()
    
    }
}

