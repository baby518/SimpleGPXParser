//
// Created by zhangchao on 14/10/26.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPXLog.h"

extern NSString * const ROOT_NAME;
extern NSString * const ATTRIBUTE_ROOT_CREATOR;
extern NSString * const ATTRIBUTE_ROOT_VERSION;

extern NSString * const ELEMENT_ROUTE;
extern NSString * const ELEMENT_ROUTE_NUM;
extern NSString * const ELEMENT_ROUTE_POINT;

extern NSString * const ELEMENT_NAME;
extern NSString * const ELEMENT_TRACK;
extern NSString * const ELEMENT_TRACK_SEGMENT;

extern NSString * const ELEMENT_TRACK_POINT;
extern NSString * const ATTRIBUTE_TRACK_POINT_LATITUDE;
extern NSString * const ATTRIBUTE_TRACK_POINT_LONGITUDE;
extern NSString * const ELEMENT_TRACK_POINT_TIME;
extern NSString * const ELEMENT_TRACK_POINT_ELEVATION;

/** @author zhangchao
*  @since 2014-10-26
*  @data 2014-10-26
*  @brief some rules of gpx file. it also used for GPX Parser and GPX Builder.*/
@interface GPXSchema : NSObject {
//    NSDateFormatter * mGPSTimeFormatter;
}
+ (NSDate *) convertString2Time:(NSString *)string;
+ (NSString *) convertTime2String:(NSDate *)time;
@end