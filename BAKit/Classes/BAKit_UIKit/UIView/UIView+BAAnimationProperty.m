//
//  UIView+BAAnimationProperty.m
//  BAKit
//
//  Created by boai on 2017/7/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BAAnimationProperty.h"

#import "BAKit_DefineCommon.h"

@implementation UIView (BAAnimationProperty)

#pragma mark - setter getter

- (void)setBa_scale:(CGFloat)ba_scale
{
    BAKit_Objc_setObj(@selector(ba_scale), @(ba_scale));
    self.transform = CGAffineTransformMakeScale(ba_scale, ba_scale);
}

- (CGFloat)ba_scale
{
    return [BAKit_Objc_getObj floatValue];
}

- (void)setBa_angle:(CGFloat)ba_angle
{
    BAKit_Objc_setObj(@selector(ba_angle), @(ba_angle));
    self.transform = CGAffineTransformMakeRotation(ba_angle);
}

- (CGFloat)ba_angle
{
    return [BAKit_Objc_getObj floatValue];
}

@end
