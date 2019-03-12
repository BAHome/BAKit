//
//  UINavigationController+BAKit.h
//  BAKit
//
//  Created by boai on 2017/9/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (BAKit)

/**
 UINavigationController：根据类名查找当前类中包含的 viewControllers 中的指定 viewController
 
 @param className 需要查找的类名
 @return UIViewController
 */
- (UIViewController *)ba_navigationControllerFindViewControllerClassName:(Class)className;

/**
 UINavigationController：判断当前类是否只有一个 RootViewController
 
 @return YES / NO
 */
- (BOOL)ba_navigationControllerIsOnlyContainRootViewController;

/**
 UINavigationController：获取当前类的 RootViewController
 
 @return UIViewController
 */
- (UIViewController *)ba_navigationControllerGetRootViewController;

/**
 UINavigationController：返回到指定的 ViewController
 
 @param ClassName 类
 @param animated animated description
 */
- (void)ba_navigationControllerPopToViewControllerClassName:(Class)ClassName
                                                   animated:(BOOL)animated;




@end
