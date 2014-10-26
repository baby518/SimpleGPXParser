//
//  gpx-parser.m
//  gpx-parser
//
//  Created by zhangchao on 14/8/17.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "GPXParser.h"

@implementation GPXParser

- (GPXParser *)initWithData:(NSData *)data {
    self = [super self];
    if (self) {
        mXMLDoc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
        mRootElement = [mXMLDoc rootElement];
    }
    return self;
}

- (void)printAllElements {
    if (mRootElement == nil) {
        NSLog(@"Root Element is not found !!!");
        return;
    }
    //获取根节点下的节点（ User ）
    NSArray *users = [mRootElement elementsForName:@"User"];

    for (GDataXMLElement *user in users) {
        //User节点的 id 属性
        NSString *userId = [[user attributeForName:@"id"] stringValue];
        NSLog(@"User id is:%@", userId);

        //获取 name 节点的值
        GDataXMLElement *nameElement = [[user elementsForName:@"name"] objectAtIndex:0];
        NSString *name = [nameElement stringValue];
        NSLog(@"User name is:%@", name);

        //获取 age 节点的值
        GDataXMLElement *ageElement = [[user elementsForName:@"age"] objectAtIndex:0];
        NSString *age = [ageElement stringValue];
        NSLog(@"User age is:%@", age);
        NSLog(@"-------------------");
    }
}
@end
