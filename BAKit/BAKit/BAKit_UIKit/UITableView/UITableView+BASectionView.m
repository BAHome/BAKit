//
//  UITableView+BASectionView.m
//  BAKit
//
//  Created by 孙博岩 on 2018/7/18.
//  Copyright © 2018 boai. All rights reserved.
//

#import "UITableView+BASectionView.h"
#import "BAKit_DefineCommon.h"
#import <ReactiveObjC.h>

@interface UITableView ()

@property(nonatomic, strong) UIImageView *sectionImageView;

@end

@implementation UITableView (BASectionView)


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BAKit_Objc_exchangeMethodAToB(@selector(layoutSubviews), @selector(aop_layoutSubviews));
    });
}

- (void)setupUI
{
    if (!self.sectionImageView)
    {
        self.sectionImageView = [UIImageView new];
        if (!self.sectionImage)
        {
            self.sectionImage = BAKit_ImageName(@"table_section");
        }
        self.sectionImageView.image = self.sectionImage;
    }
    
    BAKit_WeakSelf
    [RACObserve(self, contentSize) subscribeNext:^(NSNumber *point) {
        if (point.CGPointValue.x > - weak_self.sectionImageView.top)
        {
            self.sectionImageView.alpha = 1.0f;
        }
        else
        {
            self.sectionImageView.alpha = 0.f;
        }
    }];
}

- (void)aop_layoutSubviews
{
    [self aop_layoutSubviews];

    if (CGRectEqualToRect(self.sectionImageView.frame, CGRectZero))
    {
        self.sectionImageView.frame = CGRectMake(0, 0, self.bounds.size.width, 20);
        [self.superview insertSubview:self.sectionImageView aboveSubview:self];
    }
}

- (void)dealloc
{
    if (self.sectionImageView)
    {
        self.sectionImageView = nil;
    }
}

#pragma mark - setter getter

- (void)setIsShowSectionImageView:(BOOL)isShowSectionImageView
{
    BAKit_Objc_setObj(@selector(isShowSectionImageView), @(isShowSectionImageView));
}

- (BOOL)isShowSectionImageView
{
    return BAKit_Objc_getObj;
}

- (void)setSectionImageView:(UIImageView *)sectionImageView
{
    BAKit_Objc_setObj(@selector(sectionImageView), sectionImageView);
}

- (UIImageView *)sectionImageView
{
    return BAKit_Objc_getObj;
}

- (void)setSectionImage:(UIImage *)sectionImage
{
    BAKit_Objc_setObj(@selector(sectionImage), sectionImage);
    
    [self setupUI];
}

- (UIImage *)sectionImage
{
    return BAKit_Objc_getObj;
}


@end
