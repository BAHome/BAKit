//
//  AppDelegate.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong, nullable) UIVisualEffectView *visualEffectView;

@end

