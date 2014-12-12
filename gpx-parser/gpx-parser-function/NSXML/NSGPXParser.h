//
//  NSObject+NSGPXParser.h
//  gpx-parser
//
//  Created by zhangchao on 14/12/12.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPXLog.h"

@interface NSGPXParser : NSObject <NSXMLParserDelegate>

@property(nonatomic, strong) NSXMLParser *gpxParser;
@property(nonatomic, strong, readonly) NSData *mXMLData;

- (id)initWithData:(NSData *)data;

- (void)satrtParser;
@end
