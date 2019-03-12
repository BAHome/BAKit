//
//  BAKitVC_ScaleLabel.m
//  BAKit
//
//  Created by boai on 2017/7/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_ScaleLabel.h"


@interface BAKitVC_ScaleLabel ()

@property(nonatomic, strong) BAKit_ScaleLabel *label;
@property(nonatomic, strong) BAKit_ScaleLabel *label2;

@end

@implementation BAKitVC_ScaleLabel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.label.hidden = NO;
    self.label2.hidden = NO;

    BAKit_WeakSelf
    [[GCDQueue mainQueue] execute:^{
        
        BAKit_StrongSelf
        [self.label ba_startAnimation];
        
    } afterDelay:NSEC_PER_SEC * 1];
    
    [[GCDQueue mainQueue] execute:^{
        
        BAKit_StrongSelf
        [self.label2 ba_startAnimation];
        
    } afterDelay:NSEC_PER_SEC * 1];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.label.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, 50);
    self.label.center = self.view.center;
    self.label.centerY -= 150;
    
    self.label2.frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, 50);
    self.label2.center = self.view.center;
    self.label2.centerY -= 50;
    
}

#pragma mark - setter getter

- (BAKit_ScaleLabel *)label
{
    if (!_label)
    {
        _label = [BAKit_ScaleLabel new];
        _label.ba_text = @"欢迎来到博爱之家！";
        _label.ba_scaleStart = 0.1f;
        _label.ba_scaleEnd = 2.0f;
        _label.ba_colorBackLabelColor = BAKit_Color_Green_SpringGreen;
        _label.ba_colorLabelColor = BAKit_Color_Red;
        _label.ba_font = [UIFont AvenirWithFontSize:20.f];
        
        [self.view addSubview:_label];
    }
    return _label;
}

- (BAKit_ScaleLabel *)label2
{
    if (!_label2)
    {
        _label2 = [BAKit_ScaleLabel new];
        _label2.ba_text = @"BAHome";
        _label2.ba_scaleStart = 1.5f;
        _label2.ba_scaleEnd = 2.0f;
        _label2.ba_colorBackLabelColor = BAKit_Color_Red_OrangeRed;
        _label2.ba_colorLabelColor = BAKit_Color_Cyan_Aquamarine;
        _label2.ba_font = [UIFont AvenirLightWithFontSize:20.f];
        
        [self.view addSubview:_label2];
    }
    return _label2;
}

@end
