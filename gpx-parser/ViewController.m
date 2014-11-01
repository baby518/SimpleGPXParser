//
//  ViewController.m
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "ViewController.h"
#import "GPXParser.h"

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
    }
    mData = [self loadDataFromFile:path];
    if (mData != nil) [_mStartParseButton setEnabled:true];
}

- (IBAction)startParserButtonPressed:(NSButton *)sender {
    if (mData != nil) {
        GPXParser *gpxParser = [[GPXParser alloc] initWithData:mData];
        gpxParser.delegate = self;
        [gpxParser parserAllElements];
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

}

- (void)trackSegmentDidParser:(TrackSegment *)segment {

}

@end
