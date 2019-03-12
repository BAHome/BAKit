//
//  UINavigationBar+BAKit.h
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//  源码：https://github.com/ltebean/LTNavigationBar

#import <UIKit/UIKit.h>


@interface UINavigationBar (BAKit)

/*!
 *  设置背景颜色
 *
 *  @param backgroundColor backgroundColor
 */
- (void)ba_setBackgroundColor:(UIColor *)backgroundColor;

/*!
 *  设置alpha
 *
 *  @param alpha alpha
 */
- (void)ba_setElementsAlpha:(CGFloat)alpha;

/*!
 *  设置Y
 *
 *  @param translationY translationY
 */
- (void)ba_setTranslationY:(CGFloat)translationY;

/*!
 *  重置
 */
- (void)ba_reset;

@end
