//
//  NSObject+BAHUD.h
//  BBB
//
//  Created by 孙博岩 on 2019/2/11.
//  Copyright © 2019 boai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import "UIImage+BAGif.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (BAHUD)

#pragma mark - hud loading

/**
 HUD：加载框
 */
- (void)hud_showLoadingView;

/**
 HUD：在指定 view 添加加载框

 @param view view description
 */
- (void)hud_showLoadingViewOnView:(UIView *)view;
- (void)hud_showLoadingViewWithStatus:(nullable NSString *)string onView:(nullable UIView *)view;

/**
 HUD：加载框+文字

 @param string string description
 */
- (void)hud_showInfoWithStatus:(nullable NSString *)string;

/**
 HUD：加载框-成功

 @param string string description
 */
- (void)hud_showSuccessWithStatus:(nullable NSString *)string;

/**
 HUD：加载框-失败

 @param string string description
 */
- (void)hud_showErrorWithStatus:(nullable NSString *)string;

#pragma mark - hud image / gif

/**
 HUD：加载框-指定图片、文字

 @param image image description
 @param string string description
 */
- (void)hud_showImage:(nonnull UIImage *)image status:(nullable NSString *)string;

/**
 HUD：加载框-指定 gif 图片、文字

 @param gifImageName gifImageName description
 @param string string description
 */
- (void)hud_showGifImage:(nonnull NSString *)gifImageName status:(nullable NSString *)string;

#pragma mark - toast

/**
 HUD：吐司，不带加载框

 @param string string description
 */
- (void)hud_showToastStatus:(nullable NSString *)string;
- (void)hud_showToastStatus:(nullable NSString *)string onView:(nullable UIView *)view;

#pragma mark - dismiss

/**
 HUD：隐藏
 */
- (void)hud_dismiss;

/**
 HUD：延时隐藏

 @param delay delay description
 */
- (void)hud_dismissWithDelay:(NSTimeInterval)delay;

/**
 HUD：隐藏后的处理

 @param completion completion description
 */
- (void)hud_dismissWithCompletion:(nullable SVProgressHUDDismissCompletion)completion;

/**
 HUD：延时隐藏+处理

 @param delay delay description
 @param completion completion description
 */
- (void)hud_dismissWithDelay:(NSTimeInterval)delay completion:(nullable SVProgressHUDDismissCompletion)completion;

@end

NS_ASSUME_NONNULL_END
