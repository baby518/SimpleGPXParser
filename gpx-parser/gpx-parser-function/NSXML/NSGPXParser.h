//
//  NSObject+NSGPXParser.h
//  gpx-parser
//
//  Created by zhangchao on 14/12/12.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPXSchema.h"
#import "GPXLog.h"

/** @author zhangchao
*  @since 2014-10-27
*  @data 2014-10-27
*  @brief Delegate for View.*/
@protocol NSGPXParserDelegate <NSObject>
@optional
- (void)onErrorWhenParser:(int)errorCode;
- (void)rootCreatorDidParser:(NSString *)creator;
- (void)rootVersionDidParser:(NSString *)version;
@end

@interface NSGPXParser : NSObject <NSXMLParserDelegate>

@property(nonatomic, assign) id <NSGPXParserDelegate> delegate;
@property(nonatomic, strong) NSXMLParser *gpxParser;
@property(nonatomic, strong, readonly) NSData *mXMLData;
@property(nonatomic, assign, readonly) bool isNeedCheckRootElement;

- (id)initWithData:(NSData *)data;

- (void)satrtParser;
@end
