//
//  gpx-parser.h
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "GPXSchema.h"
#include "GPXLog.h"

/** @author zhangchao
*  @since 2014-10-27
*  @data 2014-10-27
*  @brief Delegate for View.*/
@protocol GPXParserDelegate <NSObject>
@optional
- (void)rootCreatorDidParser:(NSString *)creator;
- (void)rootVersionDidParser:(NSString *)version;
@end

/** @author zhangchao
 *  @since 2014-8-18
 *  @data 2014-10-26
 *  @brief used for parse the gpx file.*/
@interface GPXParser : NSObject {
@protected
    NSData *mXMLData;
    GDataXMLDocument *mXMLDoc;
    GDataXMLElement *mRootElement;
}
@property (nonatomic, assign) id <GPXParserDelegate> delegate;

- (GPXParser *)initWithData:(NSData *)data;
- (void)parserAllElements;
- (void)parserRouteElements:(GDataXMLElement *)rootElement;
- (void)parserTrackElements:(GDataXMLElement *)rootElement;

@end
