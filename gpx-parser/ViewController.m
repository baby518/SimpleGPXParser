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
    NSLog(@"Start");
    NSString* path = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"gpx"];
    NSLog(@"path＝%@", path);
    // Do any additional setup after loading the view.

}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.

}

@end
