//
//  NSMutableAttributedString+BAKit.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "NSMutableAttributedString+BAKit.h"
#import "NSTextAttachment+BAKit.h"

@implementation NSMutableAttributedString (BAKit)

#pragma mark 完全自定义样式
- (void)ba_changeAttributeDict:(NSDictionary *)dict range:(NSRange)range {
    [self addAttributes:dict range:range];
}

#pragma mark 设置字体颜色，取值为 UIColor，默认为黑色
- (void)ba_changeColor:(UIColor *)color range:(NSRange)range {
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

#pragma mark 设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
//#warning NSForegroundColorAttributeName 和 NSBackgroundColorAttributeName 的低位是相等的，跟前面介绍的 textColor 一样，哪个属性最后一次赋值，就会冲掉前面的效果
- (void)ba_changeBackgroundColor:(UIColor *)color range:(NSRange)range {
    [self addAttribute:NSBackgroundColorAttributeName value:color range:range];
}

//#pragma mark 设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符，  //  2 表示使用所有连体符号，默认值为 1（iOS 不支持 2）
//- (void)ba_changeLigatureWithValue:(int)value range:(NSRange)range
//{
//    [self addAttribute:NSLigatureAttributeName value:[NSNumber numberWithInt: value] range:range];
//    // return range;
//}

#pragma mark 改变某位置 设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
- (void)ba_changeSystemFont:(UIFont *)font range:(NSRange)range {
    [self addAttribute:NSFontAttributeName value:font range:range];
}

#pragma mark 设置字形倾斜度，取值为 NSNumber（float）,正值右倾，负值左倾
- (void)ba_changeObliquenessValue:(NSNumber *)value range:(NSRange)range {
    [self addAttribute:NSObliquenessAttributeName value:value range:range];
}

#pragma mark NSVerticalGlyphFormAttributeName  设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本 在 iOS 中，总是使用横排文本，0 以外的值都未定义
- (void)ba_changeVerticalGlyphFormValue:(NSNumber *)value range:(NSRange)range {
    [self addAttribute:NSVerticalGlyphFormAttributeName value:value range:range];
}

#pragma mark NSWritingDirectionAttributeName 设置文字书写方向，从左向右书写或者从右向左书写
- (void)ba_changeWritingDirectionStyle:(NSWritingDirection)style {
    [self addAttribute:NSWritingDirectionAttributeName value:@[@(NSWritingDirectionRightToLeft)] range:NSMakeRange(0, self.length)];
}

#pragma mark 改变某位置的行距
- (void)ba_changeLineSpacing:(CGFloat)spacing
                           from:(NSInteger)loc
                          length:(NSInteger)length {
    NSRange range = NSMakeRange(loc, length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    /*! 行距 */
    style.lineSpacing = spacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:range];
}

/*! 改变某位置的段落距离 */
- (void)ba_changeParagraphSpacing:(CGFloat)spacing
                                 from:(NSInteger)loc
                                length:(NSInteger)length {
    NSRange range = NSMakeRange(loc, length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    /*! 段落距离 */
    style.paragraphSpacing = spacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:range];
}

#pragma mark 改变段落的顶部和文本内容的开头之间的距离
- (void)ba_changeBeforeLparagraphSpacing:(CGFloat)spacing
                                      from:(NSInteger)loc
                                     length:(NSInteger)length {
    NSRange range = NSMakeRange(loc, length);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    /*! 段落的顶部和文本内容的开头之间的距离 */
    style.paragraphSpacingBefore = spacing;
    [self addAttribute:NSParagraphStyleAttributeName value:style range:range];
}

#pragma mark 设置下划线样式：根据枚举选择
- (void)ba_changeUnderlineStyle:(NSUnderlineStyle)style color:(UIColor *)color Range:(NSRange)range {
    [self addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:style] range:range];
    [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
}

#pragma mark 全部加下划线 设置下划线样式：根据枚举选择
- (void)ba_changeUnderlineAtAllStyle:(NSUnderlineStyle)style color:(UIColor *)color {
    NSRange range = NSMakeRange(0, self.length);
    [self ba_changeUnderlineStyle:style color:color Range:range];
}

#pragma mark 设置删除线样式：根据枚举选择
- (void)ba_changeStrikethroughStyle:(NSUnderlineStyle)style color:(UIColor *)color Range:(NSRange)range {
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:style] range:range];
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
}

#pragma mark 全部添加删除线 设置删除线样式：根据枚举选择
- (void)ba_changeStrikethroughAtAllStyle:(NSUnderlineStyle)style color:(UIColor *)color {
    NSRange range = NSMakeRange(0, self.length);
    [self ba_changeStrikethroughStyle:style color:color Range:range];
}

#pragma mark 设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄 
- (void)ba_changeKernWithValue:(NSNumber *)value Range:(NSRange)range {
    [self addAttribute:NSKernAttributeName value:value range:range];
}

#pragma mark 根据位置设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
- (void)ba_changeExpansionWithValue:(NSNumber *)value Range:(NSRange)range {
    [self addAttribute:NSExpansionAttributeName value:value range:range];
}

#pragma mark 根据位置添加阴影效果
- (void)ba_changeShadowWithShadow:(NSShadow *)shadow Range:(NSRange)range {
    [self addAttribute:NSShadowAttributeName value:shadow range:range];
    /*! 排版 */
    [self addAttribute:NSVerticalGlyphFormAttributeName value:@(0) range:range];
}

