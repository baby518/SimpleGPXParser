//
// Created by zhangchao on 14/10/31.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackPoint.h"

@interface TrackSegment : NSObject

// The total length, in meters, of this segment
@property(nonatomic, assign, readonly) double length;

// The total elevation gain, in meters, of this segment
@property(nonatomic, assign, readonly) double elevationGain;

// array of GPXTrackpoint objects
@property(nonatomic, copy) NSArray *trackpoints;

- (void)addTrackpoint:(TrackPoint *)trackpoint;

@end