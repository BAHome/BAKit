//
//  UILabel+BAKit.m
//  BAKit
//
//  Created by boai on 2017/9/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UILabel+BAKit.h"
#import <CoreText/CoreText.h>

@implementation UILabel (BAKit)

/**
 UILabel：设置 文字的 间距
 
 @param columnSpace 间距
 */
- (void)ba_labelSetColumnSpace:(CGFloat)columnSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    // 调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName value:@(columnSpace) range:NSMakeRange(0, [attributedString length])];
    self.attributedText = attributedString;
}

/**
 UILabel：设置 文字的 间距
 
 @param rowSpace 间距
 */
- (void)ba_labelSetRowSpace:(CGFloat)rowSpace {
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    // 调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

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
                 textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = textFont;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    
    return label;
}


@end
