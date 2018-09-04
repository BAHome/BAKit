//
//  BAKit_MGJRouter_Url.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKit_MGJRouter_Url.h"

#import "BAKit_MGJRouterHerder.h"
#import "MJExtension.h"
#import "NSURL+QueryDictionary.h"

@interface BAKit_MGJRouter_Url ()

@property(nonatomic, strong) NSString *scheme;
@property(nonatomic, strong) NSString *src;
@property(nonatomic, strong) NSString *module;
@property(nonatomic, strong) NSString *path;

@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSURL *urlurl;


@end

@implementation BAKit_MGJRouter_Url

- (instancetype)initWithScheme:(NSString *)scheme
                           src:(NSString *)src
                        module:(NSString *)module
                          path:(NSString *)path {
    self = [super init];
    if (!self) return nil;
    
    self.scheme = [scheme mj_underlineFromCamel];
    self.src = [src mj_underlineFromCamel];
    self.module = [module mj_underlineFromCamel];
    self.path = [path mj_underlineFromCamel];
    
    if (!self.scheme.length) {
        NSLog(@"scheme error: %@", scheme);
        return nil;
    }
    if (!self.src.length) {
        NSLog(@"src error: %@", src);
        return nil;
    }
    
    if ([BAKit_MGJRouter_Src_App isEqualToString:src]) {
        if (!self.module.length) {
            NSLog(@"module error: %@", module);
            return nil;
        }
    }
    
    NSString *fullpath = @"";
    if (![BAKit_MGJRouter_Src_H5 isEqualToString:src]) {
        if (self.module.length) {
            fullpath = [fullpath stringByAppendingPathComponent:self.module];
        }
        if (self.path.length) {
            fullpath = [fullpath stringByAppendingPathComponent:self.path];
        }
    }
    
    self.urlurl = [[NSURL alloc] initWithScheme:self.scheme
                                           host:self.src
                                           path:[@"/" stringByAppendingPathComponent:fullpath]];
    
    self.url = [self.urlurl absoluteString];
    NSLog(@"url: %@", self.url);
    
    return self;
}

- (instancetype)initWithModule:(NSString *)module
                          path:(NSString *)path {
    return [self initWithScheme:BAKit_MGJRouter_Scheme_Default
                            src:BAKit_MGJRouter_Src_Default
                         module:module
                           path:path];
}

- (instancetype)initWithUrl:(NSString *)url {
    if (!url.length) {
        return nil;
    }
    
    NSURL *urlurl = [NSURL URLWithString:url];
    if (!urlurl) {
        NSLog(@"NSURL create fail: %@", url);
        return nil;
    }
    
    NSString *scheme = [urlurl scheme]?: BAKit_MGJRouter_Scheme_Default;
    NSString *src = [urlurl host]?: BAKit_MGJRouter_Src_Default;
    NSString *module = nil;
    NSString *path = nil;
    
    NSArray<NSString *> *paths = [urlurl pathComponents];
    for (uint i = 0; i < paths.count; ++i) {
        if ([paths[i] isEqualToString:@"/"]) {
            continue;
        }
        
        if (!module) {
            module = paths[i];
        } else if (!path) {
            path = paths[i];
        } else {
            path = [path stringByAppendingPathComponent:paths[i]];
        }
    }
    
    if ([BAKit_MGJRouter_Src_App isEqualToString:src]) {
        if (!module.length) {
            NSLog(@"app router must have module: %@", url);
            return nil;
        }
    }
    
    return [self initWithScheme:scheme src:src module:module path:path];
}

#pragma mark - Conveninece Methods

+ (NSString *)urlWithScheme:(NSString *)scheme
                        src:(NSString *)src
                     module:(NSString *)module
                       path:(NSString *)path {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithScheme:scheme src:src module:module path:path];
    return routerUrl.url;
}

+ (NSString *)urlWithModule:(NSString *)module
                       path:(NSString *)path {
    return [self urlWithScheme:BAKit_MGJRouter_Scheme_Default src:BAKit_MGJRouter_Src_Default module:module path:path];
}

+ (NSString *)schemeFromUrl:(NSString *)url {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    return routerUrl.scheme;
}

+ (NSString *)srcFromUrl:(NSString *)url {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    return routerUrl.src;
}

+ (NSString *)moduleFromUrl:(NSString *)url {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    return routerUrl.module;
}

+ (NSString *)pathFromUrl:(NSString *)url {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    return routerUrl.path;
}

+ (NSString *)modulePathFromUrl:(NSString *)url {
    BAKit_MGJRouter_Url *routerUrl = [[BAKit_MGJRouter_Url alloc] initWithUrl:url];
    if (!routerUrl) {
        return nil;
    }
    
    return [BAKit_MGJRouter_Url urlWithScheme:routerUrl.scheme
                                  src:routerUrl.src
                               module:routerUrl.module
                                 path:nil];
}

#pragma mark - Getters

- (NSString *)description {
    return [NSString stringWithFormat:@"[url: %@]\n[scheme: %@][src: %@][module: %@][path: %@]",
            self.url, self.scheme, self.src,
            self.module, self.path];
}

@end
