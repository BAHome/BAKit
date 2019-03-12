//
//  BAKit_MGJRouter_Url.h
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 路由协议:
 * scheme://src/module/path?param1=123&param2=456
 *
 * 应用内跳转：
 * scheme://app/module/path?param1=123&param2=456
 *
 * H5:
 * scheme://h5?url=www.baidu.com%3fparam1%3d123%26param2%3d456
 */

NS_ASSUME_NONNULL_BEGIN

@interface BAKit_MGJRouter_Url : NSObject

@property(nonatomic, strong, readonly) NSString *scheme;
@property(nonatomic, strong, readonly) NSString *src;
@property(nonatomic, strong, readonly) NSString *module;
@property(nonatomic, strong, readonly) NSString *path;

@property(nonatomic, strong, readonly) NSString *url;
@property(nonatomic, strong, readonly) NSURL *urlurl;

- (instancetype)initWithScheme:(NSString *)scheme
                           src:(NSString *)src
                        module:(NSString *)module
                          path:(NSString *)path;
/**
 * 根据module自动获取对应的scheme、src
 */
- (instancetype)initWithModule:(NSString *)module
                          path:(NSString *)path;

/**
 * 对于传入的url如果scheme和src不全，会使用默认值自动不全scheme和src后再处理
 * */
- (instancetype)initWithUrl:(NSString *)url;

+ (NSString *)urlWithScheme:(NSString *)scheme
                        src:(NSString *)src
                     module:(NSString *)module
                       path:(NSString *)path;
+ (NSString *)urlWithModule:(NSString *)module
                       path:(NSString *)path;

+ (NSString *)schemeFromUrl:(NSString *)url;
+ (NSString *)srcFromUrl:(NSString *)url;
+ (NSString *)moduleFromUrl:(NSString *)url;
+ (NSString *)pathFromUrl:(NSString *)url;

/// scheme://src/module
+ (NSString *)modulePathFromUrl:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
