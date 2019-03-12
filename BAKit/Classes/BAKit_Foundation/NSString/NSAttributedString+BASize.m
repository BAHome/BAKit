//
//  NSAttributedString+BASize.m
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "NSAttributedString+BASize.h"

@implementation NSAttributedString (BASize)

/**
 NSAttributedString：根据 宽度 获取 NSAttributedString 高度
 
 @return NSAttributedString 高度
 */
- (CGFloat)ba_attributedStringGetHeightWithWidth:(CGFloat)width
{
    CGFloat height = 0;
    
    if (self.length)
    {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                         context:nil];
        
        height = rect.size.height;
    }
    
    return height;
}

/**
 NSAttributedString：获取 NSAttributedString 宽度
 
 @return NSAttributedString 宽度
 */
- (CGFloat)ba_attributedStringGetWidth
{
    CGFloat width = 0;
    
    if (self.length)
    {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                         context:nil];
        
        width = rect.size.width;
    }
    
    return width;
}

@end
