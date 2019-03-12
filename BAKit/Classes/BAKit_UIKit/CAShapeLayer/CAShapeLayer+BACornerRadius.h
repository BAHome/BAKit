//
//  CAShapeLayer+BACornerRadius.h
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAShapeLayer (BACornerRadius)

/**
 CAShapeLayer：创建一个带不同圆角的 labyer
 
 @param frame frame description
 @param corners corners description
 @param radius radius description
 @return CAShapeLayer
 */
+ (CAShapeLayer *)ba_shapLayerWithFrame:(CGRect)frame
                                corners:(UIRectCorner)corners
                                 radius:(CGFloat)radius;

@end
