//
//  UIAlertAction+BAKit.m
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIAlertAction+BAKit.h"

@implementation UIAlertAction (BAKit)

/**
 UIAlertAction：Default 样式

 @param title title description
 @param actionBlock actionBlock description
 @return UIAlertAction
 */
+ (instancetype)ba_alertActionDefaultStyleActionWithTitle:(NSString *)title
                                              actionBlock:(BAKit_AlertActionBlock)actionBlock
{
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:actionBlock];
}

/**
 UIAlertAction：Cancel 样式
 
 @param title title description
 @param actionBlock actionBlock description
 @return UIAlertAction
 */
+ (instancetype)ba_alertActionCancleStyleWithTitle:(NSString *)title
                                       actionBlock:(BAKit_AlertActionBlock)actionBlock
{
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:actionBlock];
}

/**
 UIAlertAction：Destructive 样式
 
 @param title title description
 @param actionBlock actionBlock description
 @return UIAlertAction
 */
+ (instancetype)ba_alertActionDestructiveStyleWithTitle:(NSString *)title
                                            actionBlock:(BAKit_AlertActionBlock)actionBlock
{
    return [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:actionBlock];
}

@end
