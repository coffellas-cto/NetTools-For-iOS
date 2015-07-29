//
//  GDLogger.h
//  NetTools
//
//  Created by Alex G on 27.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDLogger : NSObject

@property (nonatomic, readonly) NSDateFormatter *dateFormatter;

- (void)logLine:(NSString *)logString;

@end
