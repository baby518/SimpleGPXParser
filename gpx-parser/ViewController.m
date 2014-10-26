//
//  ViewController.m
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
#import "GPXParser.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Start");
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"gpx"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"gpx"];
    NSLog(@"path＝%@", path);
    // Do any additional setup after loading the view.

    NSData *data = [[NSData alloc] initWithContentsOfFile:path];

    GPXParser *gpxParser = [[GPXParser alloc] initWithData:data];
    [gpxParser printAllElements];

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.

}

@end
