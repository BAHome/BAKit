//
//  BAKit_MGJRouter_ModuleManager.h
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAKit_MGJRouter_Protocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface BAKit_MGJRouter_ModuleManager : NSObject

/// 已注册模块：<ModulePath(scheme://src/module), Module>
@property(nonatomic, strong, readonly) NSMutableDictionary<NSString *, id<BAKit_MGJRouter_Protocol>> *registedModules;

+ (instancetype) shared;

/**
 * 提供分级注册路由的功能
 * 没有提供的参数使用默认路径
 * */
+ (void)registerRouterWithScheme:(NSString *)scheme
                             src:(NSString *)src
                          module:(NSString *)module withClass:(Class)cls;
+ (void)registerRouterWithSrc:(NSString *)src
                       module:(NSString *)module
                    withClass:(Class)cls;
+ (void)registerRouterWithModule:(NSString *)module
                       withClass:(Class)cls;

+ (bool)isUrlRegisted:(NSString *)url;
+ (id<BAKit_MGJRouter_Protocol>)getRegistedModule:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
