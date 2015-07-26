//
//  GDTextFieldCell.m
//  NetTools
//
//  Created by Alex G on 26.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDTextFieldCell.h"

@implementation GDTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.indentationWidth, 0.0f, CGRectGetWidth(self.contentView.bounds) - self.indentationWidth * 2.0f, CGRectGetHeight(self.contentView.bounds))];
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        [self.contentView addSubview:_textField];
    }
    return self;
}

@end
