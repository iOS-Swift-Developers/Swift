//
//  VideoCapture.h
//  VideoToolBox
//
//  Created by 韩俊强 on 2017/7/24.
//  Copyright © 2017年 HaRi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCapture : NSObject

- (void)startCapture:(UIView *)preview;

- (void)stopCapture;

@end
