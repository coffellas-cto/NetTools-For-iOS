//
//  GDBaseToolViewController.m
//  NetTools
//
//  Created by Alex G on 26.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDBaseToolViewController.h"

#pragma mark - GDLogCell

@interface GDLogCell : UITableViewCell
@property (nonatomic, readonly) UITextView *logTextView;
@end

@implementation GDLogCell
@synthesize logTextView = _logTextView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _logTextView = [[UITextView alloc] initWithFrame:self.contentView.bounds];
        _logTextView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _logTextView.editable = NO;
        _logTextView.font = [UIFont fontWithName:@"Courier" size:14.0f];
        
        [self.contentView addSubview:_logTextView];
    }
    return self;
}

@end

#pragma mark - GDBaseToolViewController

@interface GDBaseToolViewController ()

@end

@implementation GDBaseToolViewController

#pragma mark - Public Methods

- (void)startWorking {
    if (_working) {
        return;
    }
    
    _working = !_working;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    [self didStartWorking];
}

#pragma mark - Protected Methods

- (void)didStartWorking {
    // To be overridden by children
}

- (void)didFinishWorking {
    // To be overridden by children
}

- (NSInteger)numberOfRowsInToolSection {
    // To be overridden by children
    return 0;
}

- (UITableViewCell *)cellForToolSectionRow:(NSInteger)row {
    // To be overridden by children
    return nil;
}

- (NSString *)titleForHeaderInToolSection {
    // To be overridden by children
    return @"";
}

- (CGFloat)heightForRowInToolSection:(NSInteger)row {
    // To be overridden by children
    return 0.0f;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [self numberOfRowsInToolSection];
            
        default:
            return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self cellForToolSectionRow:indexPath.row];
    }
    
    NSString *cellID = @"baseCellID";
    Class cellClass = [UITableViewCell class];
    if (indexPath.section == 3) {
        cellID = @"logCellID";
        cellClass = [GDLogCell class];
    }
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 1:
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            cell.textLabel.text = _working ? @"Stop" : @"Start";
            break;
        case 2:
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self heightForRowInToolSection:indexPath.row];
    }
    
    switch (indexPath.section) {
        case 2:
            return CGRectGetHeight([UIScreen mainScreen].bounds) / 2.0f;
            
        default:
            return 44.0f;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [self titleForHeaderInToolSection];
    }
    
    switch (section) {
        case 2:
            return @"Output";
            
        default:
            return @"";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return section == 3 ? kGDCopyrightText : @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        BOOL wasWorking = _working;
        _working = !_working;
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationFade)];
        if (wasWorking) {
            [self didFinishWorking];
        } else {
            [self didStartWorking];
        }
    }
}

#pragma mark - Gesture Recognizers

- (void)tapped:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
