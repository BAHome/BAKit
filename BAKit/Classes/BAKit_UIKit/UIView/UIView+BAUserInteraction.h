//
//  UIView+BAUserInteraction.h
//  BAKit
//
//  Created by boai on 2017/7/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BAUserInteraction)

/**
 UIView：开启用户交互
 */
- (void)ba_viewEnabledUserInteraction;

/**
 UIView：取消用户交互
 */
- (void)ba_viewDisableUserInteraction;

@end
