//
//  GDBaseToolViewController.h
//  NetTools
//
//  Created by Alex G on 26.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GDTextViewLogger;

@interface GDBaseToolViewController : UITableViewController {
@protected
    NSOperation *_operation;
}

@property (nonatomic, readonly) GDTextViewLogger *logger;
@property (nonatomic, readonly, getter=isWorking) BOOL working;

- (void)startWorking;

- (void)didStartWorking;
- (void)didFinishWorking;
- (BOOL)shouldStartWorking;

- (NSOperation *)generateOperation;

- (NSInteger)numberOfRowsInToolSection;
- (UITableViewCell *)cellForToolSectionRow:(NSInteger)row;
- (NSString *)titleForHeaderInToolSection;
- (CGFloat)heightForRowInToolSection:(NSInteger)row;

@end
