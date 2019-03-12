//
//  BAKit_MGJRouter_ModuleManager.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKit_MGJRouter_ModuleManager.h"
#import "BAKit_MGJRouterHerder.h"


@interface BAKit_MGJRouter_ModuleManager ()

@property(nonatomic, strong) NSMutableDictionary<NSString *, id<BAKit_MGJRouter_Protocol>> *registedModules;

@end

@implementation BAKit_MGJRouter_ModuleManager

+(instancetype)shared {
    static BAKit_MGJRouter_ModuleManager *routerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        routerManager = [[BAKit_MGJRouter_ModuleManager alloc] init];
    });
    return routerManager;
}

+ (NSString *)yzLogTag {
    return @"Router";
}

+ (void)registerRouterWithScheme:(NSString *)scheme
                             src:(NSString *)src
                          module:(NSString *)module
                       withClass:(Class)cls {
    NSLog(@"[scheme: %@][src: %@][module: %@][cls: %@]", scheme, src, module, cls);
    
    if (![cls conformsToProtocol:@protocol(BAKit_MGJRouter_Protocol)]) {
        NSLog(@"Must conformsToProtocol 'BAKit_MGJRouter_Protocol'");
        return;
    }
    
    id<BAKit_MGJRouter_Protocol> routerModule = (id <BAKit_MGJRouter_Protocol>) [cls new];
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithScheme:scheme?:BAKit_MGJRouter_Scheme_Default
                                                             src:src?:BAKit_MGJRouter_Src_Default
                                                          module:module
                                                            path:nil];
    NSString *modulePath = [BAKit_MGJRouter_Url modulePathFromUrl:routerUrl.url];
    if (!modulePath.length) {
        NSLog(@"router url format error");
        return;
    }
    
    NSLog(@"register router succ: %@", modulePath);
    [[BAKit_MGJRouter_ModuleManager shared].registedModules setObject:routerModule
                                                       forKey:modulePath];
    
    [routerModule registerUrls];
}

+ (void)registerRouterWithSrc:(NSString *)src
                       module:(NSString *)module
                    withClass:(Class)cls {
    [self registerRouterWithScheme:nil
                               src:src
                            module:module
                         withClass:cls];
}

+ (void)registerRouterWithModule:(NSString *)module
                       withClass:(Class)cls {
    [self registerRouterWithScheme:nil
                               src:nil
                            module:module
                         withClass:cls];
}

#pragma mark - Regitsted Modules Handle

- (NSMutableDictionary<NSString *, id<BAKit_MGJRouter_Protocol>> *)registedModules {
    if (!_registedModules) {
        _registedModules = [@{} mutableCopy];
    }
    return _registedModules;
}

+ (bool)isUrlRegisted:(NSString *)url {
    if (!url.length) {
        return NO;
    }
    
    NSString *modulePath = [BAKit_MGJRouter_Url modulePathFromUrl:url];
    if (!modulePath.length) {
        return NO;
    }
    
    return [BAKit_MGJRouter_ModuleManager shared].registedModules[modulePath] != nil;
}

+ (id<BAKit_MGJRouter_Protocol>)getRegistedModule:(NSString *)url {
    NSString *modulePath = [BAKit_MGJRouter_Url modulePathFromUrl:url];
    if (!modulePath.length) {
        return nil;
    }
    
    return [BAKit_MGJRouter_ModuleManager shared].registedModules[modulePath];
}

@end
