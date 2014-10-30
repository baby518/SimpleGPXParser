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
#import "GPXLog.h"
#import "TrackPoint.h"

extern int const PARSER_ERROR_UNKNOW;
/** if file is not a xml or is not complete.*/
extern int const PARSER_ERROR_UNSUPPORTED;
/** if file is not a gpx.*/
extern int const PARSER_ERROR_UNPARSERALBE;

/** @author zhangchao
*  @since 2014-10-27
*  @data 2014-10-27
*  @brief Delegate for View.*/
@protocol GPXParserDelegate <NSObject>
@optional
/** PARSER_ERROR_UNSUPPORTED or PARSER_ERROR_UNPARSERALBE */
- (void)onErrorWhenParser:(int)errorCode;
- (void)rootCreatorDidParser:(NSString *)creator;
- (void)rootVersionDidParser:(NSString *)version;
- (void)onPercentageOfParser:(double)percentage;
- (void)trackPointDidParser:(TrackPoint *)trackPoint;
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
- (void)postPercentageOfParser:(double)percentage;
- (void)postTrackPointOfParser:(TrackPoint *)point;

@end
