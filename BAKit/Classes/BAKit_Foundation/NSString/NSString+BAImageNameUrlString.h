//
//  NSString+BAImageNameUrlString.h
//  BARYTest
//
//  Created by boai on 2017/8/23.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BAImageNameUrlString)

/**
 根据 用户名 转换出 用户名首字母或者第一个汉字 的图片 URL string，类似 阿里钉钉 的默认头像
 
 @param userName 用户名
 @param userId 用户 id，用来识别图像是否已生成，会自动保存本地
 @param imageSize 图像大小，默认：40
 @param backgroundColor 图像的 backgroundColor，可为空，如果为空：则默认为随机颜色
 @return URL string
 */
+ (NSString *)ba_stringDefaultUserPortraitWithUserName:(NSString *)userName
                                                userId:(NSString *)userId
                                             imageSize:(CGFloat)imageSize
                                       backgroundColor:(UIColor *)backgroundColor;

@end
