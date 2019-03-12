//
//  UITabBarItem+BABadgeView.m
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITabBarItem+BABadgeView.h"
#import "UIView+BABadgeView.h"

@implementation UITabBarItem (BABadgeView)

- (void)ba_addBadgeWithText:(NSString *)text
{
    [[self bottomView] ba_addBadgeWithText:text];
    [[self bottomView] ba_moveBadgeWithX:4 Y:3]; // 默认为系统badge所在的位置
}

- (void)ba_addBadgeWithNumber:(NSInteger)number
{
    [[self bottomView] ba_addBadgeWithNumber:number];
    [[self bottomView] ba_moveBadgeWithX:4 Y:3];
}

- (void)ba_addDotWithColor:(UIColor *)color
{
    [[self bottomView] ba_addDotWithColor:color];
}

- (void)ba_setBadgeHeightPoints:(CGFloat)points
{
    [[self bottomView] ba_setBadgeHeightPoints:points];
}

- (void)ba_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y
{
    [[self bottomView] ba_moveBadgeWithX:x Y:y];
}

- (void)ba_setBadgeLabelAttributes:(void(^)(BABadgeLabel *badgeLabel))attributes
{
    [[self bottomView] ba_setBadgeLabelAttributes:attributes];
}

- (void)ba_showBadge
{
    [[self bottomView] ba_showBadge];
}

- (void)ba_hiddenBadge
{
    [[self bottomView] ba_hiddenBadge];
}

- (void)ba_increase
{
    [[self bottomView] ba_increase];
}

- (void)ba_increaseBy:(NSInteger)number
{
    [[self bottomView] ba_increaseBy:number];
}

- (void)ba_decrease
{
    [[self bottomView] ba_decrease];
}

- (void)ba_decreaseBy:(NSInteger)number
{
    [[self bottomView] ba_decreaseBy:number];
}

#pragma mark - 获取Badge的父视图

- (UIView *)bottomView
{
    // 通过Xcode视图调试工具找到UITabBarItem原生Badge所在父视图
    UIView *tabBarButton = [self valueForKey:@"_view"];
    for (UIView *subView in tabBarButton.subviews)
    {
        if ([NSStringFromClass(subView.superclass) isEqualToString:@"UIImageView"])
        {
            return subView;
        }
    }
    return tabBarButton;
}

@end
