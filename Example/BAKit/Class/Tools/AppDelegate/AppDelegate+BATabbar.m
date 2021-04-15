//
//  AppDelegate+BATabbar.m
//  BAKit_Example
//
//  Created by boai on 2020/3/5.
//  Copyright © 2020 boai. All rights reserved.
//

#import "AppDelegate+BATabbar.h"
#import "BAUIKitViewController.h"
#import "BAFoundationViewController.h"
#import "BAOtherViewController.h"


@implementation AppDelegate (BATabbar)

- (void)initTabBarVC {
    // 自定义配置：tabbar 的背景颜色 和 item 颜色
    [BAKit_Helper ba_helperSetTabbarSelectedTintColor:BAKit_Color_Red
                                      normalTintColor:BAKit_Color_White
                                      backgroundImage:nil
                                      backgroundColor:BAKit_Color_Black];
    // 自定义配置：状态栏颜色
    [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:NO];
    
    // 自定义配置：navi 颜色
    //    [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_White tintColor:BAKit_Color_Black font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_Black isNeedBackTitle:NO isNeedBottomLine:YES customShadowImage:BAKit_ImageName(@"navi_shadow") navigationController:self.navigationController];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    
    BAUIKitViewController *uikitVC = [BAUIKitViewController new];
    BANavigationController *uikitNavi = [[BANavigationController alloc] initWithRootViewController:uikitVC];
    uikitNavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"BAUIKit" image:BAKit_ImageName(@"tabbar_mainframe") selectedImage:BAKit_ImageName(@"tabbar_mainframeHL") selectedTitleColor:nil tag:0];
    uikitVC.title = uikitNavi.tabBarItem.title;
    
    BAFoundationViewController *foundationVC = [BAFoundationViewController new];
    BANavigationController *foundationNavi = [[BANavigationController alloc] initWithRootViewController:foundationVC];
    foundationNavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"BAFoundation" image:BAKit_ImageName(@"tabbar_contacts") selectedImage:BAKit_ImageName(@"tabbar_contactsHL") selectedTitleColor:nil tag:1];
    foundationVC.title = foundationNavi.tabBarItem.title;
    
    BAOtherViewController *otherVC = [BAOtherViewController new];
    BANavigationController *otherNavi = [[BANavigationController alloc] initWithRootViewController:otherVC];
    otherNavi.tabBarItem = [UITabBarItem ba_tabBarItemWithTitle:@"Other" image:BAKit_ImageName(@"tabbar_discover") selectedImage:BAKit_ImageName(@"tabbar_discoverHL") selectedTitleColor:nil tag:2];
    otherVC.title = otherNavi.tabBarItem.title;
    
    /**
     tabBarVC 获取不到tabBarItem实例,demo为了演示效果做了0.1s的延时操作,
     在实际开发中,badge的显示是在网络请求成功/推送之后,所以不用担心获取不到tabBarItem添加不了badge
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 给UITabBarItem添加badge
        [uikitNavi.tabBarItem ba_addBadgeWithText:@"new"];
        [foundationNavi.tabBarItem ba_addBadgeWithNumber:999];
        [otherNavi.tabBarItem ba_addDotWithColor:BAKit_Color_Red];
    });
    
    self.tabBarController.viewControllers = @[uikitNavi, foundationNavi, otherNavi];
    self.tabBarController.selectedIndex = 0;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [viewController.tabBarItem ba_hiddenBadge];
}

@end
