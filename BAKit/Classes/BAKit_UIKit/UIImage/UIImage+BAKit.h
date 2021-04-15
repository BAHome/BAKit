//
//  UIImage+BAKit.h
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BAKit)

/**
 创建一个 高斯模糊 图片
 
 @param radius 模糊的半径
 @return 高斯模糊 图片
 */
- (UIImage *)ba_imageGaussianBlur:(CGFloat)radius;

/**
 *  通过 Quartz 2D 在 UIImageView 绘制虚线
 *
 *  param imageView 传入要绘制成虚线的imageView
 *  return
 */
+ (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView
                                 color:(UIColor *)color;

/// 渲染原图，例如：tabbar image 原图显示
/// @param imageName imageName description
+ (UIImage *)originalImageName:(NSString *)imageName;

@end
