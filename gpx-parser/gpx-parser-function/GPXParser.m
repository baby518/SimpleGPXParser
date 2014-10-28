//
//  gpx-parser.m
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "GPXParser.h"

int const PARSER_ERROR_UNKNOW                       = -1;
/** if file is not a xml or is not complete.*/
int const PARSER_ERROR_UNSUPPORTED                  = 0;
/** if file is not a gpx.*/
int const PARSER_ERROR_UNPARSERALBE                 = 1;

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

- (void)parserRouteElements:(GDataXMLElement *)rootElement {
    NSArray *routes = [rootElement elementsForName:ELEMENT_ROUTE];
    int routesIndex = 0;
    for (GDataXMLElement *rte in routes) {
        routesIndex++;
        //获取 number 节点的值
        NSString *number = [[[rte elementsForName:ELEMENT_ROUTE_NUM] objectAtIndex:0] stringValue];
        LOGD(@"route number :%@", number);

        //获取 rtept 节点
        NSArray *routePoints = [rte elementsForName:ELEMENT_ROUTE_POINT];
        int routePointIndex = 0;
        for (GDataXMLElement *rtept in routePoints) {
            routePointIndex++;
            //获取 rtept 节点下的 lat 和 lon 属性
            NSString *lat = [[rtept attributeForName:ATTRIBUTE_TRACK_POINT_LATITUDE] stringValue];
            NSString *lon = [[rtept attributeForName:ATTRIBUTE_TRACK_POINT_LONGITUDE] stringValue];
            LOGD(@"%d.%d route Point is: (%@, %@)", routesIndex, routePointIndex, lat, lon);
        }
    }
}

- (void)parserTrackElements:(GDataXMLElement *)rootElement {
    NSArray *tracks = [rootElement elementsForName:ELEMENT_TRACK];
    int tracksIndex = 0;
    unsigned long tracksCount = [tracks count];
    double curPercentage = 0;
    double tracksStep = (tracksCount == 0) ? 0.0 : (100.0 / tracksCount);

    for (GDataXMLElement *track in tracks) {
        tracksIndex++;
        //获取 name 节点的值
        NSString *name = [[[track elementsForName:ELEMENT_NAME] objectAtIndex:0] stringValue];
        LOGD(@"track name is:%@", name);

        //获取 trkseg 节点
        NSArray *trackSegments = [track elementsForName:ELEMENT_TRACK_SEGMENT];
        int trksegIndex = 0;
        unsigned long segCount = [trackSegments count];
        double trksegStep = (segCount == 0) ? 0.0 : (tracksStep / segCount);
        for (GDataXMLElement *trkseg in trackSegments) {
            trksegIndex++;
            //获取 trkseg 节点下的 trkpt 节点
            NSArray *trackPoints = [trkseg elementsForName:ELEMENT_TRACK_POINT];
            int trkptIndex = 0;
            unsigned long trkptCount = [trackPoints count];
            double trkptStep = (trkptCount == 0) ? 0.0 : (trksegStep / trkptCount);
            for (GDataXMLElement *point in trackPoints) {
                trkptIndex++;
                //获取 trkpt 节点下的 lat 和 lon 属性, time 和 ele 节点
                NSString *lat = [[point attributeForName:ATTRIBUTE_TRACK_POINT_LATITUDE] stringValue];
                NSString *lon = [[point attributeForName:ATTRIBUTE_TRACK_POINT_LONGITUDE] stringValue];
                NSString *time = [[[point elementsForName:ELEMENT_TRACK_POINT_TIME] objectAtIndex:0] stringValue];
                NSString *ele = [[[point elementsForName:ELEMENT_TRACK_POINT_ELEVATION] objectAtIndex:0] stringValue];
                LOGD(@"%d.%d.%d track Point is: (%@, %@), Time is: %@, Elevation is: %@.",
                        tracksIndex, trksegIndex, trkptIndex, lat, lon, time, ele);
                curPercentage = curPercentage + trkptStep;
                [self printPercentageOfParser:curPercentage];
            }
            if (trkptCount == 0) {
                curPercentage = curPercentage + trksegStep;
                [self printPercentageOfParser:curPercentage];
            }
        }
        if (trksegStep == 0) {
            curPercentage = curPercentage + tracksStep;
            [self printPercentageOfParser:curPercentage];
        }
    }
    [self printPercentageOfParser:100];
}

- (void)printPercentageOfParser:(double)percentage {
    if (percentage < 0) percentage = 0;
    if (percentage > 100) percentage = 100;
    int result = percentage;
    dispatch_async(dispatch_get_main_queue(), ^{
        [delegate onPercentageOfParser:result];
    });
}

- (void)parserAllElements {
    if (mRootElement == nil) {
        LOGE(@"Root Element is not found !!!");
        [delegate onErrorWhenParser:PARSER_ERROR_UNSUPPORTED];
        return;
    } else if (![[mRootElement name] isEqualToString:ROOT_NAME]) {
        LOGE(@"This xml file's ROOT is %@, it seems not a gpx file !!!", [mRootElement name]);
        [delegate onErrorWhenParser:PARSER_ERROR_UNPARSERALBE];
        return;
    }

    // use async to parser.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *creator = [[mRootElement attributeForName:ATTRIBUTE_ROOT_CREATOR] stringValue];
        LOGD(@"This xml file's CREATOR is %@", creator);
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate rootCreatorDidParser:creator];
        });

        NSString *version = [[mRootElement attributeForName:ATTRIBUTE_ROOT_VERSION] stringValue];
        LOGD(@"This xml file's VERSION is %@", version);
        dispatch_async(dispatch_get_main_queue(), ^{
            [delegate rootVersionDidParser:version];
        });

        //获取根节点下的节点（ rte ）
        [self parserRouteElements:mRootElement];

        //获取根节点下的节点（ trk ）
        [self parserTrackElements:mRootElement];
    });
}


@end
