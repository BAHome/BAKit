//
//  AppDelegate+BALaunch.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/11.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate+BALaunch.h"
#import <YYImage/YYImage.h>

@implementation AppDelegate (BALaunch)

- (void)ba_setupLaunch
{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    UIViewController *rootVC = self.window.rootViewController;
    rootVC.automaticallyAdjustsScrollViewInsets = YES;
    
    launchView.frame = self.window.bounds;
    [rootVC.view addSubview:launchView];
    
    UIImageView *backgroundImageView = launchView.subviews[0];
    backgroundImageView.clipsToBounds = YES;
    
//    UIImageView *logoImageView = launchView.subviews[1];
//    UIImageView *loadingImageView = launchView.subviews[2];

    YYImage *image = [YYImage imageNamed:@"chick.gif"];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, BAKit_SCREEN_HEIGHT - 533, 300, 533);
    imageView.centerX = backgroundImageView.centerX;
    [launchView addSubview:imageView];
    
    [launchView layoutIfNeeded];
    [launchView.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.identifier isEqualToString:@"bottomAlign"]) {
            obj.active = NO;
            [NSLayoutConstraint constraintWithItem:launchView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:launchView attribute:NSLayoutAttributeTop multiplier:1 constant:64].active = YES;
            *stop = YES;
        }
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [launchView removeFromSuperview];
    });
}


@end
