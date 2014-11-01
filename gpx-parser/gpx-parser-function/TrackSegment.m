//
// Created by zhangchao on 14/10/31.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import "TrackSegment.h"


@implementation TrackSegment {

}

-(id)init {
    self = [super init];
    if (self) {
        mTrackPoints = [NSMutableArray array];
    }
    return self;
}

- (void)addTrackpoint:(TrackPoint *)trackPoint {
    [mTrackPoints addObject:trackPoint];
    if ([mTrackPoints count] > 1) {
        TrackPoint *last = mTrackPoints[[mTrackPoints count] - 2];
        // figure out distance from last point
        _length += [[last getLocation] distanceFromLocation:[trackPoint getLocation]];
    }
}

@end