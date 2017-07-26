//
//  ViewController.m
//  JQPlayer
//
//  Created by 韩俊强 on 2017/7/26.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "ViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ViewController ()

@property(nonatomic, retain)id<IJKMediaPlayback>Play;
@property (nonatomic, weak)  UIView *MadieView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //注意: 由于 IJKMediaFramework.framework 静态库太大, github限制, 只能从别处下载, 解压后拖进此项目即可!!
#warning IJKMediaFramework.framework  @"http://download.csdn.net/detail/qq_31810357/9911107"

    // 地址URL
    // 终端查看本地ip: ifconfig | grep "inet" | grep -v 127.0.0.1
    // 这里的 192.168.1.102 替换成你自己的ip地址
    NSURL *starUrl = [NSURL URLWithString:@"rtmp://192.168.1.102:1935/rtmplive/room"];
    
    // 创建一个播放器对象
    _Play = [[IJKFFMoviePlayerController alloc] initWithContentURL:starUrl withOptions:nil];
    
    //通过代理对象返回一个播放视频的View
    [self setupMadieView];
    
    // 准备播放
    [_Play prepareToPlay];
    
    // 开始播放
    [_Play play];

}

//通过代理对象返回一个播放视频的view
- (void)setupMadieView {
    
    //通过代理对象view返回一个MadieView
    UIView *MadieView = [_Play view];
    _MadieView = MadieView;
    
    //横竖屏适配
    MadieView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    MadieView.frame = self.view.frame;
    
    [self.view addSubview:MadieView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
