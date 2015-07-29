//
//  GDPingOperation.m
//  NetTools
//
//  Created by Alex G on 27.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDPingOperation.h"

@implementation GDPingOperation

#pragma mark - Accessors

- (void)setHostString:(NSString *)hostString {
    if (self.executing) {
        return;
    }
    
    _hostString = hostString;
}

#pragma mark - Main

- (void)main {
    // (1) Resolve domain
    
    // (2) Start sending packets
    int i = 0;
    do {
        [self.logger logLine:[NSString stringWithFormat:@"%@ %@", _hostString, @(i)]];
        usleep(1000 * 1000 * 1);
        i++;
    } while (!self.cancelled);
}

@end
