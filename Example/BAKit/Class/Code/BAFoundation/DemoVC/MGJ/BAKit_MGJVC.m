//
//  BAKit_MGJVC.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/29.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKit_MGJVC.h"

@interface BAKit_MGJVC ()

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *nextButton;

@end

@implementation BAKit_MGJVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI {
    BAKit_WeakSelf
    self.nextButton.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
        BAKit_StrongSelf
        
        BAKit_ShowAlertWithMsg_ios8(button.currentTitle);
        
//        [BAKit_MGJRouter_Manager openUrl:<#(nonnull NSString *)#> params:<#(nonnull NSDictionary *)#> sourceVc:<#(nonnull UIViewController *)#> completion:<#^(id  _Nonnull result)cb#>]
    };
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    min_x = 20;
    min_y = 20;
    min_w = self.view.width - min_x * 2;
    min_h = 45;
    self.textField.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_y = self.textField.bottom + 20;
    self.nextButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
}


#pragma mark - setter, getter

- (UITextField *)textField {
    if (!_textField) {
        _textField = [UITextField new];
        _textField.backgroundColor = BAKit_Color_Gray_10;
        
        [self.view addSubview:_textField];
    }
    return _textField;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton ba_buttonWithFrame:CGRectZero title:@"跳转" backgroundColor:BAKit_Color_Blue_SkyBlue];
        
        [self.view addSubview:_nextButton];
    }
    return _nextButton;
}



@end
