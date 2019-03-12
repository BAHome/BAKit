//
//  UILabel+BATextAlignment.h
//  BAKit
//
//  Created by 孙博岩 on 2019/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (BATextAlignment)

/**
 UILabel：设置 label 两边分散对齐，注意：要在获取 label 的 frame 后再设置
 */
- (void)ba_textAlignmentLeftAndRight;

/**
 UILabel：设置 label 按照指定的 width 两边分散对齐

 @param labelWidth 指定的 width
 */
- (void)ba_textAlignmentLeftAndRightWithWidth:(CGFloat)labelWidth;


@end

NS_ASSUME_NONNULL_END
