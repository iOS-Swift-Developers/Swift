//
//  VideoEncoder.h
//  VideoToolBox
//
//  Created by 韩俊强 on 2017/7/24.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import <UIKit/UIKit.h>

@interface VideoEncoder : NSObject

- (void)encoderSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)endEncode;

@end
