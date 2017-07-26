//
//  VideoCapture.m
//  VideoToolBox
//
//  Created by 韩俊强 on 2017/7/24.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "VideoCapture.h"
#import "X264Manager.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoCapture ()<AVCaptureVideoDataOutputSampleBufferDelegate>

/** 编码对象 **/
@property (nonatomic, strong) X264Manager *encoder;

/** 捕捉会话 **/
@property (nonatomic, weak) AVCaptureSession *captureSession;

/** 预览图层 **/
@property (nonatomic, weak) AVCaptureVideoPreviewLayer *previewLayer;

/** 捕捉画面执行的线程队列 **/
@property (nonatomic, strong) dispatch_queue_t captureQueue;

@end

@implementation VideoCapture

- (void)startCapture:(UIView *)preview
{
    // 1.初始化编码对象
    self.encoder = [[X264Manager alloc] init];
    
    // 2.获取沙盒路径
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"abc.h264"];
    
    // 3.开始编码
    [self.encoder setFileSavePath:file];
    
    // 特别要注意: 宽度和高度设置
    [self.encoder setX264ResourceWithVideoWidth:480 height:640 bitrate:1500000];
    
    // 4.创建捕捉会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    session.sessionPreset = AVCaptureSessionPreset640x480;
    
    self.captureSession = session;
    
    // 5.设置输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    [session addInput:input];
    
    // 6.添加输出设备
    AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
    self.captureQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [output setSampleBufferDelegate:self queue:self.captureQueue];
//
//    NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:
//                              [NSNumber numberWithUnsignedInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange],
//                              kCVPixelBufferPixelFormatTypeKey,
//                              nil];
//
//    output.videoSettings = settings;
    output.alwaysDiscardsLateVideoFrames = YES;
    
    [session addOutput:output];
    
    // 设置录制视频的方向
    AVCaptureConnection *connection = [output connectionWithMediaType:AVMediaTypeVideo];
    if ([connection isVideoOrientationSupported]) {
        NSLog(@"支持修改");
    } else {
        NSLog(@"不支持修改");
    }
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    // 7.添加预览图层
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    previewLayer.frame = preview.bounds;
    [preview.layer insertSublayer:previewLayer atIndex:0];
    self.previewLayer = previewLayer;
    
    // 8.开始捕捉
    [self.captureSession startRunning];
}

- (void)stopCapture
{
    [self.captureSession stopRunning];
    [self.previewLayer removeFromSuperlayer];
    [self.encoder freeX264Resource];
}

#pragma mark -- 获取到数据
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    [self.encoder encoderToH264:sampleBuffer];
}

@end
