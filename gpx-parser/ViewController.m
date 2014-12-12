//
//  ViewController.m
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_mStartParseButton setEnabled:false];
    [_mParserProgress setDoubleValue:0];
    [_mParserProgress setIndeterminate:NO];
    [_mParserProgress setUsesThreadedAnimation:NO];

    [_mParserCircleProgress setDoubleValue:0];
    [_mParserCircleProgress setIndeterminate:NO];
    [_mParserCircleProgress setUsesThreadedAnimation:NO];

    _numberOfRows = 0;
    _currentTrackPoints = [NSMutableArray array];

    _parserCallBackMode = PARSER_CALLBACK_MODE_JUST_RESULT;

    // ++++++ not work, need developer id.
    [_mGPXMapView setMapType:MKMapTypeStandard];
    _mGPXMapView.showsUserLocation = YES;
    _mGPXMapView.delegate = self;

    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude=21.238928;
    theCoordinate.longitude=113.313353;

    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta=0.1;
    theSpan.longitudeDelta=0.1;

    MKCoordinateRegion theRegion;
    theRegion.center=theCoordinate;
    theRegion.span=theSpan;

    [_mGPXMapView setRegion:theRegion];
    // ------
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

- (IBAction)openFileButtonPressed:(NSButton *)sender {
    NSLog(@"Button CLicked.");

    NSString *path = [self getFilePathFromDialog];
    if (path != nil) {
        // show path in Text Field.
        [_mPathTextField setStringValue:path];
        [_mParseStateInfoLabel setStringValue:@""];
        [_mParserProgress setDoubleValue:0];
        [_mParserCircleProgress setDoubleValue:0];
    }
    mData = [self loadDataFromFile:path];
    if (mData != nil) [_mStartParseButton setEnabled:true];
}

- (IBAction)startParserButtonPressed:(NSButton *)sender {
    [self removeAllObjectsOfTable];

    if (mData != nil) {
//        GPXParser *gpxParser = [[GPXParser alloc] initWithData:mData];
//        gpxParser.delegate = self;
//        gpxParser.callbackMode = _parserCallBackMode;
//        [gpxParser parserAllElements];

        NSGPXParser *gpxParser = [[NSGPXParser alloc] initWithData:mData];
        [gpxParser satrtParser];
    }
}

- (NSData *)loadDataFromFile:(NSString *)path {
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil) {
        NSLog(@"loadDataFromFile data is NULL !!!");
    }
//    NSString *strData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"loadDataFromFile data is %@", strData);
    return data;
}

- (NSString *)getFilePathFromDialog {
    // Create the File Open Dialog class.
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
//    // Enable the selection of files in the dialog.
//    [openPanel setCanChooseFiles:YES];
//    // Multiple files not allowed
//    [openPanel setAllowsMultipleSelection:NO];
    // Can't select a directory
    [openPanel setCanChooseDirectories:NO];
    // set file type.
    [openPanel setAllowedFileTypes:[NSArray arrayWithObjects:@"gpx"/*, @"xml"*/, nil]];

    NSString *result = nil;

// single selection
    if ([openPanel runModal] == NSModalResponseOK) {
        result = [[openPanel URLs] objectAtIndex:0];
    }

    NSLog(@"getFilePathFromDialog Url: %@", result);
    return result;
}

- (void)removeAllObjectsOfTable {
    [_currentTrackPoints removeAllObjects];
    _numberOfRows = 0;
    [_mGPXTableView reloadData];
}

#pragma mark - GPXParserDelegate
- (void)rootCreatorDidParser:(NSString *)creator {
    NSLog(@"rootCreatorDidParser from GPXParserDelegate. %@", creator);
    [_mCreatorTextField setStringValue:creator];
}

- (void)rootVersionDidParser:(NSString *)version {
    NSLog(@"rootVersionDidParser from GPXParserDelegate. %@", version);
    [_mVersionTextField setStringValue:version];
}

- (void)onErrorWhenParser:(int)errorCode {
    NSLog(@"onErrorWhenParser from GPXParserDelegate, errorCode : %d", errorCode);
    [_mParseStateInfoLabel setStringValue:[NSString stringWithFormat:@"Error :%d", errorCode]];
}

