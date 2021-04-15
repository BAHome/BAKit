//
//  UITextField+intrinsicContentSize.m
//  BAKit
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boaiHome. All rights reserved.
//

#import "UITextField+intrinsicContentSize.h"

#define kPadding 6.0f

static char *unitKey = "UITextField_unitLabel";

@interface UITextField ()

@property (nonatomic, strong) UILabel *unitLabel;

@end

@implementation UITextField (intrinsicContentSize)

- (void)initLeftView {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, kPadding, self.height);
    view.backgroundColor = UIColor.clearColor;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = view;
}

- (void)initRightView {
    
    self.unitLabel.text = self.rightUnit;
    self.unitLabel.textColor = self.rightUnitColor ? : UIColor.redColor;
    self.unitLabel.font = self.rightUnitFont;
    self.unitLabel.backgroundColor = UIColor.clearColor;
    
    CGFloat label_w = BAKit_LabelWidthWithTextAndFont(self.rightUnit, self.height, self.rightUnitFont);
    CGFloat min_w = kPadding + label_w;
    min_w = (min_w <= 26) ? 26 : min_w;
    
    CGFloat min_h = self.size.height;
    min_h = min_h <= 20 ? 20 : min_h;
    
    self.unitLabel.frame = CGRectMake(self.size.width - min_w, 0, min_w, self.size.height);
    
    self.rightView = self.unitLabel;
    self.rightViewMode = UITextFieldViewModeAlways;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
//    [RACObserve(self, layoutSubviews) subscribeNext:^(id  _Nullable x) {
//        CGFloat label_w = BAKit_LabelWidthWithTextAndFont(self.rightUnit, self.height, self.rightUnitFont);
//        CGFloat min_w = kPadding + label_w;
//        min_w = (min_w <= 26) ? 26 : min_w;
//        
//        CGFloat min_h = self.height;
//        min_h = min_h <= 20 ? 20 : min_h;
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.unitLabel.frame = CGRectMake(self.width - min_w, 0, min_w, self.height);
//        });
//    }];
}

- (void)setIsNeedIntrinsicContentSize:(bool)isNeedIntrinsicContentSize {
    
    BAKit_Objc_setObj(@selector(isNeedIntrinsicContentSize), @(isNeedIntrinsicContentSize));
    
    if (isNeedIntrinsicContentSize) {
        [self initLeftView];
        [self initRightView];
    }
}

- (bool)isNeedIntrinsicContentSize {
    return [BAKit_Objc_getObj boolValue];
}

- (void)setRightUnit:(NSString *)rightUnit {
    BAKit_Objc_setObj(@selector(rightUnit), rightUnit);
    [self initRightView];
}

- (NSString *)rightUnit {
    return BAKit_Objc_getObj;
}

- (void)setRightUnitFont:(UIFont *)rightUnitFont {
    BAKit_Objc_setObj(@selector(rightUnitFont), rightUnitFont);
    [self initRightView];
}

- (UIFont *)rightUnitFont {
    return BAKit_Objc_getObj;
}

- (void)setRightUnitColor:(UIColor *)rightUnitColor {
    BAKit_Objc_setObj(@selector(rightUnitColor), rightUnitColor);
}

- (UIColor *)rightUnitColor {
    return BAKit_Objc_getObj;
}

- (void)setUnitLabel:(UILabel *)unitLabel {
    BAKit_Objc_setObj(@selector(unitLabel), unitLabel);
}

- (UILabel *)unitLabel {
    UILabel *label = objc_getAssociatedObject(self, unitKey);
    if (!label) {
        label = UILabel.new;
        //        label.textAlignment = NSTextAlignmentRight;
        objc_setAssociatedObject(self, unitKey, label, OBJC_ASSOCIATION_RETAIN);
    }
    return label;
}

@end
