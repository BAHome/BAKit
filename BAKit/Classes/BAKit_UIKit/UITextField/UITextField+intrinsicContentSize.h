//
//  UITextField+intrinsicContentSize.h
//  BAKit
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boaiHome. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (intrinsicContentSize)


/**
 UITextField：是否需要左右间距，默认不需要，注意：请在设置 frame 后再设置以下属性！
 */
@property (nonatomic, assign) bool isNeedIntrinsicContentSize;

/**
 UITextField：右边单位文字，
 */
@property (nonatomic, strong) NSString *rightUnit;

/**
 UITextField：右边单位字体
 */
@property (nonatomic, strong) UIFont *rightUnitFont;

/**
 UITextField：右边单位字体颜色
 */
@property (nonatomic, strong) UIColor *rightUnitColor;

@end

NS_ASSUME_NONNULL_END
