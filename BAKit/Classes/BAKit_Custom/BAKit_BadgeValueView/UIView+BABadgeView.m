//
//  UIView+BABadgeView.m
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BABadgeView.h"
#import "BABadgeLabel.h"
#import "UIView+BAFrame.h"
#import "BAKit_DefineCommon.h"

@interface UIView ()

@property (nonatomic, strong) BABadgeLabel *badgeLabel;

@end

@implementation UIView (BABadgeView)

- (void)ba_addBadgeWithText:(NSString *)text
{
    [self lazyLoadBadgeLabel];
    [self ba_showBadge];
    self.badgeLabel.text = text;
    self.badgeLabel.hidden = !text.length;
}

- (void)ba_addBadgeWithNumber:(NSInteger)number
{
    if (number <= 0)
    {
        [self ba_addBadgeWithText:@"0"];
        [self ba_hiddenBadge];
        return;
    }
    [self ba_addBadgeWithText:[NSString stringWithFormat:@"%ld",number]];
}

- (void)ba_addDotWithColor:(UIColor *)color
{
    [self ba_addBadgeWithText:nil];
    [self ba_setBadgeHeightPoints:8];
    if (color)
    {
        self.badgeLabel.backgroundColor = color;
    }
}

- (void)ba_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    [self lazyLoadBadgeLabel];
    
    /**
     self.badgeLabel.center = CGPointMake(self.width+x, y);
     
     如果通过 badge 的 center 来调整其在父视图的位置, 在给 badge 赋值不同长度的内容时
     会导致 badge 会以中心点向两边调整其自身宽度,如果badge过长会遮挡部分父视图, 所以
     正确的方式是以 badge 的x坐标为起点,其宽度向x轴正方向增加/x轴负方向减少
     */
    self.badgeLabel.x = (self.width - self.badgeLabel.height * 0.5)/*badge的x坐标*/ + x;
    self.badgeLabel.y = -self.badgeLabel.height * 0.5/*badge的y坐标*/ + y;
}

- (void)ba_setBadgeLabelAttributes:(void (^)(BABadgeLabel *))badgeLabel
{
    [self lazyLoadBadgeLabel];
    badgeLabel ? badgeLabel(self.badgeLabel) : nil;
}

- (void)ba_setBadgeHeightPoints:(CGFloat)points
{
    CGFloat scale = points/self.badgeLabel.height;
    self.badgeLabel.transform = CGAffineTransformScale(self.badgeLabel.transform, scale, scale);
}

- (void)ba_showBadge
{
    self.badgeLabel.hidden = NO;
}

- (void)ba_hiddenBadge
{
    self.badgeLabel.hidden = YES;
}

- (void)ba_increase
{
    [self ba_increaseBy:1];
}

- (void)ba_increaseBy:(NSInteger)number
{
    NSInteger result = self.badgeLabel.text.integerValue + number;
    if (result > 0)
    {
        [self ba_showBadge];
    }
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)ba_decrease
{
    [self ba_decreaseBy:1];
}

- (void)ba_decreaseBy:(NSInteger)number
{
    NSInteger result = self.badgeLabel.text.integerValue - number;
    if (result <= 0)
    {
        [self ba_hiddenBadge];
        self.badgeLabel.text = @"0";
        return;
    }
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld",result];
}

- (void)lazyLoadBadgeLabel
{
    if (!self.badgeLabel)
    {
        self.badgeLabel = [BABadgeLabel ba_badgeLabelDefaultBadgeLabel];
        self.badgeLabel.center = CGPointMake(self.width, 0);
        [self addSubview:self.badgeLabel];
        [self bringSubviewToFront:self.badgeLabel];
    }
}

#pragma mark - setter/getter
- (BABadgeLabel *)badgeLabel
{
    return BAKit_Objc_getObj;
}

- (void)setBadgeLabel:(BABadgeLabel *)badgeLabel
{
    BAKit_Objc_setObj(@selector(badgeLabel), badgeLabel);
}

@end
