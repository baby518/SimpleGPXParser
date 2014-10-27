//
// Created by zhangchao on 14/10/27.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import "GPXLog.h"

@implementation GPXLog {
}

+ (void)LOGD:(NSString *)string {
#if DEBUG
    NSLog(@"GPX DEBUG %@", string);
#endif
}

+ (void)LOGW:(NSString *)string {
    NSLog(@"GPX WARNING %@", string);
}

+ (void)LOGE:(NSString *)string {
    NSLog(@"GPX ERROR %@", string);
}
@end