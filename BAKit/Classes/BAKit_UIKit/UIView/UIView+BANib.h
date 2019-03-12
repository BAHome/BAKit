//
//  UIView+BANib.h
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BANib)

/**
 UIView：快速加载 view 对应的 xib
 
 @param index index description
 @return UIView
 */
+ (instancetype)ba_viewLoadFromNibWithIndex:(NSInteger)index;

/**
 UIView：快速加载 view 对应的 xib
 
 @param nibName nibName description
 @return UIView
 */
+ (instancetype)ba_viewLoadViewFromNibWithName:(NSString *)nibName;

/**
 UIView：快速加载 view 对应的 xib
 
 @param nibName nibName description
 @param owner owner description
 @return UIView
 */
+ (instancetype)ba_viewLoadViewFromNibWithName:(NSString *)nibName
                                         owner:(id)owner;

/**
 UIView：快速加载 view 对应的 xib
 
 @param nibName nibName description
 @param owner owner description
 @param bundle bundle description
 @return UIView
 */
+ (instancetype)ba_viewLoadViewFromNibWithName:(NSString *)nibName
                                         owner:(id)owner
                                        bundle:(NSBundle *)bundle;

@end
