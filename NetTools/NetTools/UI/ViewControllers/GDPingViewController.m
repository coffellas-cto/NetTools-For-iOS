//
//  GDPingViewController.m
//  NetTools
//
//  Created by Alex G on 26.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDPingViewController.h"
#import "GDTextFieldCell.h"
#import "GDPingOperation.h"

@interface GDPingViewController () <UITextFieldDelegate>

@end

@implementation GDPingViewController {
    dispatch_once_t _onceToken;
    UITextField *_textField;
    GDLogger *_logger;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self startWorking];
    return YES;
}

#pragma mark - Parent Methods

- (NSOperation *)generateOperation {
    return [[GDPingOperation alloc] initWithLogger:_logger];
}

- (BOOL)shouldStartWorking {
    if (_textField.text.length > 0) {
        return YES;
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Attention" message:@"IP or domain name cannot be empty" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    [_textField becomeFirstResponder];
    return NO;
}

- (void)startWorking {
    ((GDPingOperation *)_operation).hostString = _textField.text;
    [super startWorking];
}

- (void)didStartWorking {
    _textField.enabled = NO;
    _textField.alpha = 0.5f;
}

- (void)didFinishWorking {
    _textField.enabled = YES;
    _textField.alpha = 1.0f;
}

- (NSInteger)numberOfRowsInToolSection {
    return 1;
}

- (UITableViewCell *)cellForToolSectionRow:(NSInteger)row {
    NSString *cellID = @"pingCell";
    GDTextFieldCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[GDTextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textField.placeholder = @"IP or domain";
        cell.textField.returnKeyType = UIReturnKeyGo;
        cell.textField.delegate = self;
        _textField = cell.textField;
    }
    
    return cell;
}

- (NSString *)titleForHeaderInToolSection {
    return @"Ping";
}

- (CGFloat)heightForRowInToolSection:(NSInteger)row {
    return 44.0f;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Ping";
    _logger = [GDLogger new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_once(&_onceToken, ^{
        GDTextFieldCell *cell = (GDTextFieldCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [cell.textField becomeFirstResponder];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
