//
//  UIView+BAFind.m
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BAFind.h"

@implementation UIView (BAFind)

/**
 UIView：快速找到 subviews 包含的 的 某一类 view

 @param cla 需要查找的类
 @return UIView
 */
- (UIView *)ba_viewFindSubViewWithClass:(Class)cla
{
    for (UIView * subView in self.subviews)
    {
        if ([subView isKindOfClass:cla])
        {
            return subView;
        }
    }
    
    return nil;
}

/**
 UIView：快速找到 subviews 包含的 的 某一类 view

 @param cla 需要查找的类
 @return NSArray
 */
- (NSArray *)ba_viewFindAllSubViewsWithClass:(Class)cla
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (UIView * subView in self.subviews)
    {
        if ([subView isKindOfClass:cla])
        {
            [array addObject:subView];
        }
    }
    
    return array;
}

/**
 UIView：快速找到 superview 包含的 的 某一类 view
 
 @param cla 需要查找的类
 @return UIView
 */
- (UIView *)ba_viewFindSuperViewWithClass:(Class)cla;
{
    if (self == nil)
    {
        return nil;
    }
    else if (self.superview == nil)
    {
        return nil;
    }
    else if ([self.superview isKindOfClass:cla])
    {
        return self.superview;
    }
    else
    {
        return [self.superview ba_viewFindSuperViewWithClass:cla];
    }
}

/**
 UIView：快速找到 当前 view 的第一响应者

 @return UIView
 */
- (UIView *)ba_viewFindFirstResponder
{
    if (([self isKindOfClass:[UITextField class]] || [self isKindOfClass:[UITextView class]])
        && (self.isFirstResponder))
    {
        return self;
    }
    
    for (UIView *view in self.subviews)
    {
        UIView *fv = [view ba_viewFindFirstResponder];
        if (fv)
        {
            return fv;
        }
    }
    
    return nil;
}

/**
 UIView：快速获取当前view 所有的 Subviews

 @return NSArray
 */
- (NSArray *)ba_viewGetAllSubviews
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    
    [array addObjectsFromArray:self.subviews];
    
    for (UIView *view in self.subviews)
    {
        [array addObjectsFromArray:[view ba_viewGetAllSubviews]];
    }
    
    return array;
}

/**
 UIView：移除所有 subviews
 */
- (void)ba_viewRemoveAllSubviews
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/**
 UIView：获取当前 View 的 VC

 @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentViewController
{
    
    UIResponder *responder = self.nextResponder;
    do
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    while (responder);
    
    return nil;
}


@end
