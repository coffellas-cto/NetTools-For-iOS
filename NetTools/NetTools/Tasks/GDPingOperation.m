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
    do {
        [self.logger logLine:_hostString];
        sleep(1);
    } while (!self.cancelled);
}

@end
