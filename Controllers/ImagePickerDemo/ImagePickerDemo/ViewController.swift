//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by 韩俊强 on 2017/8/31.
//  Copyright © 2017年 HaRi. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageView:UIImageView!
    var imagePicker:UIImagePickerController! = nil
    var photoPicker:UIImagePickerController! = nil
    var cameraPicker:UIImagePickerController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "UIImagePickerViewController"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "image", style: .done, target: self, action: #selector(ViewController.imageClick))
        
        // 预览
        self.imageView = UIImageView(frame: CGRect(x: 50, y: 100, width: 300, height: 300))
        self.view.addSubview(self.imageView)
        self.imageView.backgroundColor = UIColor.green
        self.imageView.contentMode = .scaleAspectFit
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.white
        
        if self.responds(to: #selector(getter: UIViewController.edgesForExtendedLayout)) {
            self.edgesForExtendedLayout = UIRectEdge()
        }
    }
    
    func imageClick() {
        // 图片选择
        let sheetView = UIAlertController(title: nil, message: "选择相片", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let photosAction = UIAlertAction(title: "图库", style: UIAlertActionStyle.default, handler: {
            action in
            print("图库")
            
            self.photosShow()
        })
        let imageAction = UIAlertAction(title: "相册", style: UIAlertActionStyle.default, handler: {
            action in
            print("相册")
            
            self.imageShow()
        })
        let cameraAction = UIAlertAction(title: "相机", style: UIAlertActionStyle.default, handler: {
            action in
            print("相机")
            
            self.cameraShow()
        })
        let videoAction = UIAlertAction(title: "摄像", style: UIAlertActionStyle.default, handler: {
            action in
            print("摄像")
            
            self.videoShow()
        })
        sheetView.addAction(cancelAction)
        sheetView.addAction(photosAction)
        sheetView.addAction(imageAction)
        sheetView.addAction(cameraAction)
        sheetView.addAction(videoAction)
        self.present(sheetView, animated: true, completion: nil)
    }
    
    // 图库
    func photosShow() {
        if UIImagePickerController.isValidSavedPhotosAlbum {
            if self.photoPicker == nil {
                self.photoPicker = UIImagePickerController()
                self.photoPicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.photoPicker.delegate = self
                self.photoPicker.allowsEditing = true
                self.photoPicker.navigationBar.barTintColor = UIColor.green
                self.photoPicker.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.red]
                self.photoPicker.navigationBar.tintColor = UIColor.blue
            }
            self.present(self.photoPicker, animated: true, completion: nil)
        } else {
            print("读取图库失败")
        }
    }
    
    // 相册
    func imageShow() {
        if UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.kImagePickerTypePhotoLibrary) {
            if self.imagePicker == nil {
                self.imagePicker = UIImagePickerController()
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                self.imagePicker.delegate = self
                self.imagePicker.setImagePickerStyle(UIColor.brown, titleColor: UIColor.green, buttonTitleColor: UIColor.yellow)
            }
            self.present(self.imagePicker, animated: true, completion: nil)
        } else {
            print("读取相册失败")
        }
    }
    
    // 相机
    func cameraShow() {
        if !UIImagePickerController.isValidCameraEnable {
            print("没有相机设备")
            return
        }
        if !UIImagePickerController.isValidCamera {
            print("相机未打开")
            return
        }
        if self.cameraPicker == nil {
            self.cameraPicker = UIImagePickerController()
            self.cameraPicker.sourceType = .camera
            self.cameraPicker.setImagePickerStyle(UIColor.yellow, titleColor: UIColor.red, buttonTitleColor: UIColor.black)
        }
        self.present(self.cameraPicker, animated: true, completion: nil)
    }
    
    // 摄像
    func videoShow() {
        if !UIImagePickerController.isValidCameraEnable {
            print("没有相机设备")
            return
        }
        if !UIImagePickerController.isValidCamera {
            print("相机未打开")
            return
        }
        /*
         使用如下属性时，注意添加framework：MobileCoreServices
         
         KUTTypeImage 包含
         const CFStringRef  kUTTypeImage ;抽象的图片类型
         const CFStringRef  kUTTypeJPEG ;
         const CFStringRef  kUTTypeJPEG2000 ;
         const CFStringRef  kUTTypeTIFF ;
         const CFStringRef  kUTTypePICT ;
         const CFStringRef  kUTTypeGIF ;
         const CFStringRef  kUTTypePNG ;
         const CFStringRef  kUTTypeQuickTimeImage ;
         const CFStringRef  kUTTypeAppleICNS
         const CFStringRef  kUTTypeBMP;
         const CFStringRef  kUTTypeICO;
         
         KUTTypeMovie 包含：
         const CFStringRef  kUTTypeAudiovisualContent ;抽象的声音视频
         const CFStringRef  kUTTypeMovie ;抽象的媒体格式（声音和视频）
         const CFStringRef  kUTTypeVideo ;只有视频没有声音
         const CFStringRef  kUTTypeAudio ;只有声音没有视频
         const CFStringRef  kUTTypeQuickTimeMovie ;
         const CFStringRef  kUTTypeMPEG ;
         const CFStringRef  kUTTypeMPEG4 ;
         const CFStringRef  kUTTypeMP3 ;
         const CFStringRef  kUTTypeMPEG4Audio ;
         const CFStringRef  kUTTypeAppleProtectedMPEG4Audio;
         */
        let availableMediaTypes:Array = UIImagePickerController.availableMediaTypes(for: .camera)!
        var canTakeVideo = false
        for meddiaType in availableMediaTypes {
            if meddiaType == (kUTTypeImage as String) {
                canTakeVideo = true // 支持摄像
                break
            }
        }
        if !canTakeVideo {
            print("不支持摄像")
            return
        }
        
        let videoPicker = UIImagePickerController()
        videoPicker.sourceType = UIImagePickerControllerSourceType.camera
        videoPicker.mediaTypes = [kUTTypeMovie as String]
        videoPicker.videoQuality = UIImagePickerControllerQualityType.typeHigh // 画质
        videoPicker.videoMaximumDuration = 30 // 最长摄像时间
        videoPicker.allowsEditing = false
        videoPicker.delegate = self
        self.present(videoPicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate/UINavigationControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 相册,图库
        if picker.isEqual(self.imagePicker) || picker.isEqual(self.photoPicker) {

            /* 图片参数
             指定用户选择的媒体类型 UIImagePickerControllerMediaType
             原始图片 UIImagePickerControllerOriginalImage
             修改后的图片 UIImagePickerControllerEditedImage
             裁剪尺寸 UIImagePickerControllerCropRect
             媒体的URL UIImagePickerControllerMediaURL
             原件的URL UIImagePickerControllerReferenceURL
             当来数据来源是照相机的时候这个值才有效 UIImagePickerControllerMediaMetadata
             */
            // 获取原图
            let pickerImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            // 引用路径
            let pickerUrl:URL = info[UIImagePickerControllerReferenceURL] as! URL
            let fetchResult:PHFetchResult = PHAsset.fetchAssets(withALAssetURLs: [pickerUrl], options: nil)
            let asset:PHAsset = fetchResult.firstObject as! PHAsset
            
            PHImageManager.default().requestImageData(for: asset, options: nil, resultHandler: { (imageData, dataUrl, orientation, info:[AnyHashable:Any]?) in
                // 实际路径
                let imageUrl:URL = info!["PHImageFileURLKey"] as! URL
                print("路径:",imageUrl)
                print("文件名:",imageUrl.lastPathComponent)
            })
            
            // 预览
            self.imageView.image = pickerImage
            
            // 保存
            // UIImageWriteToSavedPhotosAlbum(pickerImage, self, Selector("imageSave:error:contextInfo:"), nil)
            
        } else if (picker.isEqual(self.cameraPicker)) { // 拍照
            let pickerImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            // 预览
            self.imageView.image = pickerImage
        } else {
            // 录像
            let mediaType = info[UIImagePickerControllerMediaType] as! String
            // 静态图还是视频
            if mediaType == (kUTTypeImage as String) {
                
            } else if (mediaType == (kUTTypeMovie as String)) {
                let mediaUrl = info[UIImagePickerControllerMediaURL] as! URL
                let pathStr = mediaUrl.relativePath
                print("视频地址:",pathStr)
                
                // 创建ALAssetsLibrary对象并将视频保存到媒体库(注意添加frame:AssetsLibrary)
                let assetsLibrary = ALAssetsLibrary()
                assetsLibrary.writeVideoAtPath(toSavedPhotosAlbum: mediaUrl, completionBlock: { (assetUrl, error) in
                    if let errorTmp = error {
                        print("保存失败:",errorTmp)
                    } else {
                        print("保存成功")
                    }
                })
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("取消选择")
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - 图片保存
    func imageSave(_ image:UIImage, error:NSError, contextInfo:Void) {
        if let errorTmp:NSError = error {
            print("保存失败:\(errorTmp)")
        } else {
            print("保存成功")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

