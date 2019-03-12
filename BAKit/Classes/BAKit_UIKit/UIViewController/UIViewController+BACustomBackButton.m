//
//  UIViewController+BACustomBackButton.m
//  BAKit
//
//  Created by boai on 2017/7/1.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIViewController+BACustomBackButton.h"
#import <objc/runtime.h>

@implementation BAMaskView

@end

@implementation UIViewController (BACustomBackButton)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalviewDidLoad = @selector(viewDidLoad);
        SEL swizzledviewDidLoad = @selector(ba_viewDidLoad);
        
        SEL originalviewDidAppear = @selector(viewDidAppear:);
        SEL swizzledviewDidAppear = @selector(ba_viewDidAppear);
        
        Method originalMethodLoad = class_getInstanceMethod(class, originalviewDidLoad);
        Method swizzledMethodLoad = class_getInstanceMethod(class, swizzledviewDidLoad);
        
        Method originalMethodAppear = class_getInstanceMethod(class, originalviewDidAppear);
        Method swizzledMethodAppear = class_getInstanceMethod(class, swizzledviewDidAppear);
        
        BOOL didAddMethodLoad = class_addMethod(class, originalviewDidLoad, method_getImplementation(swizzledMethodLoad), method_getTypeEncoding(swizzledMethodLoad));
        BOOL didAddMethodAppear = class_addMethod(class, originalviewDidAppear, method_getImplementation(swizzledMethodAppear), method_getTypeEncoding(swizzledMethodAppear));

        if (didAddMethodLoad) {
            class_replaceMethod(class, swizzledviewDidLoad, method_getImplementation(originalMethodLoad), method_getTypeEncoding(originalMethodLoad));
        } else {
            method_exchangeImplementations(originalMethodLoad, swizzledMethodLoad);
        }
        
        if (didAddMethodAppear) {
            class_replaceMethod(class, swizzledviewDidAppear, method_getImplementation(originalMethodAppear), method_getTypeEncoding(originalMethodAppear));
        } else {
            method_exchangeImplementations(originalMethodAppear, swizzledMethodAppear);
        }
    });
}

#pragma mark - Method Swizzling

- (void)ba_viewDidLoad {
    [self ba_viewDidLoad];
    
    [self ba_setNaviBackItemTitle];
}

- (void)ba_viewDidAppear {
    [self ba_viewDidAppear];
    [self setBANavNeedLayout];
}

- (void)ba_setNaviBackItemTitle
{
    NSString *title = @"";
    if ([self respondsToSelector:@selector(ba_setupNaviTitle)])
    {
        title = [self ba_setupNaviTitle];
    }
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)setBANavNeedLayout
{
    UIView *nav_backView = nil;
    BAMaskView *nav_qyView = nil;
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
            nav_backView = view;
        } else if ([view isKindOfClass:[BAMaskView class]]) {
            nav_qyView = (BAMaskView *)view;
        }
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = [self isPopGestureAvailable];
    if (nav_backView && !nav_qyView) {
        BAMaskView *qyButtonView = [[BAMaskView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        qyButtonView.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qyButtonView.backButton.frame = CGRectMake(8, 6, 30, 30);
        [qyButtonView.backButton addTarget:self action:@selector(customNavBackButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [qyButtonView addSubview:qyButtonView.backButton];
        [self.navigationController.navigationBar addSubview:qyButtonView];
    } else if (nav_backView && nav_qyView) {
        [nav_qyView.backButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [nav_qyView.backButton addTarget:self action:@selector(customNavBackButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    } else if (!nav_backView && nav_qyView) {
        [nav_qyView removeFromSuperview];
    }
}

- (void)customNavBackButtonMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isPopGestureAvailable {
    return YES;
}

@end
