//
//  BACustomKeyboardTextField.m
//  Test
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BACustomKeyboardTextField.h"
#import "BAKeyboardView.h"

#import <Masonry.h>


@interface BACustomKeyboardTextField ()


@end

@implementation BACustomKeyboardTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    self.inputView = UIView.new;
    self.inputAccessoryView = UIView.new;
    
    [self addTarget:self action:@selector(onDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(onChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(onDidEnd:) forControlEvents:UIControlEventEditingDidEnd];

}

- (void)onDidBegin:(UITextField *)textField {
    
    if (!BAKeyboardView.shared.isShowed) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [BAKeyboardView.shared show];
        });
    } else {
        [BAKit_APP_WINDOW bringSubviewToFront:BAKeyboardView.shared];
    }
    
    BAKit_WeakSelf
    BAKeyboardView.shared.onTapNumberButtonBlock = ^(NSString * _Nonnull res) {
        BAKit_StrongSelf
        BOOL changeFlag = YES;
        
        if (changeFlag) {
            [self insertText:res];
        }
    };
    
    BAKeyboardView.shared.onTapDeleteButtonBlock = ^{
        BAKit_StrongSelf
        [self deleteBackward];
    };
    
    BAKeyboardView.shared.onTapReturnButtonBlock = ^{
        BAKit_StrongSelf
        
        [self hud_showToastStatus:self.text];
        [self endEditing:YES];
    };
    
    self.onDidBeginEdit ? self.onDidBeginEdit(textField):nil;
}

- (void)onDidEnd:(UITextField *)textField {
//    [BAKeyboardView.shared dismiss];
    
    BAKeyboardView.shared.onTapDeleteButtonBlock = nil;
    BAKeyboardView.shared.onTapNumberButtonBlock = nil;

    self.onDidEndEdit ? self.onDidEndEdit(textField, textField.text):nil;
}

- (void)onChanged:(UITextField *)textField {
    self.onChangedEdit ? self.onChangedEdit(textField):nil;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (_isForbidSharedMenu) {
        UIMenuController *menuController = [UIMenuController sharedMenuController];
        if(menuController) {
            [UIMenuController sharedMenuController].menuVisible=NO;
        }
        return NO;
    }
    
    return YES;
}

@end
