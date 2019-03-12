//
//  UIView+BANib.m
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BANib.h"

@implementation UIView (BANib)

/**
 UIView：快速加载 view 对应的 xib
 
 @param index index description
 @return UIView
 */
+ (instancetype)ba_viewLoadFromNibWithIndex:(NSInteger)index
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] [index];
}

/**
 UIView：快速加载 view 对应的 xib

 @param nibName nibName description
 @return UIView
 */
+ (instancetype)ba_viewLoadViewFromNibWithName:(NSString *)nibName
{
    return [self ba_viewLoadViewFromNibWithName:nibName owner:nil];
}

/**
 UIView：快速加载 view 对应的 xib

 @param nibName nibName description
 @param owner owner description
 @return UIView
 */
+ (instancetype)ba_viewLoadViewFromNibWithName:(NSString *)nibName
                                         owner:(id)owner
{
    return [self ba_viewLoadViewFromNibWithName:nibName owner:owner bundle:[NSBundle mainBundle]];
}

/**
 UIView：快速加载 view 对应的 xib

 @param nibName nibName description
 @param owner owner description
 @param bundle bundle description
 @return UIView
 */
+ (instancetype)ba_viewLoadViewFromNibWithName:(NSString *)nibName
                                         owner:(id)owner
                                        bundle:(NSBundle *)bundle
{
    UIView *result = nil;
    NSArray* elements = [bundle loadNibNamed:nibName owner:owner options:nil];
    for (id object in elements)
    {
        if ([object isKindOfClass:[self class]])
        {
            result = object;
            break;
        }
    }
    return result;
}


@end
