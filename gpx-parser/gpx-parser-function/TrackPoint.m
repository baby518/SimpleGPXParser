//
// Created by zhangchao on 14/10/29.
// Copyright (c) 2014 zhangchao. All rights reserved.
//

#import "TrackPoint.h"


@implementation TrackPoint {
}

- (CLLocation *)getLocation {
    if (!_location) {
        _location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(self.latitude, self.longitude)
                                                  altitude:self.elevation
                                        horizontalAccuracy:0
                                          verticalAccuracy:0
                                                    course:0
                                                     speed:0
                                                 timestamp:self.time];
    }
    return _location;
}

- (TrackPoint *)initWithTrack:(double)latitude :(double)longitude :(double)elevation :(NSDate *)time {
    self = [super self];
    if (self) {
        _location = [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude)
                                                  altitude:elevation
                                        horizontalAccuracy:0
                                          verticalAccuracy:0
                                                    course:0
                                                     speed:0
                                                 timestamp:time];
    }
    return self;
}

@end