//
//  UIAlertAction+BAKit.h
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BAKit_AlertActionBlock)(UIAlertAction *action);

@interface UIAlertAction (BAKit)

/**
 UIAlertAction：Default 样式
 
 @param title title description
 @param actionBlock actionBlock description
 @return UIAlertAction
 */
+ (instancetype)ba_alertActionDefaultStyleActionWithTitle:(NSString *)title
                                              actionBlock:(BAKit_AlertActionBlock)actionBlock;

/**
 UIAlertAction：Cancel 样式
 
 @param title title description
 @param actionBlock actionBlock description
 @return UIAlertAction
 */
+ (instancetype)ba_alertActionCancleStyleWithTitle:(NSString *)title
                                       actionBlock:(BAKit_AlertActionBlock)actionBlock;

/**
 UIAlertAction：Destructive 样式
 
 @param title title description
 @param actionBlock actionBlock description
 @return UIAlertAction
 */
+ (instancetype)ba_alertActionDestructiveStyleWithTitle:(NSString *)title
                                            actionBlock:(BAKit_AlertActionBlock)actionBlock;

@end

CG_INLINE UIAlertAction *
ba_alertActionDefault(NSString *title, BAKit_AlertActionBlock actionBlock){
    return [UIAlertAction ba_alertActionDefaultStyleActionWithTitle:title actionBlock:actionBlock];
}

CG_INLINE UIAlertAction *
ba_alertActionCancle(NSString *title, BAKit_AlertActionBlock actionBlock){
    return [UIAlertAction ba_alertActionCancleStyleWithTitle:title actionBlock:actionBlock];
}

CG_INLINE UIAlertAction *
ba_alertActionDestructive(NSString *title, BAKit_AlertActionBlock actionBlock){
    return [UIAlertAction ba_alertActionDestructiveStyleWithTitle:title actionBlock:actionBlock];
}
