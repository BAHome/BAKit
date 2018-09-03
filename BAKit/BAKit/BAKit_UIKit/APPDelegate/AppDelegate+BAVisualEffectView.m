//
//  AppDelegate+BAVisualEffectView.m
//  BAKit
//
//  Created by 孙博岩 on 2018/7/23.
//  Copyright © 2018 boai. All rights reserved.
//

#import "AppDelegate+BAVisualEffectView.h"

@implementation AppDelegate (BAVisualEffectView)

- (void)applicationWillResignActive:(UIApplication *)application {
    [self ba_addView];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self ba_addView];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self ba_removeView];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self ba_removeView];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)ba_addView
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    self.visualEffectView.alpha = 1;
    self.visualEffectView.frame = self.window.frame;
    self.visualEffectView.tag = 1111111;
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (window.windowLevel == UIWindowLevelNormal) {
            [window addSubview:self.visualEffectView];
        }
    }
}

- (void)ba_removeView
{
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (window.windowLevel == UIWindowLevelNormal) {
            UIView *view = [window viewWithTag:1111111];
            [view removeFromSuperview];
        }
    }
}

@end
