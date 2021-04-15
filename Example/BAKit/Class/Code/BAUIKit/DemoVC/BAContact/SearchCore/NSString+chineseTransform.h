//
//  NSString+chineseTransform.h
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/3/13.
//  Copyright © 2019 boai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (chineseTransform)

/**
 汉字转pinyin

 @param chineseString 中文汉字
 @return 拼音字母
 */
+ (NSString *)chinese_Pinyin:(NSString *)chineseString;


/**
 匹配汉字高亮效果的attributeString
 */
+ (NSMutableAttributedString *)lightStringWithSearchResultName:(NSString *)searchResultName matchArray:(NSArray *)matchArray inputString:(NSString *)inputString lightedColor:(UIColor *)lightedColor;
@end
