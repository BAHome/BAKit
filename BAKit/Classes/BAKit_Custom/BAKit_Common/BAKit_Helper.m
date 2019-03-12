//
//  BAKit_Helper.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/17.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAKit_Helper.h"
#import <CoreLocation/CoreLocation.h>
#import "BAKit_RegularExpression.h"

#import "BAKit_DefineCommon.h"
#import "BAKit_DefineSystem.h"

#import "UIViewController+BAKit.h"
#import "UIViewController+BABottomLine.h"

#import "UIImage+BAColor.h"

@implementation BAKit_Helper

/*!
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void)ba_helperTelWithPhoneNumber:(NSString *)phoneNumber
{
    if (![BAKit_RegularExpression ba_regularIsMobileNumber:phoneNumber])
    {
        if ([phoneNumber isEqualToString:@"10010"] ||
            [phoneNumber isEqualToString:@"10086"] ||
            [phoneNumber isEqualToString:@"10000"])
        {

        }
        else
        {
            BAKit_ShowAlertWithMsg(@"电话号码格式错误！");
            return;
        }
    }
    
    [BAKit_SharedApplication openURL:[NSURL URLWithString:[@"tel:" stringByAppendingString: phoneNumber]]];
    // 打电话
//    UIWebView *webView=[[UIWebView alloc] init];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]]];
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [app.window.rootViewController.view addSubview:webView];
    
    /*!
     
     拨打电话 的几种常用方法
     
     1，这种方法，拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示
     NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
     //            NSLog(@"str======%@",str);
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
     
     2，这种方法，打完电话后还会回到原来的程序，也会弹出提示，推荐这种
     NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
     UIWebView * callWebview = [[UIWebView alloc] init];
     [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
     [self.view addSubview:callWebview];
     [callWebview release];
     [str release];
     
     3,这种方法也会回去到原来的程序里（注意这里的telprompt），也会弹出提示
     NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"186xxxx6979"];
     //            NSLog(@"str======%@",str);
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]]
     
     */
}

/*!
 *  跳转Safari浏览器
 */
+ (void)ba_helperGotoSafariBrowserWithURL:(NSString *)url
{
    if ([BAKit_RegularExpression ba_regularIsUrl:url])
    {
        /*! 跳转系统通知 */
        BAKit_OpenUrl(url);
    }
    else
    {
        NSLog(@"url错误，请重新输入！");
    }
    
}

/**
 当前存在的 VisibleViewController
 
 @return 当前存在的 VisibleViewController
 */
+ (nullable UIViewController *)ba_helperVisibleViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *visibleViewController = [rootViewController ba_visibleViewControllerIfExist];
    return visibleViewController;
}


/**
 自定义切换 状态栏颜色，默认：UIStatusBarStyleDefault（黑色字体），注意：需要在 info.plist 文件中将 【View controller-based status bar appearance】 设置为 NO

 @param sure YES：UIStatusBarStyleDefault（黑色字体），NO：UIStatusBarStyleLightContent（白色字体）
 */
