//
//  BAKit_MGJRouter_Manager.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKit_MGJRouter_Manager.h"
#import "BAKit_MGJRouterHerder.h"
#import "MGJRouter.h"
#import "NSURL+QueryDictionary.h"

#define BAKit_MGJRouter_Parameter_VC            @"_bakit_vc"


@implementation BAKit_MGJRouter_Manager

+ (void)openUrl:(NSString *)url
         params:(NSDictionary *)params
       sourceVc:(UIViewController *)vc
     completion:(void (^)(id result))cb {
    NSLog(@"\n\nopenUrl [url: %@][param: %@][vc: %@]", url, params, NSStringFromClass(vc.class));
    
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    if (!routerUrl.url) {
        NSLog(@"url format error");
        return;
    }
    
    if (![BAKit_MGJRouter_ModuleManager isUrlRegisted:routerUrl.url]) {
        NSLog(@"module not registed");
        return;
    }
    
    if (!routerUrl.url.length || ![MGJRouter canOpenURL:routerUrl.url]) {
        NSLog(@"can not open url: %@", routerUrl.url);
        return;
    }
    
    NSString *modulePath = [BAKit_MGJRouter_Url modulePathFromUrl:routerUrl.url];
    if (modulePath.length) {
        id<BAKit_MGJRouter_Protocol> module = [BAKit_MGJRouter_ModuleManager getRegistedModule:modulePath];
        if (module) {
            if ([module respondsToSelector:@selector(onRouterModule:)]) {
                [module onRouterModule:routerUrl.url];
            }
        }
    }
    
    NSMutableDictionary *p = [params?:@{} mutableCopy];
    if (vc) {
        [p setObject:vc forKey:BAKit_MGJRouter_Parameter_VC];
    }
    NSURL *newUrl = [routerUrl.urlurl uq_URLByReplacingQueryWithDictionary:p];
    
    NSLog(@"open router url: %@", [newUrl absoluteString]);
    [MGJRouter openURL:[newUrl absoluteString] withUserInfo:p completion:^(id result) {
        NSLog(@"open result: %@\n\n", result);
        if (cb) {
            cb(result);
        }
    }];
}

+ (void)registerUrl:(NSString *)url
        withHandler:(id(^)(NSString *url, NSDictionary *params, UIViewController *vc))cb {
    if (!url.length) {
        return;
    }
    
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    if (!routerUrl.url.length) {
        NSLog(@"url format error");
        return;
    }
    
    NSLog(@"registerUrl [url: %@]", routerUrl.url);
    
    [MGJRouter registerURLPattern:routerUrl.url toHandler:^(NSDictionary *routerParameters) {
        NSString *_url = routerParameters[MGJRouterParameterURL];
        NSDictionary *_params = routerParameters[MGJRouterParameterUserInfo];
        UIViewController *_vc = _params[BAKit_MGJRouter_Parameter_VC];
        
        NSLog(@"registerUrl callback [url: %@][param: %@][vc: %@]", _url, _params, _vc);
        id cbRet = nil;
        if (cb) {
            cbRet = cb(_url, _params, _vc);
        }
        
        void (^openEndCb)(id result) = routerParameters[MGJRouterParameterCompletion];
        if (openEndCb) {
            openEndCb(cbRet);
        }
    }];
}

+ (void)registerUrlWithScheme:(NSString *)scheme
                          src:(NSString *)src
                       module:(NSString *)module
                         path:(NSString *)path
                  withHandler:(id(^)(NSString *url, NSDictionary *params, UIViewController *vc))cb {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithScheme:scheme src:src module:module path:path];
    if (!routerUrl.url.length) {
        return;
    }
    
    [self registerUrl:routerUrl.url withHandler:cb];
}

@end
