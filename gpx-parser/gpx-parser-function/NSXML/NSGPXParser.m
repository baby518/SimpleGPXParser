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
        unsigned long size = [data length];
        LOGD(@"initWithData size : %lu Byte, %lu KB", size, size / 1024);
        _mXMLData = data;
    }
    return self;
}

- (void)satrtParser {
    LOGD(@"satrtParser");
    dispatch_async(dispatch_get_main_queue(), ^{
        _isNeedCheckRootElement = true;
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

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    LOGD(@"parseErrorOccurred %@", parseError);
    [_delegate onErrorWhenParser:parseError.code];
}

/*
 * Sent by a parser object to its delegate when it encounters a start tag for a given element.
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    LOGD(@"didStartElement elementName : %@", elementName);
    if (attributeDict.count > 0) {
        LOGD(@"didStartElement attributeDict : %@", attributeDict);
    }

    if (_isNeedCheckRootElement) {
        if (![elementName isEqualToString:ROOT_NAME]) {
            LOGD(@"parseErrorOccurred : is not a gpx file.");
            /* if file is not a gpx. Like GPXParser's PARSER_ERROR_UNPARSERALBE.*/
            [_delegate onErrorWhenParser:1];
            [parser abortParsing];
        } else {
            _isNeedCheckRootElement = false;
        }
    }

    if ([elementName isEqualToString:ROOT_NAME]) {
        NSString *creator = attributeDict[ATTRIBUTE_ROOT_CREATOR];//[attributeDict objectForKey:ATTRIBUTE_ROOT_CREATOR];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate rootCreatorDidParser:creator];
        });
        NSString *version = attributeDict[ATTRIBUTE_ROOT_VERSION];//[attributeDict objectForKey:ATTRIBUTE_ROOT_VERSION];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegate rootVersionDidParser:version];
        });
    } else if ([elementName isEqualToString:ELEMENT_ROUTE]) {

    }
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
    // almost \n and TAB
//    if (string.length > 0) {
        LOGD(@"foundCharacters : %@, length : %d", string, string.length);
//    }
}

@end
