//
//  NSAttributedString+BASize.h
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (BASize)

/**
 NSAttributedString：根据 宽度 获取 NSAttributedString 高度
 
 @return NSAttributedString 高度
 */
- (CGFloat)ba_attributedStringGetHeightWithWidth:(CGFloat)width;

/**
 NSAttributedString：获取 NSAttributedString 宽度

 @return NSAttributedString 宽度
 */
- (CGFloat)ba_attributedStringGetWidth;

@end
