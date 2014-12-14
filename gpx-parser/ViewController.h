//
//  ViewController.h
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <MapKit/MapKit.h>
#import "GPXParser.h"
#import "NSGPXParser.h"

@interface ViewController : NSViewController <NSGPXParserDelegate, GPXParserDelegate, NSTableViewDataSource, NSTableViewDelegate, MKMapViewDelegate> {
    NSData *mData;
}

@property (weak) IBOutlet NSTextField *mPathTextField;
@property (weak) IBOutlet NSTextField *mCreatorTextField;
@property (weak) IBOutlet NSTextField *mVersionTextField;
@property (weak) IBOutlet NSTextField *mParseStateInfoLabel;
@property (weak) IBOutlet NSTextField *mLengthTextField;
@property (weak) IBOutlet NSTextField *mTotalTimeTextField;
@property (weak) IBOutlet NSTextField *mElevationGainTextField;
@property (weak) IBOutlet NSProgressIndicator *mParserProgress;
@property (weak) IBOutlet NSButton *mStartParseButton;
@property (weak) IBOutlet NSProgressIndicator *mParserCircleProgress;

@property (weak) IBOutlet MKMapView *mGPXMapView;
@property (weak) IBOutlet NSTableView *mGPXTableView;
@property (nonatomic, assign) long numberOfRows;
@property (nonatomic, assign) NSArray * allTracks;
@property (nonatomic, copy) NSMutableArray *currentTrackPoints;
@property (nonatomic, assign) int parserCallBackMode;

- (IBAction)openFileButtonPressed:(NSButton *)sender;
- (IBAction)startParserButtonPressed:(NSButton *)sender;

- (NSString *)getFilePathFromDialog;
- (NSData *)loadDataFromFile:(NSString *)path;

- (void)removeAllObjectsOfTable;
@end

