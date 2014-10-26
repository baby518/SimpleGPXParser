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

- (GPXParser *)initWithData:(NSData *)data;
- (void)printAllElements;

@end
