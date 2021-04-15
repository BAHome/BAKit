//
//  BACustomKeyboardTextField.h
//  Test
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BACustomKeyboardTextField : UITextField

@property (nonatomic, assign) BOOL isForbidSharedMenu; // 是否禁止复制/粘贴等菜单项

@property (nonatomic, copy) void (^onDidBeginEdit)(UITextField *textField);
@property (nonatomic, copy) void (^onChangedEdit)(UITextField *textField);
@property (nonatomic, copy) void (^onDidEndEdit)(UITextField *textField, NSString *result);

@end

NS_ASSUME_NONNULL_END
