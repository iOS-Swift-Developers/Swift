//
//  X264Manager.h
//  Encode(FFmpeg+x264)
//
//  Created by 韩俊强 on 2017/7/25.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>

@interface X264Manager : NSObject

/**
 设置编码后文件的保存路径

 @param path 文件路径
 */
- (void)setFileSavePath:(NSString *)path;

/**
 设置X264

 @param width 视频宽度
 @param height 视频高度
 @param bitrate 视频码率, 码率直接影响编码后视频画面的清晰度, 越大越清晰, 但是为了保证编码后的数据量不至于过大, 以及适应网络带宽传输, 就需要合适的选择该值
 @return 0: 成功 -1: 失败
 */
- (int)setX264ResourceWithVideoWidth:(int)width height:(int)height bitrate:(int)bitrate;

/**
 将CMSampleBufferRef格式的数据编码成H264并写入文件

 @param sampleBuffer sampleBuffer description
 */
- (void)encoderToH264:(CMSampleBufferRef)sampleBuffer;

/**
 释放资源
 */
- (void)freeX264Resource;

@end
