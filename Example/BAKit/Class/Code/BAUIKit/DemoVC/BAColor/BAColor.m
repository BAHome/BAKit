//
//  BAColor.m
//  BAKit
//
//  Created by boai on 2017/6/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAColor.h"

@implementation BAColor

+ (instancetype)ba_colorWithColorValue:(NSInteger)colorValue
                             colorDesc:(NSString *)colorDesc
                       colorMethodName:(NSString *)colorMethodName
{
    BAColor *color = [[self alloc] init];
    
    color.ba_colorValue = colorValue;
    color.ba_colorDesc = colorDesc;
    color.ba_colorMethodName = colorMethodName;
    
    return color;
}

@end
