//
//  VideoEncoder.m
//  VideoToolBox
//
//  Created by 韩俊强 on 2017/7/24.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import "VideoEncoder.h"

@interface VideoEncoder()

/** 记录当前的帧数 **/
@property (nonatomic, assign) NSInteger frameID;

/** 编码会话 **/
@property (nonatomic, assign) VTCompressionSessionRef compressionSession;

/** 文件写入 **/
@property (nonatomic, strong) NSFileHandle *fileHandle;

@end

@implementation VideoEncoder

- (instancetype)init
{
    if (self = [super init]) {
        // 1.初始化写入文件的对象(NSFileHandle用于写入二进制文件)
        [self setupFileHandle];
        
        // 2.初始化压缩编码的会话
        [self setupVideoSession];
    }
    return self;
}

- (void)setupFileHandle
{
    // 1.获取沙盒路径
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"abc.h264"];
    
    // 2.如果原来有文件, 则删除
    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    [[NSFileManager defaultManager] createFileAtPath:file contents:nil attributes:nil];
    
    // 3.创建对象
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:file];
}

- (void)setupVideoSession
{
    // 1.用于记录当前是第几帧数据
    self.frameID = 0;
    
    // 2.录制视频的宽度&高度
    int width = [UIScreen mainScreen].bounds.size.width;
    int height = [UIScreen mainScreen].bounds.size.height;
    
    // 3.创建CompressionSession 对象, 该对象用于对画面进行编码
    VTCompressionSessionCreate(NULL, width, height, kCMVideoCodecType_H264, NULL, NULL, NULL, didCompressH264, (__bridge void *)(self), &_compressionSession);
    
    // 4.设置实时编码输出 (直播必然是实时输出, 否则会有延迟)
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_RealTime, kCFBooleanTrue);
    
    // 5.设置期望帧率(每秒多少帧, 如果帧率过低, 会造成画面卡顿)
    int fps = 30;
    CFNumberRef fpsRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &fps);
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_ExpectedFrameRate, fpsRef);
    
    // 6.设置码率(码率: 编码效率, 码率越高, 则画面越清晰, 如果码率比较低会引起马赛克, 码率高有利于还原原始画面, 但是也不利于传输)
    int bitRate = 800*1024;
    CFNumberRef bitRateRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &bitRate);
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_AverageBitRate, bitRateRef);
    NSArray *limit = @[@(bitRate * 1.5/8), @(1)];
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_DataRateLimits, (__bridge CFArrayRef)limit);
    
    // 7.设置关键帧 (GOPsize)间隔
    int frameInterval = 30;
    CFNumberRef frameIntervalRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberIntType, &frameInterval);
    VTSessionSetProperty(self.compressionSession, kVTCompressionPropertyKey_MaxKeyFrameInterval, frameIntervalRef);
    
    // 8.基本设置结束, 准备进行编码
    VTCompressionSessionPrepareToEncodeFrames(self.compressionSession);
}

