//
//  BAKit_MGJRouter_Protocol.h
//  BAKit
//
//  Created by 孙博岩 on 2018/9/3.
//  Copyright © 2018 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BAKit_MGJRouter_Protocol <NSObject>

@required
- (void)registerUrls;

@optional
/**
 * 模块路由通知
 * 跳转当前模块所有路由时，会调用这个通知
 */
- (void)onRouterModule:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
