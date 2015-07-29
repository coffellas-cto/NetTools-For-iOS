//
//  GDLogger.m
//  NetTools
//
//  Created by Alex G on 27.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDLogger.h"

@implementation GDLogger

- (void)logLine:(NSString *)logString {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSLog(@"%@", logString);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"hh:mm:ss";
    }
    return self;
}

@end