// 编码完成回调
void didCompressH264(void *outputCallbackRedCon, void *sourceFrameRefCon, OSStatus status, VTEncodeInfoFlags infoFlags, CMSampleBufferRef sampleBuffer)
{
    // 1.判断状态是否有错误
    if (status != noErr) {
        return;
    }
    
    // 2.genuine传入的参数获取对象
    VideoEncoder *encoder = (__bridge VideoEncoder *)outputCallbackRedCon;
    
    // 3.判断是否是关键帧
    bool isKeyframe = !CFDictionaryContainsKey((CFArrayGetValueAtIndex(CMSampleBufferGetSampleAttachmentsArray(sampleBuffer, true), 0)), kCMSampleAttachmentKey_NotSync);
    // 获取sps & pps数据
    if (isKeyframe) {
        // 获取编码后的信息 (存储于CMFormatDescriptionRef中)
        CMFormatDescriptionRef format = CMSampleBufferGetFormatDescription(sampleBuffer);
        
        // 获取SPS信息
        size_t sparameterSetSize, sparameterSetCount;
        const uint8_t *sparameterSet;
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 0, &sparameterSet, &sparameterSetSize, &sparameterSetCount, 0);
        
        // 获取PPS信息
        size_t pparameterSetSize, pparmeterSetCount;
        const uint8_t *pparameterSet;
        CMVideoFormatDescriptionGetH264ParameterSetAtIndex(format, 1, &pparameterSet, &pparameterSetSize, &pparmeterSetCount, 0);
        
        // 装sps/pps转成NSData, 以方便写入
        NSData *sps = [NSData dataWithBytes:sparameterSet length:sparameterSetSize];
        NSData *pps = [NSData dataWithBytes:pparameterSet length:pparameterSetSize];
        
        // 写入文件
        [encoder gotSpsPps:sps pps:pps];
    }
    
    // 获取数据模块
    CMBlockBufferRef dataBuffer = CMSampleBufferGetDataBuffer(sampleBuffer);
    size_t length, totalLength;
    char *dataPointer;
    OSStatus statusCodeRet = CMBlockBufferGetDataPointer(dataBuffer, 0, &length, &totalLength, &dataPointer);
    if (statusCodeRet == noErr) {
        size_t bufferOffset = 0;
        static const int AVCCHeaderLength = 4; //返回的 NALU 数据前四个字节不是0001的startcode, 而是大端模式的帧长度length
        
        // 循环获取 NALU 数据
        while (bufferOffset < totalLength - AVCCHeaderLength) {
            uint32_t NALUnitLenghth = 0;
            // Read the NAL unit length
            memcpy(&NALUnitLenghth, dataPointer + bufferOffset, AVCCHeaderLength);
            
            // 从大端转系统端
            NALUnitLenghth = CFSwapInt32BigToHost(NALUnitLenghth);
            
            NSData *data = [[NSData alloc]initWithBytes:(dataPointer + bufferOffset + AVCCHeaderLength) length:NALUnitLenghth];
            [encoder gotEncodedData:data isKeyFrame:isKeyframe];
            
            // 移动到写一个块, 转成 NALU 单元
            // Move to the next NAL unit in the block buffer
            bufferOffset += AVCCHeaderLength + NALUnitLenghth;
        }
    }
}

- (void)gotSpsPps:(NSData *)sps pps:(NSData *)pps
{
    // 1.拼接NALU的header
    const char bytes[] = "\x00\x00\x00\x01";
    size_t length = (sizeof(bytes)) - 1;
    NSData *byteHeader = [NSData dataWithBytes:bytes length:length];
    
    // 2.将NALU的头 & NALU的体写入文件
    [self.fileHandle writeData:byteHeader];
    [self.fileHandle writeData:sps];
    [self.fileHandle writeData:byteHeader];
    [self.fileHandle writeData:pps];
}

- (void)gotEncodedData:(NSData *)data isKeyFrame:(BOOL)isKeyFrame
{
    NSLog(@"gotEncodedData %d",(int)[data length]);
    if (self.fileHandle != NULL) {
        const char bytes[] = "\x00\x00\x00\x01";
        size_t length = (sizeof(bytes)) - 1;//string literals have implicit trailing '\0'
        NSData *byteHeader = [NSData dataWithBytes:bytes length:length];
        [self.fileHandle writeData:byteHeader];
        [self.fileHandle writeData:data];
    }
}

- (void)encoderSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    // 1.将sampleBuffer转成imageBuffer
    CVImageBufferRef imageBuffer = (CVImageBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // 2.根据当前的帧数, 创建CMTime的时间
    CMTime presentationTimeStamp = CMTimeMake(self.frameID++, 1000);
    VTEncodeInfoFlags flags;
    
    // 3.开始编码该帧数据
    OSStatus statusCode = VTCompressionSessionEncodeFrame(self.compressionSession, imageBuffer, presentationTimeStamp, kCMTimeInvalid, NULL, (__bridge void* _Nullable)(self), &flags);
    if (statusCode == noErr) {
        NSLog(@"H264: VTCompressionSessionEncodeFrame Success");
    }
}

- (void)endEncode
{
    VTCompressionSessionCompleteFrames(self.compressionSession, kCMTimeInvalid);
    VTCompressionSessionInvalidate(self.compressionSession);
    CFRelease(self.compressionSession);
    self.compressionSession = NULL;
}

@end