- (void)onPercentageOfParser:(double)percentage {
//    NSLog(@"onPercentOfParser from GPXParserDelegate, percentage : %d", percentage);
    [_mParseStateInfoLabel setStringValue:[NSString stringWithFormat:@"%.2f%%", percentage]];
    [_mParserProgress setDoubleValue:percentage];
    [_mParserCircleProgress setDoubleValue:percentage];
}

- (void)trackPointDidParser:(TrackPoint *)trackPoint {
    if (_parserCallBackMode == PARSER_CALLBACK_MODE_ALL) {
        [_currentTrackPoints addObject:trackPoint];
        _numberOfRows = [_currentTrackPoints count];
    }
}

- (void)trackSegmentDidParser:(TrackSegment *)segment {
//    // if we want show some item while parsing data.
//    if (_parserCallBackMode == PARSER_CALLBACK_MODE_ALL) {
//        [_mGPXTableView reloadData];
//    }
}

- (void)trackDidParser:(Track *)track {
//    if (track == nil) return;
    // if we want show some item while parsing data.
    if (_parserCallBackMode == PARSER_CALLBACK_MODE_ALL) {
        [_mGPXTableView reloadData];
    }
}

- (void)allTracksDidParser:(NSArray *)tracks {
    _allTracks = [NSArray arrayWithArray:tracks];
    double length = 0;
    double elevationGain = 0;
    double totalTime = 0;
    for (Track *track in tracks) {
        length += track.length;
        elevationGain += track.elevationGain;
        totalTime += track.totalTime;
    }
    [_mLengthTextField setStringValue:[NSString stringWithFormat:@"%.2f", length]];
    [_mElevationGainTextField setStringValue:[NSString stringWithFormat:@"%.2f", elevationGain]];
    [_mTotalTimeTextField setStringValue:[NSString stringWithFormat:@"%.2f", totalTime]];

    // reload here if use PARSER_CALLBACK_MODE_JUST_RESULT
    if (_parserCallBackMode == PARSER_CALLBACK_MODE_JUST_RESULT) {
        _numberOfRows = 0;
        for (Track *track in tracks) {
            _numberOfRows += track.countOfPoints;
            for (TrackSegment *segment in [track trackSegments]) {
                for (TrackPoint *point in [segment trackPoints]) {
                    [_currentTrackPoints addObject:point];
                }
            }
        }
        [_mGPXTableView reloadData];
    }
}

#pragma mark - NSTableViewDelegate
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    // Get a new ViewCell
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];

    if ([tableColumn.identifier isEqualToString:@"trackID"]) {
        [[cellView textField] setStringValue:[NSString stringWithFormat:@"%ld", row + 1]];
        return cellView;
    } else if ([tableColumn.identifier isEqualToString:@"trackTime"]) {
        NSDate *time = [[[_currentTrackPoints objectAtIndex:row] getLocation] timestamp];
        [[cellView textField] setStringValue:[GPXSchema convertTime2String:time]];
        return cellView;
    } else if ([tableColumn.identifier isEqualToString:@"trackLon"]) {
        double lon = [[_currentTrackPoints objectAtIndex:row] longitude];
        [[cellView textField] setStringValue:[NSString stringWithFormat:@"%f", lon]];
        return cellView;
    } else if ([tableColumn.identifier isEqualToString:@"trackLat"]) {
        double lat = [[_currentTrackPoints objectAtIndex:row] latitude];
        [[cellView textField] setStringValue:[NSString stringWithFormat:@"%f", lat]];
        return cellView;
    } else if ([tableColumn.identifier isEqualToString:@"trackEle"]) {
        double ele = [[[_currentTrackPoints objectAtIndex:row] getLocation] altitude];
        [[cellView textField] setStringValue:[NSString stringWithFormat:@"%f", ele]];
        return cellView;
    }

    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return _numberOfRows;
}

//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
//{
//    return [NSString stringWithFormat:@"row %ld", row];
//}

@end
