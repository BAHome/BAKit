//
//  UILabel+BAKit.h
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (BAKit)

/**
 UILabel：设置 文字的 间距
 
 @param columnSpace 间距
 */
- (void)ba_labelSetColumnSpace:(CGFloat)columnSpace;

/**
 UILabel：设置 文字的 间距
 
 @param rowSpace 间距
 */
- (void)ba_labelSetRowSpace:(CGFloat)rowSpace;

/**
 UILabel：快速创建一个 label，frame、text、font、textColor
 
 @param frame frame description
 @param text text description
 @param textFont textFont description
 @param textColor textColor description
 @param textAlignment textAlignment description
 @return label
 */
+ (UILabel *)ba_labelWithFrame:(CGRect)frame
                          text:(NSString *)text
                      textFont:(UIFont *)textFont
                     textColor:(UIColor *)textColor
                 textAlignment:(NSTextAlignment)textAlignment;

@end
