//
//  GDBaseToolViewController.h
//  NetTools
//
//  Created by Alex G on 26.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDBaseToolViewController : UITableViewController

- (void)startWorking;

@property (nonatomic, readonly, getter=isWorking) BOOL working;

- (void)didStartWorking;
- (void)didFinishWorking;

- (NSInteger)numberOfRowsInToolSection;
- (UITableViewCell *)cellForToolSectionRow:(NSInteger)row;
- (NSString *)titleForHeaderInToolSection;
- (CGFloat)heightForRowInToolSection:(NSInteger)row;

@end
