//
//  BAKit_MGJRouter_Manager.h
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAKit_MGJRouter_Manager : NSObject

/**
 * 注意：由于我们的路由遵循URL协议规范，不区分大小写，请使用小写定义路由路径: pagea_b_c
 * 有两种注册路由路径的方式：
 * 1、全路径：scheme://src/module/path
 *    对于非app来源及应用外路由，需要按照全路径格式注册路由
 *    如，H5路由：BAKit://h5
 * 2、模块路径：module/path
 *    对于app内模块路由，直接声明模块+页面路径，会自动使用默认schem和src补全路由路径
 *    如，通用组件扫一扫：common/scan，会补全为BAKit://app/common/scan进行注册
 *
 */

/**
 * 注册路由
 * @param url
 * @param cb 路由跳转时回调，这里跳转完成后可以回传一个id数据给openUrl的请求方
 */
+ (void)registerUrl:(NSString *)url
        withHandler:(id(^)(NSString *url, NSDictionary *params, UIViewController *vc))cb;

+ (void)registerUrlWithScheme:(NSString *)scheme
                          src:(NSString *)src
                       module:(NSString *)module
                         path:(NSString *)path
                  withHandler:(id(^)(NSString *url, NSDictionary *params, UIViewController *vc))cb;

/**
 * 跳转页面
 * @param url 目标页面，对于params在url中的，会把params分离出来
 * @param params 传递的参数
 * @param vc 源vc，用来push目标页面
 * @param cb 跳转后回调
 */
+ (void)openUrl:(NSString *)url
         params:(NSDictionary *)params
       sourceVc:(UIViewController *)vc
     completion:(void (^)(id result))cb;

@end

NS_ASSUME_NONNULL_END
