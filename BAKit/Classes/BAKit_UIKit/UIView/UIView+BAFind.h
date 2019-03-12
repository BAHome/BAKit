//
//  UIView+BAFind.h
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BAFind)

/**
 UIView：快速找到 subviews 包含的 的 某一类 view
 
 @param cla 需要查找的类
 @return UIView
 */
- (UIView *)ba_viewFindSubViewWithClass:(Class)cla;

/**
 UIView：快速找到 subviews 包含的 的 某一类 view
 
 @param cla 需要查找的类
 @return NSArray
 */
- (NSArray *)ba_viewFindAllSubViewsWithClass:(Class)cla;

/**
 UIView：快速找到 superview 包含的 的 某一类 view
 
 @param cla 需要查找的类
 @return UIView
 */
- (UIView *)ba_viewFindSuperViewWithClass:(Class)cla;;

/**
 UIView：快速找到 当前 view 的第一响应者
 
 @return UIView
 */
- (UIView *)ba_viewFindFirstResponder;


/**
 UIView：快速获取当前view 所有的 Subviews
 
 @return NSArray
 */
- (NSArray *)ba_viewGetAllSubviews;

/**
 UIView：移除所有 subviews
 */
- (void)ba_viewRemoveAllSubviews;

/**
 UIView：获取当前 View 的 VC
 
 @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentViewController;

@end
