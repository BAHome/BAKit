//
//  BAColor.h
//  BAKit
//
//  Created by boai on 2017/6/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAColor : NSObject

@property(nonatomic, assign) NSInteger ba_colorValue;
@property(nonatomic, strong) NSString *ba_colorDesc;
@property(nonatomic, strong) NSString *ba_colorMethodName;


+ (instancetype)ba_colorWithColorValue:(NSInteger)colorValue
                             colorDesc:(NSString *)colorDesc
                       colorMethodName:(NSString *)colorMethodName;

@end
