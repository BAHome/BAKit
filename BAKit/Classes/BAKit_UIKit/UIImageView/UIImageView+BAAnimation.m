//
//  UIImageView+BAAnimation.m
//  BAKit
//
//  Created by boai on 2017/8/14.
//  Copyright © 2017年 博爱之家. All rights reserved.
//

#import "UIImageView+BAAnimation.h"

@implementation UIImageView (BAAnimation)

/**
 图片数组动画

 @param imageArray 图片名数组
 */
- (void)ba_imageViewAnimationWithImageArray:(NSArray <NSString *>*)imageArray
{
    // 如果正在执行动画，就补执行了
    if (self.isAnimating) return;
    // 创建可变数组
    NSMutableArray *images = [NSMutableArray array];
    [imageArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 创建图片
        UIImage *image = [UIImage imageNamed:obj];
        // 图片加入数组
        [images addObject:image];
    }];
    
    // 把图片赋值给imageview的动画数组【轴动画】
    self.animationImages = images;
    // 整个动画播放一圈的时间
    self.animationDuration = imageArray.count * 0.05;
    // 设置动画播放次数
    self.animationRepeatCount = 1;
    // 开始播放动画
    [self startAnimating];
    
    // 清空animationImages 中得图片的时间为动画执行完毕后0.1秒
    CGFloat delay = self.animationDuration + 0.1;
    
    // 延时执行方法
    //    [self performSelector:@selector(clearImages:) withObject:nil afterDelay:delay];
    // 让imageview 延时 delay秒后 执行setAnimationImages方法 来清空animationImages
    [self performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:delay];
}

@end
