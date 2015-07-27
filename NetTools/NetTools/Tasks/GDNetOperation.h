//
//  GDNetOperation.h
//  NetTools
//
//  Created by Alex G on 27.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDLogger.h"

@interface GDNetOperation : NSOperation

@property (weak, readonly) GDLogger *logger;

- (instancetype)initWithLogger:(GDLogger *)logger;

@end
