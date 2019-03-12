//
//  UIView+BAAnimationProperty.h
//  BAKit
//
//  Created by boai on 2017/7/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BAAnimationProperty)

/**
 CGAffineTransformMakeScale 缩放的比率
 */
@property (nonatomic) CGFloat  ba_scale;

/**
 CGAffineTransformMakeRotation 旋转的角度
 */
@property (nonatomic) CGFloat  ba_angle;

@end
