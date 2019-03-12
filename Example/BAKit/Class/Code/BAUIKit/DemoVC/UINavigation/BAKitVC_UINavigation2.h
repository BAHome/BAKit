//
//  BAKitVC_UINavigation2.h
//  BAKit
//
//  Created by boai on 2017/7/4.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABaseListViewController.h"


typedef NS_ENUM(NSInteger, BAKit_NavigationBarStyle) {
    BAKit_NavigationBarStyleOrigin = 0,
    BAKit_NavigationBarStyleLight,
    BAKit_NavigationBarStyleDark
};

@interface BAKitVC_UINavigation2 : BABaseListViewController

@property(nonatomic, assign) BAKit_NavigationBarStyle previousBarStyle;

@end
