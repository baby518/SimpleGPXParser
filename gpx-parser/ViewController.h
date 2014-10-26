//
//  ViewController.h
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GPXParser.h"

@interface ViewController : NSViewController <GPXParserDelegate>

@property (weak) IBOutlet NSTextField *mPathTextField;
@property (weak) IBOutlet NSTextField *mCreatorTextField;
@property (weak) IBOutlet NSTextField *mVersionTextField;

- (IBAction)openFileButtonPressed:(NSButton *)sender;

- (NSString *)getFilePathFromDialog;
- (NSData *)loadDataFromFile:(NSString *)path;
@end