+ (void)ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:(BOOL)sure
{
    if (sure)
    {
        [UIApplication.sharedApplication setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    }
    else
    {
        [UIApplication.sharedApplication setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

/**
 快速自定义 navi 所有设置

 @param barTintColor navi 背景颜色
 @param tintColor 字体颜色、返回按钮颜色
 @param font 字体
 @param fontColor 字体颜色
 @param isNeedBottomLine 是否需要底部的分割线
 @param navigationController navigationController
 */
+ (void)ba_helperSetNaviBarBarTintColor:(UIColor *__nullable)barTintColor
                              tintColor:(UIColor *__nullable)tintColor
                                   font:(UIFont *__nullable)font
                              fontColor:(UIColor *__nullable)fontColor
                       isNeedBottomLine:(BOOL)isNeedBottomLine
                   navigationController:(UINavigationController *)navigationController
{
    UINavigationBar *navigationBar = navigationController.navigationBar;
    navigationController.navigationBar.translucent = NO;
    navigationBar.tintColor = nil;
    navigationBar.barTintColor = nil;

    if (tintColor)
    {
        navigationBar.tintColor = tintColor;
    }
    if (barTintColor)
    {
        navigationBar.barTintColor = barTintColor;
    }
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    if (fontColor)
    {
        textAttrs[NSForegroundColorAttributeName] = fontColor;
    }
    if (font)
    {
        textAttrs[NSFontAttributeName] = font;
    }
    [navigationBar setTitleTextAttributes:textAttrs];
    
    if (!isNeedBottomLine)
    {
        // 去掉导航分割线
        [navigationController ba_hideBottonLineInView:navigationBar];
    }
}

/**
 快速自定义 tabbar 所有设置
 
 @param selectedTintColor 选中颜色
 @param normalTintColor 非选中颜色
 @param backgroundImage 背景图片
 @param backgroundColor 背景颜色（和背景图片二选一）
 */
+ (void)ba_helperSetTabbarSelectedTintColor:(UIColor * __nullable)selectedTintColor
                            normalTintColor:(UIColor * __nullable)normalTintColor
                            backgroundImage:(UIImage * __nullable)backgroundImage
                            backgroundColor:(UIColor * __nullable)backgroundColor
{
    if (selectedTintColor)
    {
        // 自定义 tabBar：默认选中颜色
        [UITabBar appearance].tintColor = selectedTintColor;
        // 自定义 tabBar：默认非选中颜色
        NSDictionary <NSString *, id> *textAttributes = @{NSForegroundColorAttributeName: selectedTintColor};
        [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateSelected];
    }
    
    if (normalTintColor)
    {
        // 自定义 tabBar：默认非选中颜色
        NSDictionary <NSString *, id> *textAttributes = @{NSForegroundColorAttributeName: normalTintColor};
        [[UITabBarItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    }
    
    if (backgroundImage)
    {
        // 自定义 tabBar：默认背景图片
        [UITabBar appearance].backgroundImage = backgroundImage;
    }
    else if (backgroundColor)
    {
        // 自定义 tabBar：默认背景颜色
        [UITabBar appearance].backgroundImage = [UIImage ba_image_Color:backgroundColor];
    }
}

- (void)ba_helperSetTabbarItem
{
    
}

@end

@implementation BAKit_Helper (NSNULL)

#pragma mark - ***** 判断字典是否为空
+ (BOOL)ba_helperIsNSDictionaryNULL:(id)obj
{
    if(obj == nil) return YES;
    
    if(![obj isKindOfClass:[NSDictionary class]])
        return YES;
    
    //if([obj count] <= 0) return YES;
    return NO;
}

#pragma mark - ***** 判断字符串是否为空
+ (BOOL)ba_helperIsNSStringNULL:(NSString *)stirng
{
    if([stirng isKindOfClass:[NSNull class]]) return YES;
    if(![stirng isKindOfClass:[NSString class]]) return YES;
    
    if(stirng == nil) return YES;
    
    NSString * string1 = [stirng stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSUInteger len=[string1 length];
    if (len <= 0) return YES;
    return NO;
}

#pragma mark - ***** 判断字符串为空和只为空格
+ (BOOL)ba_helperIsBlankString:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    
    if (string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if (string.length==0)
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    
    return NO;
}


@end

@implementation BAKit_Helper (Location)

/*! 判断是否打开定位 */
+ (BOOL)ba_helperIsLocationOpen
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

@end

@implementation BAKit_Helper (NSArray)

/*!
 *  判断数组是否包含有某个 object
 *
 *  @param array  需要判断的数组
 *  @param object 需要判断的数组字段
 *
 *  @return YES / NO
 */
+ (BOOL)ba_helperIsArray:(NSArray *)array containsObject:(NSString *)object
{
    if ([array containsObject:object])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

@implementation BAKit_Helper (PathExtension)

/*!
 *  判断 URL 是否是 MP4
 *
 *  @return YES / NO
 */
+ (BOOL)ba_helperURLIsMp4WithUrl:(NSString *)url
{
    NSString *pathExtention = [url pathExtension];
    if([pathExtention isEqualToString:@"mp4"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end

@implementation BAKit_Helper (Animation)

/**
 BAKit_Helper：view 简单入场动画

 @param view view
 */
+ (void)ba_helperViewAnimation:(UIView *)view
{
    view.alpha = 0.f;
    [UIView animateWithDuration:1.5f animations:^{
        view.alpha = 1.0f;
    }];
}

@end
