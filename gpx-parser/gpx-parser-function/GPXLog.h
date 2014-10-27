//
// Created by zhangchao on 14/10/27.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GPXLog : NSObject
/** debug log*/
+ (void)LOGD:(NSString *)string;
/** warning log*/
+ (void)LOGW:(NSString *)string;
/** error log*/
+ (void)LOGE:(NSString *)string;
@end