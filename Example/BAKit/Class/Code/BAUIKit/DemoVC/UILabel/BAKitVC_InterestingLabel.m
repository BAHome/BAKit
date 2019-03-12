//
//  BAKitVC_InterestingLabel.m
//  BAKit
//
//  Created by boai on 2017/8/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_InterestingLabel.h"
#import "BAKit_Color.h"
#import "BAKit_DefineFrame.h"
#import "BAKit_DefineFont.h"

#import "UIView+BAKit.h"

@interface BAKitVC_InterestingLabel ()

@property(nonatomic, strong) UILabel *label1;

@end

@implementation BAKitVC_InterestingLabel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = BAKit_Color_Blue_SkyBlue;
    
    self.label1.hidden = NO;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize label1_size = BAKit_LabelSizeWithTextAndWidthAndFont(_label1.text, BAKit_SCREEN_WIDTH - 20 * 2, _label1.font);
    self.label1.frame = CGRectMake(20, 100, label1_size.width, label1_size.height);
    [self.label1 sizeToFit];
}

#pragma mark - setter getter

- (UILabel *)label1
{
    if (!_label1)
    {
        _label1 = [UILabel new];
        _label1.numberOfLines = 0;
        _label1.text = @"我是一个有趣的 label！";
        _label1.textColor = BAKit_Color_White;
        _label1.font = BAKit_Font_boldSystemFontOfSize(25);

        [_label1 ba_viewSetRoundShadowWithCornerRadius:0 shadowColor:BAKit_Color_RGB(145, 23, 254) offset:CGSizeMake(0, 0) opacity:1.0 shadowRadius:4];

        
        [self.view addSubview:_label1];
    }
    return _label1;
}


@end
