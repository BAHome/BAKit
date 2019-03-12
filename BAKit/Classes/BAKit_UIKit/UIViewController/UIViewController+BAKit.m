//
//  UIViewController+BAKit.m
//  BAKit
//
//  Created by boai on 2017/7/1.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIViewController+BAKit.h"

@implementation UIViewController (BAKit)


- (UIViewController *)ba_visibleViewControllerIfExist
{
    
    if (self.presentedViewController)
    {
        return [self.presentedViewController ba_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UINavigationController class]])
    {
        return [((UINavigationController *)self).visibleViewController ba_visibleViewControllerIfExist];
    }
    
    if ([self isKindOfClass:[UITabBarController class]])
    {
        return [((UITabBarController *)self).selectedViewController ba_visibleViewControllerIfExist];
    }
    
    if ([self isViewLoaded] && self.view.window)
    {
        return self;
    }
    else
    {
        NSLog(@"ba_visibleViewControllerIfExist:，找不到可见的viewController。self = %@, self.view.window = %@", self, self.view.window);
        return nil;
    }
}


@end
