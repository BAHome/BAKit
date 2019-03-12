//
//  CAShapeLayer+BACornerRadius.m
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "CAShapeLayer+BACornerRadius.h"

@implementation CAShapeLayer (BACornerRadius)

/**
 CAShapeLayer：创建一个带不同圆角的 labyer

 @param frame frame description
 @param corners corners description
 @param radius radius description
 @return CAShapeLayer
 */
+ (CAShapeLayer *)ba_shapLayerWithFrame:(CGRect)frame
                                corners:(UIRectCorner)corners
                                 radius:(CGFloat)radius
{
    CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.frame = frame;
    shapLayer.path = path.CGPath;
    
    return shapLayer;
}

@end
