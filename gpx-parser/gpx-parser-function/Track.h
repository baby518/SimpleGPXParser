//
// Created by zhangchao on 14/10/31.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackSegment.h"

@interface Track : NSObject {
    NSMutableArray *mTracks;
}

// the name of the track
@property (nonatomic, copy) NSString * trackName;

// array of GPXTrackSegment objects
@property (nonatomic, copy, readonly) NSArray* trackSegments;

// total length, in meters, of the track
@property (nonatomic, assign, readonly) double length;

// total gain, in meters
@property (nonatomic, assign, readonly) double elevationGain;

- (id)initWithName:(NSString *)name;
- (void)addTrackSegment:(TrackSegment *)trkseg;

@end