#pragma mark 根据位置修改描边颜色 垂直标志符号形式
- (void)ba_changeStrokeColorWithColor:(UIColor *)strokeColor
                             strokeWidth:(NSNumber *)strokeWidth
                                   Range:(NSRange)range {
    [self addAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
    [self addAttribute:NSStrokeWidthAttributeName value:strokeWidth range:range];
}

- (instancetype)initWithStrings:(NSArray <NSString *>*)texts
                attributesArray:(NSArray <NSDictionary<NSString *,id>*>*)attrsArray
                          space:(NSArray <NSNumber *>*)space {
    if (self = [super init]) {
        
    }
    return [self go:texts andAttributesArray:attrsArray space:space];
}

- (instancetype)go:(NSArray *)textArray andAttributesArray:(NSArray *)attrsArray space:(NSArray<NSNumber *> *)space {
    __block NSMutableAttributedString *string = [[NSMutableAttributedString alloc]init];
    
    __weak typeof(self)weakSelf = self;
    [textArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSUInteger attrsCount = attrsArray.count;
        if (idx <= (attrsCount-1) ) {
            [string appendAttributedString:[strongSelf initWithString:obj attributes:attrsArray[idx]]];
        } else {
            [string appendAttributedString:[strongSelf initWithString:obj attributes:attrsArray[attrsCount-1]]];
        }
        
        if (idx != textArray.count-1 && idx <= space.count-1) {
            [string appendAttributedString:[self spaceWidthWithNumberBlackSpace:space[idx]]];
        } else {
            [string appendAttributedString:[self spaceWidthWithNumberBlackSpace:0]];
        }
    }];
    
    return string;
}

- (NSMutableAttributedString *)spaceWidthWithNumberBlackSpace:(NSNumber *)number {
    NSString *string = @"";
    NSUInteger count = [number integerValue];
    for (NSUInteger i = 0;i < count ; i++) {
        string = [string stringByAppendingFormat:@" "];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    return attributedString;
}

/**
 NSMutableAttributedString：快速创建一个带颜色的文字
 
 @param allString 所有的文字
 @param heighLightString 高亮文字
 @param heighLightColor 高亮颜色
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)ba_mutableAttributedStringWithAllString:(NSString *)allString
                                                      heighLightString:(NSString *)heighLightString
                                                       heighLightColor:(UIColor *)heighLightColor {
    NSRange heightLightRange = [allString rangeOfString:heighLightString];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:allString];
    
    [attributedString ba_changeColor:heighLightColor range:heightLightRange];
    
    return attributedString;
}

/**
 NSMutableAttributedString：快速创建一个带颜色、字体的文字
 
 @param allString 所有的文字
 @param heighLightString 高亮文字
 @param heighLightColor 高亮颜色
 @param heighLightFont 高亮字体
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)ba_mutableAttributedStringWithAllString:(NSString *)allString
                                                      heighLightString:(NSString *)heighLightString
                                                       heighLightColor:(UIColor *)heighLightColor
                                                        heighLightFont:(UIFont *)heighLightFont {
    NSRange heightLightRange = [allString rangeOfString:heighLightString];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:allString];
    [attributedString ba_changeColor:heighLightColor range:heightLightRange];
    [attributedString ba_changeSystemFont:heighLightFont range:heightLightRange];
    // 系统方法实现
//    [attributedString addAttributes:@{NSForegroundColorAttributeName:heighLightColor, NSFontAttributeName:heighLightFont}
//                              range:[allString rangeOfString:heighLightString]];
    
    return attributedString;
}


/**
 NSMutableAttributedString：快速创建一个带文字图片的 string

 @param leftText leftText description
 @param midImage midImage description
 @param rightText rightText description
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)ba_mutableAttributedStringWithLeftText:(NSString *)leftText
                                                             midImage:(UIImage *)midImage
                                                             textFont:(UIFont *)textFont
                                                            rightText:(NSString *)rightText {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:leftText?:@""]];
    
    // 图标
    attributedString = [NSTextAttachment ba_creatTextAttachmentWithIconImage:midImage textFont:textFont attributedString:attributedString];
    
    // 名称
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:rightText]];
    
    return attributedString;
}

/**
 NSMutableAttributedString：两边文字，中间高亮文字

 @param leftString leftString description
 @param midString midString description
 @param rightString rightString description
 @param midColor midColor description
 @param midFont midFont description
 @param baselineOffset 高亮文字字体大小差异大的时候，需要设置偏移量：正数往上，负数往下偏移

 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)ba_mutableAttributedStringWithLeftString:(NSString *)leftString
                                                              midString:(NSString *)midString
                                                            rightString:(NSString *)rightString
                                                               midColor:(UIColor *)midColor
                                                                midFont:(UIFont *)midFont
                                                         baselineOffset:(NSNumber *)baselineOffset {
    NSMutableAttributedString *attributedString = NSMutableAttributedString.new;
    NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithString:leftString];
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:midColor,
                           NSFontAttributeName:midFont,
                           NSBaselineOffsetAttributeName:baselineOffset
                           };
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithString:midString attributes:dict];
    NSAttributedString *attributedString3 = [[NSAttributedString alloc] initWithString:rightString];
    
    [attributedString appendAttributedString:attributedString1];
    [attributedString appendAttributedString:attributedString2];
    [attributedString appendAttributedString:attributedString3];
    
    return attributedString;
}


@end
