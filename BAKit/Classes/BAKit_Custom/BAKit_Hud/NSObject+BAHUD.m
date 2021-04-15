//
//  NSObject+BAHUD.m
//  BBB
//
//  Created by 孙博岩 on 2019/2/11.
//  Copyright © 2019 boai. All rights reserved.
//

#import "NSObject+BAHUD.h"

#define HUD_CornerRadius 5.0f

static CGFloat kMinimumDismissTimeInterval = 2;
static CGFloat kMaximumDismissTimeInterval = 3.0;

@implementation NSObject (BAHUD)

#pragma mark - hud loading

- (void)hud_showLoadingView {
    [self hud_Appearance];
    [SVProgressHUD show];
}

- (void)hud_showLoadingViewOnView:(UIView *)view {
    [self hud_showLoadingViewWithStatus:nil onView:view];
}

- (void)hud_showLoadingViewWithStatus:(nullable NSString *)string onView:(nullable UIView *)view {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
//        return;
    }
    [self hud_Appearance];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showWithStatus:string];
}

- (void)hud_showInfoWithStatus:(nullable NSString *)string {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
//        return;
    }
    [self hud_Appearance];
    [SVProgressHUD showInfoWithStatus:string];
}

- (void)hud_showSuccessWithStatus:(nullable NSString *)string {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
//        return;
    }
    [self hud_Appearance];
    [SVProgressHUD showSuccessWithStatus:string];
}

- (void)hud_showErrorWithStatus:(nullable NSString *)string {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
//        return;
    }
    [self hud_Appearance];
    [SVProgressHUD showErrorWithStatus:string];
}

#pragma mark - hud image

- (void)hud_showImage:(nonnull UIImage *)image status:(nullable NSString *)string {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
//        return;
    }
    [self hud_Appearance];
    [SVProgressHUD showImage:image status:string];
}

- (void)hud_showGifImage:(nonnull NSString *)gifImageName status:(nullable NSString *)string {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
        //        return;
    }
    [self hud_Appearance];
    [SVProgressHUD showImage:[UIImage imageWithGIFNamed:gifImageName] status:string];
}

#pragma mark - toast

- (void)hud_showToastStatus:(nullable NSString *)string {
    [self hud_showToastStatus:string onView:nil];
}

- (void)hud_showToastStatus:(nullable NSString *)string onView:(nullable UIView *)view {
    if (!string || !string.length) {
        NSLog(@"提示语为空！");
        return;
    }
    [self hud_Appearance];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD showInfoWithStatus:string];
}

#pragma mark - dismiss

- (void)hud_dismiss {
    [self hud_dismissWithDelay:0];
}

- (void)hud_dismissWithDelay:(NSTimeInterval)delay {
    [self hud_dismissWithDelay:delay completion:nil];
}

- (void)hud_dismissWithCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    [self hud_dismissWithDelay:0 completion:completion];
}

- (void)hud_dismissWithDelay:(NSTimeInterval)delay completion:(nullable SVProgressHUDDismissCompletion)completion {
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}



#pragma mark - private

- (void)hud_Appearance {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wnonnull"
    [SVProgressHUD setInfoImage:nil];
    [SVProgressHUD setMinimumSize:CGSizeMake(40, 40)];
    [SVProgressHUD setCornerRadius:HUD_CornerRadius];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0.f alpha:0.7]];
//    [SVProgressHUD setForegroundColor:[UIColor colorWithWhite:1.0f alpha:1.0]];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setMinimumDismissTimeInterval:kMinimumDismissTimeInterval];
    [SVProgressHUD setMaximumDismissTimeInterval:kMaximumDismissTimeInterval];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 0)];
    [SVProgressHUD setRingRadius:10.0];
    [SVProgressHUD setRingNoTextRadius:10.0];
#pragma clang diagnostic pop
}

@end
