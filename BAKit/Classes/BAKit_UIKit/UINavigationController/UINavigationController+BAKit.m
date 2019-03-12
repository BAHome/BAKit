//
//  UINavigationController+BAKit.m
//  BAKit
//
//  Created by boai on 2017/9/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UINavigationController+BAKit.h"

@implementation UINavigationController (BAKit)

/**
 UINavigationController：根据类名查找当前类中包含的 viewControllers 中的指定 viewController

 @param className 需要查找的类名
 @return UIViewController
 */
- (UIViewController *)ba_navigationControllerFindViewControllerClassName:(Class)className
{
    for (UIViewController *viewController in self.viewControllers)
    {
        if ([viewController isKindOfClass:className])
        {
            return viewController;
        }
    }
    return nil;
}

/**
 UINavigationController：判断当前类是否只有一个 RootViewController

 @return YES / NO
 */
- (BOOL)ba_navigationControllerIsOnlyContainRootViewController
{
    if (self.viewControllers && self.viewControllers.count == 1)
    {
        return YES;
    }
    return NO;
}

/**
 UINavigationController：获取当前类的 RootViewController

 @return UIViewController
 */
- (UIViewController *)ba_navigationControllerGetRootViewController
{
    if (self.viewControllers && [self.viewControllers count] >0)
    {
        return [self.viewControllers firstObject];
    }
    return nil;
}

/**
 UINavigationController：返回到指定的 ViewController

 @param ClassName 类
 @param animated animated description
 */
- (void)ba_navigationControllerPopToViewControllerClassName:(Class)ClassName
                                                   animated:(BOOL)animated
{
    id vc = [self ba_navigationControllerFindViewControllerClassName:ClassName];
    
    if(vc != nil && [vc isKindOfClass:[UIViewController class]])
    {
        [self popToViewController:vc animated:animated];
    }
}



@end
