//
//  ViewController.m
//  VideoToolBox
//
//  Created by 韩俊强 on 2017/7/24.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "ViewController.h"
#import <VideoToolbox/VideoToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoCapture.h"

@interface ViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

/** 视频捕捉对象 **/
@property (nonatomic, strong) VideoCapture *videoCapture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)startCaptureAction:(UIButton *)sender
{
    if (!TARGET_IPHONE_SIMULATOR) {
        [self.videoCapture startCapture:self.view];
    } else {
        NSLog(@"请使用真机测试, 模拟器不支持!");
    }
}

- (IBAction)stopCaptureAction:(UIButton *)sender
{
    if (!TARGET_IPHONE_SIMULATOR) {
        [self.videoCapture stopCapture];
    } else {
        NSLog(@"请使用真机测试, 模拟器不支持!");
    }
}

- (VideoCapture *)videoCapture
{
    if (!_videoCapture) {
        _videoCapture = [[VideoCapture alloc] init];
    }
    return _videoCapture;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
