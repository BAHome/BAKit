//
//  BAKeyboardButton.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/5/25.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAKeyboardButton.h"

@implementation BAKeyboardButton

+ (instancetype)initWithKeyboardButtonType:(BAKeyboardButtonType)keyboardButtonType
                                     title:( NSString * _Nullable )title {
    BAKeyboardButton *button = BAKeyboardButton.new;
    button.keyboardButtonType = keyboardButtonType;
    
    UIImage *image_normal = UIImage.new;

    UIImage *bgImage_normal = UIImage.new;
    UIImage *bgImage_selected = UIImage.new;
    UIImage *bgImage_highlighted = UIImage.new;

    switch (keyboardButtonType) {
        case BAKeyboardButtonType_Number: {
            
            bgImage_normal = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#F5FFF5" andAlpha:1.0]];
            bgImage_selected = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E7ECE7" andAlpha:1.0]];
            bgImage_highlighted = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E7ECE7" andAlpha:1.0]];

        }
            break;
        case BAKeyboardButtonType_Decimal: {
            
            bgImage_normal = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#F5FFF5" andAlpha:1.0]];
            bgImage_selected = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E7ECE7" andAlpha:1.0]];
            bgImage_highlighted = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E7ECE7" andAlpha:1.0]];

        }
            break;
        case BAKeyboardButtonType_Return: {
            
            image_normal = [UIImage imageNamed:@"keyboard_return"];

            bgImage_normal = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#F5FFF5" andAlpha:1.0]];
            bgImage_selected = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E7ECE7" andAlpha:1.0]];
            bgImage_highlighted = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E7ECE7" andAlpha:1.0]];

        }
            break;
        case BAKeyboardButtonType_Delete: {
            
            image_normal = [UIImage imageNamed:@"keyboard_delete"];
            
            bgImage_normal = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#E6EFE6" andAlpha:1.0]];
            bgImage_selected = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#F5FFF5" andAlpha:1.0]];
            bgImage_highlighted = [UIImage ba_image_Color:[UIColor ba_colorWithHex:@"#F5FFF5" andAlpha:1.0]];

        }
            break;
            
        default:
            break;
    }
    
    if (!BAKit_ObjectIsEmpty(title)) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor ba_colorWithHex:@"#0A5028" andAlpha:1.0] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor ba_colorWithHex:@"#0A5028" andAlpha:0.5] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor ba_colorWithHex:@"#0A5028" andAlpha:0.5] forState:UIControlStateHighlighted];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:18 weight:UIFontWeightMedium]];
    }
   
    [button setImage:image_normal forState:UIControlStateNormal];

    [button setBackgroundImage:bgImage_normal forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage_selected forState:UIControlStateSelected];
    [button setBackgroundImage:bgImage_highlighted forState:UIControlStateHighlighted];
    
    return button;
}

@end
