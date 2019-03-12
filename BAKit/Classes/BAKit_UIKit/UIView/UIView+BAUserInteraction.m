//
//  UIView+BAUserInteraction.m
//  BAKit
//
//  Created by boai on 2017/7/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BAUserInteraction.h"

#import "BAKit_DefineCommon.h"


@interface UIView ()

@property (nonatomic, strong) NSNumber  *userInteractionNumbers;

@end

@implementation UIView (BAUserInteraction)

/**
 UIView：开启用户交互
 */
- (void)ba_viewEnabledUserInteraction
{
    [self accessUserInteractionNumbers];
    self.userInteractionNumbers = @(self.userInteractionNumbers.integerValue + 1);
    [self accessUserInteraction];
}

/**
 UIView：取消用户交互
 */
- (void)ba_viewDisableUserInteraction
{
    [self accessUserInteractionNumbers];
    self.userInteractionNumbers = @(self.userInteractionNumbers.integerValue - 1);
    [self accessUserInteraction];
}

- (void)accessUserInteractionNumbers
{
    if (self.userInteractionNumbers == nil)
    {
        self.userInteractionNumbers = @(0);
    }
}

- (void)accessUserInteraction
{
    if (self.userInteractionNumbers.integerValue > 0)
    {
        self.userInteractionEnabled = YES;
    }
    else
    {
        self.userInteractionEnabled = NO;
    }
}

#pragma mark - setter getter

- (void)setUserInteractionNumbers:(NSNumber *)userInteractionNumbers
{
    BAKit_Objc_setObj(@selector(userInteractionNumbers), userInteractionNumbers);
}

- (NSNumber *)userInteractionNumbers
{
    return BAKit_Objc_getObj;
}


@end
