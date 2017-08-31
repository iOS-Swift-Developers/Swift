//
//  UIImagePickerController+Extension.swift
//  ImagePickerDemo
//
//  Created by 韩俊强 on 2017/8/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import Foundation
import UIKit
import Photos

public enum UIImagePickerType:Int
{
    case kImagePickerTypePhotoLibrary = 1     // 相册
    case kImagePickerTypeSavedPhotosAlbum = 2 // 图库
    case kImagePickerTypeCamera = 3           // 相机
    case kImagePickerTypeCameraFront = 4      // 前置摄像头
    case kImagePickerTypeCameraRear = 5       // 后置摄像头
}

extension UIImagePickerController
{
    // MARK: - 判断设备有效性
    public class func isValidImagePickerType(type imagePickerType:UIImagePickerType) -> Bool
    {
        switch imagePickerType {
        case .kImagePickerTypePhotoLibrary:
            if self.isValidPhotoLibrary {
                return true
            }
            return false
            break
        case .kImagePickerTypeSavedPhotosAlbum:
            if self.isValidSavedPhotosAlbum {
                return true
            }
            return false
            break
        case .kImagePickerTypeCamera:
            if self.isValidCameraEnable && self.isValidCamera {
                return true
            }
            return false
            break
        case .kImagePickerTypeCameraFront:
            if self.isValidCameraEnable && self.isValidCameraFront {
                return true
            }
            return false
            break
        case .kImagePickerTypeCameraRear:
            if self.isValidCameraRear && self.isValidCameraEnable {
                return true
            }
            return false
            break
        default:
           return false
        }
    }
    
    // 相机是否启用
    public class var isValidCameraEnable:Bool {
        get {
            let cameraStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
            if cameraStatus == AVAuthorizationStatus.denied {
                return false
            }
            return true
        }
    }
    
    // 相机是否有摄像头
    public class var isValidCamera:Bool {
        get {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                return true
            }
            return false
        }
    }
    
    // 前置相机是否可用
    public class var isValidCameraFront:Bool {
        get {
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front) {
                return true
            }
            return false
        }
    }
    
    // 后置相机是否可用
    public class var isValidCameraRear:Bool {
        get {
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.rear) {
                return true
            }
            return false
        }
    }
    
    // 相机是否可用
    public class var isValidPhotoLibrary:Bool {
        get {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                return true
            }
            return false
        }
    }
    
    // 图库(SavedPhotosAlbum)是否可用
    public class var isValidSavedPhotosAlbum:Bool {
        get {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
                return true
            }
            return false
        }
    }
    
    // MARK: - 属性设置
    func setImagePickerStyle(_ bgroundColor:UIColor, titleColor:UIColor, buttonTitleColor:UIColor) {
        // NavigationBar bgColor
        if let bgroundColorTmp:UIColor = bgroundColor {
            self.navigationBar.barTintColor = bgroundColorTmp
        }
        
        // 标题颜色
        if let titleColorTmp:UIColor = titleColor  {
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:titleColorTmp]
        }
        
        // 按钮颜色
        if let buttonColorTmp:UIColor = buttonTitleColor {
            self.navigationBar.tintColor = buttonColorTmp
        }
    }
    
}
