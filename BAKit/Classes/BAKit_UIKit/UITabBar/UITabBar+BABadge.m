//
//  UITabBar+BABadge.m
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITabBar+BABadge.h"

#import "BAKit_DefineFont.h"
#import "BAKit_Color.h"

#import <objc/runtime.h>

static NSString * const kTabBarItemWidthKey = @"kTabBarItemWidthKey";

static NSString * const kBadgeViewInitedKey = @"kBadgeViewInited";
static NSString * const kBadgeDotViewsKey = @"kBadgeDotViewsKey";
static NSString * const kBadgeNumberViewsKey = @"kBadgeNumberViewsKey";
static NSString * const kBadgeNewViewsKey = @"kBadgeNewViewsKey";
static NSString * const kBadgeTopKey = @"kBadgeTopKey";


@implementation UITabBar (BABadge)

/**
 UITabBar：设置 TabItem 的宽度，用于调整 badge 的位置
 
 @param width TabBarItem 的 Width
 */
- (void)ba_tabBarSetTabBarItemWidth:(CGFloat)width
{
    [self setValue:@(width) forUndefinedKey:kTabBarItemWidthKey];
}

/**
 UITabBar：设置 badge 的 top
 
 @param top 顶部距离
 */
- (void)ba_tabBarSetBadgeTop:(CGFloat)top
{
    [self setValue:@(top) forUndefinedKey:kBadgeTopKey];
}

/**
 UITabBar：设置 badge样、数字
 
 @param type UITabBar：badge 样式
 @param badgeValue 数字
 @param index 下标
 */
- (void)ba_tabBarSetBadgeType:(BAKit_TabBarBadgeType)type
                   badgeValue:(NSInteger)badgeValue
                        index:(NSInteger)index
{
    if (![[self valueForKey:kBadgeViewInitedKey] boolValue])
    {
        [self setValue:@(YES) forKey:kBadgeViewInitedKey];
        [self ba_addBadgeView];
    }
    
    NSMutableArray *badgeDotViewArray = [self valueForKey:kBadgeDotViewsKey];
    NSMutableArray *badgeNumberViewArray = [self valueForKey:kBadgeNumberViewsKey];
    NSMutableArray *badgeNewViewArray = [self valueForKey:kBadgeNewViewsKey];

    [badgeDotViewArray[index] setHidden:YES];
    [badgeNumberViewArray[index] setHidden:YES];
    [badgeNewViewArray[index] setHidden:YES];

    if (type == BAKit_TabBarBadgeTypeRedDot)
    {
        [badgeDotViewArray[index] setHidden:NO];
    }
    else if (type == BAKit_TabBarBadgeTypeNew)
    {
        [badgeNewViewArray[index] setHidden:NO];
        UILabel *label = badgeNewViewArray[index];
        label.text = @"new";
        label.font = BAKit_Font_systemFontOfSize_12;
        label.textColor = BAKit_Color_White;
        [label sizeToFit];
    }
    else if (type == BAKit_TabBarBadgeTypeNumber)
    {
        [badgeNumberViewArray[index] setHidden:NO];
        UILabel *label = badgeNumberViewArray[index];
        
        [self ba_adjustBadgeNumberViewWithLabel:label number:badgeValue];
    }
}

- (void)ba_tabBarBadgeViewClearWithIndndex:(NSInteger)index
{
    NSMutableArray *badgeDotViewArray = [self valueForKey:kBadgeDotViewsKey];
    NSMutableArray *badgeNumberViewArray = [self valueForKey:kBadgeNumberViewsKey];
    NSMutableArray *badgeNewViewArray = [self valueForKey:kBadgeNewViewsKey];
    
    [badgeDotViewArray[index] setHidden:YES];
    [badgeNumberViewArray[index] setHidden:YES];
    [badgeNewViewArray[index] setHidden:YES];
}

- (void)ba_addBadgeView
{
    id idItemWidth = [self valueForKey:kTabBarItemWidthKey];
    id idBadgeTop = [self valueForKey:kBadgeTopKey];

    CGFloat tabbarItemWidth = idItemWidth ? [idItemWidth floatValue] : 32;
    CGFloat badgeTop = idBadgeTop ? [idBadgeTop floatValue] : 11;

    NSInteger itemCount = self.items.count;
    CGFloat itemWidth = self.bounds.size.width / itemCount;
    
    // dot views
    NSMutableArray *badgeDotViews = [NSMutableArray new];
    for(int i = 0;i < itemCount;i ++)
    {
        UIView *redDot = [UIView new];
        redDot.bounds = CGRectMake(0, 0, 10, 10);
        redDot.center = CGPointMake(itemWidth * (i + 0.5) + tabbarItemWidth / 2, badgeTop);
        redDot.layer.cornerRadius = redDot.bounds.size.width / 2;
        redDot.clipsToBounds = YES;
        redDot.backgroundColor = [UIColor redColor];
        redDot.hidden = YES;
        [self addSubview:redDot];
        [badgeDotViews addObject:redDot];
    }
    [self setValue:badgeDotViews forKey:kBadgeDotViewsKey];
    
    // number views
    NSMutableArray *badgeNumberViews = [NSMutableArray new];
    for(int i = 0;i < itemCount;i ++){
        UILabel *redNum = [UILabel new];
        redNum.layer.anchorPoint = CGPointMake(0, 0.5);
        redNum.bounds = CGRectMake(0, 0, 20, 14);
        redNum.center = CGPointMake(itemWidth * (i + 0.5) + tabbarItemWidth / 2 - 10, badgeTop);
        redNum.layer.cornerRadius = redNum.bounds.size.height/2;
        redNum.clipsToBounds = YES;
        redNum.backgroundColor = [UIColor redColor];
        redNum.hidden = YES;
        
        redNum.textAlignment = NSTextAlignmentCenter;
        redNum.font = [UIFont systemFontOfSize:12];
        redNum.textColor = [UIColor whiteColor];
        
        [self addSubview:redNum];
        [badgeNumberViews addObject:redNum];
    }
    [self setValue:badgeNumberViews forKey:kBadgeNumberViewsKey];
}

- (void)ba_adjustBadgeNumberViewWithLabel:(UILabel *)label
                                   number:(NSInteger)number
{
    [label setText:(number > 99 ? @"..." : @(number).stringValue)];
    if(number < 10){
        label.bounds = CGRectMake(0, 0, 14, 14);
    }else if(number < 99){
        label.bounds = CGRectMake(0, 0, 20, 14);
    }else{
        label.bounds = CGRectMake(0, 0, 20, 14);
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, OBJC_ASSOCIATION_COPY);
}

@end
