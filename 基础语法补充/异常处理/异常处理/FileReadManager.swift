//
//  FileReadManager.swift
//  异常处理
//
//  Created by 韩俊强 on 2017/7/13.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit

enum FileReadError : Error {
    case fileNameNotNull
    case filePathNotFind
    case fileDataError
}

class FileReadManager: NSObject {

    func readFileContent(_ fileName : String) throws -> String? {
        
        //1.判断name是否为""
        if fileName == "" {
            //抛出异常, 抛出异常时, 后面方法将不再执行;
            throw FileReadError.fileNameNotNull
        }
        
        //2.获取文件路径
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: nil) else {
            //抛出异常
            throw FileReadError.filePathNotFind
        }
        
        //3.读写文件内容
        guard let data = try? Data(contentsOf: URL(fileURLWithPath:filePath)) else {
            //抛出异常
            throw FileReadError.fileDataError
        }
        
        //4.返回读取到的信息
        return String(data: data, encoding: String.Encoding.utf8)
        
    }
}
