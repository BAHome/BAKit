//
//  BAKeyboardButton.h
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/5/25.
//  Copyright © 2019 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 BAKeyboardButtonType：键盘按钮样式

 - BAKeyboardButtonType_Number: 纯数字键
 - BAKeyboardButtonType_Decimal: 小数点键
 - BAKeyboardButtonType_Return: 回车确定键
 - BAKeyboardButtonType_Delete: 删除键
 */
typedef NS_ENUM(NSUInteger, BAKeyboardButtonType) {
    BAKeyboardButtonType_Number,
    BAKeyboardButtonType_Decimal,
    BAKeyboardButtonType_Return,
    BAKeyboardButtonType_Delete,
    
};

@interface BAKeyboardButton : UIButton

@property (nonatomic, assign) BAKeyboardButtonType keyboardButtonType;

+ (instancetype)initWithKeyboardButtonType:(BAKeyboardButtonType)keyboardButtonType
                                     title:( NSString * _Nullable )title;

@end

NS_ASSUME_NONNULL_END
