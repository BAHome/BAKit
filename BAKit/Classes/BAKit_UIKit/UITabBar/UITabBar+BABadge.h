//
//  UITabBar+BABadge.h
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 UITabBar：badge 样式

 - BAKit_TabBarBadgeTypeRedDot: 小红点
 - BAKit_TabBarBadgeTypeNew: badge with a fixed text "new"
 - BAKit_TabBarBadgeTypeNumber: badge with number
 */
typedef NS_ENUM(NSUInteger, BAKit_TabBarBadgeType){
    BAKit_TabBarBadgeTypeRedDot = 0,
    BAKit_TabBarBadgeTypeNew,
    BAKit_TabBarBadgeTypeNumber
};

@interface UITabBar (BABadge)

/**
 UITabBar：设置 TabItem 的宽度，用于调整 badge 的位置

 @param width TabBarItem 的 Width
 */
- (void)ba_tabBarSetTabBarItemWidth:(CGFloat)width;

/**
 UITabBar：设置 badge 的 top

 @param top 顶部距离
 */
- (void)ba_tabBarSetBadgeTop:(CGFloat)top;

/**
 UITabBar：设置 badge样、数字

 @param type UITabBar：badge 样式
 @param badgeValue 数字
 @param index 下标
 */
- (void)ba_tabBarSetBadgeType:(BAKit_TabBarBadgeType)type
                   badgeValue:(NSInteger)badgeValue
                        index:(NSInteger)index;

- (void)ba_tabBarBadgeViewClearWithIndndex:(NSInteger)index;

@end
