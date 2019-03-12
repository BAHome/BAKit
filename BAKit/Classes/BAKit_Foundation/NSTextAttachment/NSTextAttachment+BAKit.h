//
//  NSTextAttachment+BAKit.h
//  BAKit
//
//  Created by 孙博岩 on 2019/3/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTextAttachment (BAKit)

+ (NSTextAttachment *)creatTextAttachmentWithIconImage:(UIImage *)iconImage;

+ (NSTextAttachment *)creatTextAttachmentWithTextFont:(UIFont *)textFont iconImage:(UIImage *)iconImage;

+ (NSMutableAttributedString *)ba_creatTextAttachmentWithIconImage:(UIImage *)iconImage
                                                          textFont:(UIFont *)textFont
                                                  attributedString:(NSMutableAttributedString *)attributedString;
@end

NS_ASSUME_NONNULL_END
