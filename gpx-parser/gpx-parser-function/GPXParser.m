//
//  gpx-parser.m
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "GPXParser.h"

@implementation GPXParser

@synthesize delegate;

- (GPXParser *)initWithData:(NSData *)data {
    self = [super self];
    if (self) {
        mXMLData = data;
        mXMLDoc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        mRootElement = [mXMLDoc rootElement];
    }
    return self;
}

- (void)parserAllElements {
    if (mRootElement == nil) {
        NSLog(@"Root Element is not found !!!");
        return;
    } else if (![[mRootElement name] isEqualToString:ROOT_NAME]) {
        NSLog(@"This xml file's ROOT is %@", [mRootElement name]);
        NSLog(@"This xml file seems isn't a gpx file !!!");
        return;
    }

    NSLog(@"-------------------");
    NSString *creator = [[mRootElement attributeForName:ATTRIBUTE_ROOT_CREATOR] stringValue];
    NSLog(@"This xml file's CREATOR is %@", creator);
    [delegate rootCreatorDidParser:creator];

    NSString *version = [[mRootElement attributeForName:ATTRIBUTE_ROOT_VERSION] stringValue];
    NSLog(@"This xml file's VERSION is %@", version);
    [delegate rootVersionDidParser:version];

    //获取根节点下的节点（ trk ）
    NSArray *tracks = [mRootElement elementsForName:ELEMENT_TRACK];

    for (GDataXMLElement *track in tracks) {
        //获取 name 节点的值
        NSString *name = [[[track elementsForName:ELEMENT_NAME] objectAtIndex:0] stringValue];
        NSLog(@"track name is:%@", name);

        //获取 trkseg 节点
        GDataXMLElement *trksegElement = [[track elementsForName:ELEMENT_TRACK_SEGMENT] objectAtIndex:0];
        //获取 trkseg 节点下的 trkpt 节点
        NSArray *trackPoints = [trksegElement elementsForName:ELEMENT_TRACK_POINT];
        for (GDataXMLElement *point in trackPoints) {
            //获取 trkpt 节点下的 lat 和 lon 属性, time 和 ele 节点
            NSString *lat = [[point attributeForName:ATTRIBUTE_TRACK_POINT_LATITUDE] stringValue];
            NSString *lon = [[point attributeForName:ATTRIBUTE_TRACK_POINT_LONGITUDE] stringValue];
            NSString *time = [[[point elementsForName:ELEMENT_TRACK_POINT_TIME] objectAtIndex:0] stringValue];
            NSString *ele = [[[point elementsForName:ELEMENT_TRACK_POINT_ELEVATION] objectAtIndex:0] stringValue];
            NSLog(@"track Point is: (%@, %@), Time is: %@, Elevation is: %@.", lat, lon, time, ele);
        }
        NSLog(@"-------------------");
    }
}
@end
