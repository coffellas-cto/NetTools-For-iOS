//
//  GDNetOperation.m
//  NetTools
//
//  Created by Alex G on 27.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDNetOperation.h"

@implementation GDNetOperation

- (instancetype)initWithLogger:(GDLogger *)logger {
    self = [super init];
    if (self) {
        _logger = logger;
    }
    return self;
}

- (instancetype)init {
    return [self initWithLogger:nil];
}

@end
