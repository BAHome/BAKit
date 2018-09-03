//
//  AppDelegate.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "AppDelegate.h"

#import "AppDelegate+BALaunch.h"
//#import "AppDelegate+BAVisualEffectView.h"

#import "BAUIKitViewController.h"
#import "BAFoundationViewController.h"
#import "BAOtherViewController.h"

#import "BAKit_Color.h"

#import "BANavigationController.h"
#import "BAKit_DefineCommon.h"

#import "UITabBarItem+BAKit.h"
#import "UITabBarItem+BABadgeView.h"

#import "BAOOMDataManager.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [self ba_setupTabBarVC];
    [self ba_setupLaunch];
#ifdef DEBUG
    [self ba_setupOOMDetector];
#else
#endif
    
//    [self ba_setupVisualEffectView];
//    self.isShowVisualEffectViewWhenInBGWindow = YES;
    
    [self test];
    return YES;
}

- (void)test
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"\n\nUIWindowLevelNormal = %f  \n\nUIWindowLevelAlert = %f  \n\nUIWindowLevelStatusBar = %f  \n\nappDelegate.window.windowLevel = %f",UIWindowLevelNormal,UIWindowLevelAlert,UIWindowLevelStatusBar,appDelegate.window.windowLevel);
    
    /*
     UIWindowLevelNormal = 0.000000
     
     UIWindowLevelAlert = 2000.000000
     
     UIWindowLevelStatusBar = 1000.000000
     */
}

- (void)ba_setupTabBarVC
{
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


- (void)ba_setupOOMDetector
{
    OOMDetector *detector = [OOMDetector getInstance];
    [detector setupWithDefaultConfig];
    
    /*********************下面的几项可以根据自己的实际需要选择性设置******************/
    
    // 设置捕获堆栈数据、内存log代理，在出现单次大块内存分配、检查到内存泄漏且时、调用uploadAllStack方法时会触发此回调
    [detector setFileDataDelegate:[BAOOMDataManager getInstance]];
    
    // 设置app内存触顶监控数据代理，在调用startMaxMemoryStatistic:开启内存触顶监控后会触发此回调，返回前一次app运行时单次生命周期内的最大物理内存数据
    [detector setPerformanceDataDelegate:[BAOOMDataManager getInstance]];
    
    // 单次大块内存分配监控
    //    [detector startSingleChunkMallocDetector:50 * 1024 * 1024 callback:^(size_t bytes, NSString *stack) {
    //        [[NSNotificationCenter defaultCenter] postNotificationName:kChunkMallocNoti object:stack];
    //    }];
    
    // 开启内存泄漏监控，目前只可检测真机运行时的内存泄漏，模拟器暂不支持
    [detector setupLeakChecker];
    
    // 开启MallocStackMonitor用以监控通过malloc方式分配的内存
    [detector startMallocStackMonitor:10 * 1024 * 1024 needAutoDumpWhenOverflow:YES dumpLimit:300 sampleInterval:0.1];
    
    // 开启VMStackMonitor用以监控非直接通过malloc方式分配的内存
    // 因为startVMStackMonitor:方法用到了私有API __syscall_logger会带来app store审核不通过的风险，此方法默认只在DEBUG模式下生效，如果
    // 需要在RELEASE模式下也可用，请打开USE_VM_LOGGER_FORCEDLY宏，但是切记在提交appstore前将此宏关闭，否则可能会审核不通过
    [detector startVMStackMonitor:10 * 1024 * 1024];
    
    // 调用该接口上报所有缓存的OOM相关log给通过setFileDataDelegate:方法设置的代理，建议在启动的时候调用
    [detector uploadAllStack];
    
    /*************************************************************************/
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [viewController.tabBarItem ba_hiddenBadge];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
//    self.window.backgroundColor = BAKit_Color_Yellow_Goldenrod;
    
    [self test222_addView];
}

- (void)test222_addView
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

- (void)test222_removeView
{
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        if (window.windowLevel == UIWindowLevelNormal) {
            UIView *view = [window viewWithTag:1111111];
            [view removeFromSuperview];
        }
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

    [self test222_addView];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self test222_removeView];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self test222_removeView];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
