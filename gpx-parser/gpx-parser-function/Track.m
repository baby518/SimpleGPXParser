//
// Created by zhangchao on 14/10/31.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import "Track.h"

@implementation Track {

}

- (id)init {
    return [self initWithName:@""];
}

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        mTracks = [NSMutableArray array];
    }
    _trackName = name;
    return self;
}

- (void)addTrackSegment:(TrackSegment *)trkseg {
    [mTracks addObject:trkseg];
    _length += trkseg.length;
}

@end