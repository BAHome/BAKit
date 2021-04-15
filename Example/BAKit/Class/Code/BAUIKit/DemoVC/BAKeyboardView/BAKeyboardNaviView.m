//
//  BAKeyboardNaviView.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/5/25.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAKeyboardNaviView.h"

@interface BAKeyboardNaviView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BAKeyboardNaviView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.centerY.offset(0);
    }];
    
    [self initData];
}

- (void)initData {
    self.titleLabel.text = @"数字键盘";
    
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = UILabel.new;
        _titleLabel.textColor = [UIColor ba_colorWithHex:@"#0A5028" andAlpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    }
    return _titleLabel;
}

@end
