//
//  NSTextAttachment+BAKit.m
//  BAKit
//
//  Created by 孙博岩 on 2019/3/5.
//

#import "NSTextAttachment+BAKit.h"

@implementation NSTextAttachment (BAKit)

+ (NSTextAttachment *)ba_creatTextAttachmentWithIconImage:(UIImage *)iconImage {
    UIFont *textFont = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    
    return [self creatTextAttachmentWithTextFont:textFont iconImage:iconImage];
}

+ (NSTextAttachment *)ba_creatTextAttachmentWithTextFont:(UIFont *)textFont
                                               iconImage:(UIImage *)iconImage {
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    [textAttachment setBounds:CGRectMake(0, roundf(textFont.capHeight - iconImage.size.height)/2.f, iconImage.size.width, iconImage.size.height)];
    [textAttachment setImage:iconImage];
    
    return textAttachment;
}

+ (NSMutableAttributedString *)ba_creatTextAttachmentWithIconImage:(UIImage *)iconImage
                                                          textFont:(UIFont *)textFont
                                                  attributedString:(NSMutableAttributedString *)attributedString {
    NSTextAttachment *textAttachment = [self creatTextAttachmentWithTextFont:textFont iconImage:iconImage];
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString appendAttributedString:attrStringWithImage];
    
    return attributedString;
}


@end
