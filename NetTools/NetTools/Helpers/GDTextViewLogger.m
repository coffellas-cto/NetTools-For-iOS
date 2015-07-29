//
//  GDTextViewLogger.m
//  NetTools
//
//  Created by Alex G on 29.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDTextViewLogger.h"

@interface GDTextViewLogger () {
    __weak UITextView *_textView;
}

@end

@implementation GDTextViewLogger

- (void)logLine:(NSString *)logString {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _textView.text = [NSString stringWithFormat:@"[%@] %@\n%@", [self.dateFormatter stringFromDate:[NSDate date]], logString, _textView.text];
    }];
}

- (instancetype)initWithTextView:(UITextView *)textView
{
    self = [super init];
    if (self) {
        _textView = textView;
    }
    return self;
}

@end
