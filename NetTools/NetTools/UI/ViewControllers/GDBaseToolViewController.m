//
//  GDBaseToolViewController.m
//  NetTools
//
//  Created by Alex G on 26.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDBaseToolViewController.h"
#import "GDTextViewLogger.h"

const NSInteger logCellIndex = 2;

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
        _logTextView.contentInset = UIEdgeInsetsZero;
        
        [self.contentView addSubview:_logTextView];
    }
    return self;
}

@end

#pragma mark - GDBaseToolViewController

@interface GDBaseToolViewController ()

@property (nonatomic, readonly) UITextView *logTextView;

@end

@implementation GDBaseToolViewController

#pragma mark - Accessors

@synthesize logger = _logger;

- (GDTextViewLogger *)logger {
    if (!_logger) {
        _logger = [[GDTextViewLogger alloc] initWithTextView:self.logTextView];
    }
    
    return _logger;
}

- (UITextView *)logTextView {
    GDLogCell *cell = (GDLogCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:logCellIndex]];
    return cell.logTextView;
}

#pragma mark - Public Methods

- (void)startWorking {
    if (_working) {
        return;
    }
    
    NSOperationQueue *newQueue = [[NSOperationQueue alloc] init];
    newQueue.name = NSStringFromClass([_operation class]);
    [newQueue addOperation:_operation];
    
    _working = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    [self didStartWorking];
}

- (void)stopWorking {
    if (!_working) {
        return;
    }
    
    [_operation cancel];
    
    _working = NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    [self didFinishWorking];
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

- (BOOL)shouldStartWorking {
    // To be overridden by children
    return YES;
}

- (NSOperation *)generateOperation {
    // To be overridden by children
    [NSException raise:NSInternalInconsistencyException format:@"%s must be overridden by children", __PRETTY_FUNCTION__];
    return nil;
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
    if (indexPath.section == logCellIndex) {
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
        if (_working) {
            [self stopWorking];
        } else if ([self shouldStartWorking]) {
            _operation = [self generateOperation];
            [self startWorking];
        } else {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (void)dealloc {
    [_operation cancel];
}

@end
