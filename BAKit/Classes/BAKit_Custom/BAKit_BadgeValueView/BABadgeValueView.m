//
//  BABadgeValueView.m
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABadgeValueView.h"
#import "UIView+BAFrame.h"

@interface BABadgeValueView ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation BABadgeValueView

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.ba_badgeViewSensitiveWidth     = 10;
    self.ba_badgeViewFixedHeight        = 20;
    self.ba_badgeViewSensitiveTextWidth = 4;
    self.ba_badgeViewPosition           = BAKit_BadgeViewPositionTopRight;
    self.ba_badgeViewFont               = [UIFont systemFontOfSize:12.f];
    self.ba_badgeViewTextColor          = [UIColor whiteColor];
    self.ba_badgeViewBackgroundColor    = [UIColor redColor];
}

- (void)ba_badgeViewMakeEffect
{
    // 标签
    self.label               = [[UILabel alloc] init];
    self.label.textColor     = self.ba_badgeViewTextColor;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font          = self.ba_badgeViewFont;
    [self addSubview:self.label];
    
    // 背景色
    self.backgroundColor     = self.ba_badgeViewBackgroundColor;
    self.width               = self.ba_badgeViewFixedHeight;
    self.height              = self.ba_badgeViewFixedHeight;
    self.layer.cornerRadius  = self.ba_badgeViewFixedHeight / 2.f;
    self.layer.masksToBounds = YES;
    
    [_ba_badgeViewContentView addSubview:self];
}

- (void)ba_badgeViewSetBadgeValue:(NSString *)badgeValue animated:(BOOL)animated
{
    _ba_badgeViewBadgeValue = badgeValue;
    
    // 是否执行动画
    if (animated)
    {
        [UIView animateWithDuration:0.15f animations:^{
            self.alpha = badgeValue.length == 0 ? 0 : 1;
        }];
    }
    else
    {
        self.alpha = badgeValue.length == 0 ? 0 : 1;
    }
    
    // 如果值为空，则不执行后续操作
    if (badgeValue.length <= 0)
    {
        return;
    }
    
    // 设置文本
    self.label.text = badgeValue;
    [self.label sizeToFit];
    
    // 更新尺寸
    if (self.label.width + self.ba_badgeViewSensitiveTextWidth > self.width)
    {
        self.width += self.ba_badgeViewSensitiveWidth;
    }
    else
    {
        self.width = self.ba_badgeViewFixedHeight;
    }
    
    // 更新文本尺寸
    self.label.center = self.middlePoint;
    
    // 根据位置更新尺寸
    CGFloat offset = self.ba_badgeViewFixedHeight / 2.f;
    self.ba_badgeViewPosition == BAKit_BadgeViewPositionCenterLeft  ? self.left = -offset, self.centerY = self.ba_badgeViewContentView.middleY : 0;
    self.ba_badgeViewPosition == BAKit_BadgeViewPositionCenterRight ? self.left = self.ba_badgeViewContentView.width - offset, self.centerY = self.ba_badgeViewContentView.middleY : 0;
    
    self.ba_badgeViewPosition == BAKit_BadgeViewPositionTopLeft     ? self.left = -offset, self.y    = -offset : 0;
    self.ba_badgeViewPosition == BAKit_BadgeViewPositionTopRight    ? self.top  = -offset, self.left = self.ba_badgeViewContentView.width - offset : 0;
    
    self.ba_badgeViewPosition == BAKit_BadgeViewPositionBottomLeft  ? self.left = -offset, self.top = self.ba_badgeViewContentView.height - offset : 0;
    self.ba_badgeViewPosition == BAKit_BadgeViewPositionBottomRight ? self.left = self.ba_badgeViewContentView.width - offset, self.top = self.ba_badgeViewContentView.height - offset : 0;
}

@end
