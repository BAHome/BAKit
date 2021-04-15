//
//  BAKitVC_Keyboard.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAKitVC_Keyboard.h"

#import "BACustomKeyboardTextField.h"
#import "BAKeyboardView.h"

@interface BAKitVC_Keyboard ()

@property (nonatomic, strong) BACustomKeyboardTextField *textField;

@end

@implementation BAKitVC_Keyboard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)ba_base_setupUI {
    
    [self.view addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(35);
    }];
    

    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [BAKeyboardView.shared dismiss];
}

- (BACustomKeyboardTextField *)textField {
    if (_textField == nil) {
        _textField = BACustomKeyboardTextField.new;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        
    }
    return _textField;
}

@end
