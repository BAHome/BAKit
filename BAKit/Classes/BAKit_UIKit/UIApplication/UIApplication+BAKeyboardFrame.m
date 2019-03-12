//
//  UIApplication+BAKeyboardFrame.m
//  BAKit
//
//  Created by boai on 2017/6/10.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIApplication+BAKeyboardFrame.h"

@implementation UIApplication (BAKeyboardFrame)

static CGRect _ba_keyboardFrame = (CGRect){ (CGPoint){ 0.0f, 0.0f }, (CGSize){ 0.0f, 0.0f } };

/**
 UIApplication：获取键盘 frame
 
 @return frame
 */
- (CGRect)ba_applicationGetKeyboardFrame
{
    return _ba_keyboardFrame;
}

+ (void)load
{
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidShowNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         _ba_keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     }];
    
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         _ba_keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     }];
    
    [NSNotificationCenter.defaultCenter addObserverForName:UIKeyboardDidHideNotification object:nil queue:nil usingBlock:^(NSNotification *note)
     {
         _ba_keyboardFrame = CGRectZero;
     }];
    
}


@end
