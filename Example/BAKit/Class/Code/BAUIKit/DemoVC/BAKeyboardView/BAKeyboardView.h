//
//  BAKeyboardView.h
//  BBB
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BAKeyboardViewShowDirectionType) {
    // 从右侧弹出
    BAKeyboardViewShowDirectionType_Right,
    // 从左侧弹出
    BAKeyboardViewShowDirectionType_Left,
    BAKeyboardViewShowDirectionType_Bottom,
};

@interface BAKeyboardView : UIView

@property (nonatomic, copy) void (^onTapNumberButtonBlock)(NSString *res);
@property (nonatomic, copy) void (^onTapDeleteButtonBlock)(void);
@property (nonatomic, copy) void (^onTapReturnButtonBlock)(void);

@property (nonatomic, assign) float keyboardWidthScale;

/**
 是否已经显示
 */
@property (nonatomic, assign) BOOL isShowed;


+ (instancetype)shared;

- (void)show;
- (void)showWithDirectionType:(BAKeyboardViewShowDirectionType)directionType;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
