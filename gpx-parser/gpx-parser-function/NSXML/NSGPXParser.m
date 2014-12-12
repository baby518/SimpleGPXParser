//
//  NSObject+NSGPXParser.m
//  gpx-parser
//
//  Created by zhangchao on 14/12/12.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "NSGPXParser.h"

@implementation NSGPXParser

- (id)initWithData:(NSData *)data {
    self = [super self];
    if (self) {
        _mXMLData = data;
    }
    return self;
}

- (void)satrtParser {
    LOGD(@"satrtParser");
    dispatch_async(dispatch_get_main_queue(), ^{
        _gpxParser = [[NSXMLParser alloc] initWithData:_mXMLData];
        _gpxParser.delegate = self;
        [_gpxParser setShouldProcessNamespaces:YES];
        [_gpxParser setShouldReportNamespacePrefixes:YES];
        [_gpxParser setShouldResolveExternalEntities:YES];
        [_gpxParser parse];
    });
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    LOGD(@"parserDidStartDocument");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    LOGD(@"parserDidEndDocument");
}

/*
 * Sent by a parser object to its delegate when it encounters a start tag for a given element.
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    LOGD(@"didStartElement elementName : %@", elementName);
}

/*
 *
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    LOGD(@"didEndElement elementName : %@", elementName);
}

/*
 * The parser object may send the delegate several parser:foundCharacters: messages to report the characters of an element.
 * Because string may be only part of the total character content for the current element,
 * you should append it to the current accumulation of characters until the element changes.
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    LOGD(@"foundCharacters : %@", string);
}

@end
