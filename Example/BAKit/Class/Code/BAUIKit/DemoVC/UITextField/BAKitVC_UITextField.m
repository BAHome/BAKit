//
//  BAKitVC_UITextField.m
//  BAKit
//
//  Created by boai on 2017/6/10.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UITextField.h"

@interface BAKitVC_UITextField ()<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UITextField *textField1;

@end

@implementation BAKitVC_UITextField

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.title = @"BATextField";
//    self.view.backgroundColor = BAKit_Color_White;
    [self.view ba_animation_createGradientWithColorArray:@[BAKit_Color_Red, BAKit_Color_White] frame:self.view.bounds direction:UIViewLinearGradientDirectionVertical];

    BAGradualProgressView * gradualProgressView = [[BAGradualProgressView alloc] initWithFrame:CGRectMake(0., 164., self.view.frame.size.width, 2.0)];
    [self.view addSubview:gradualProgressView];
    
    [self performSelector:@selector(gradualProgressWithView:) withObject:gradualProgressView afterDelay:2.];
//    [self.textField ba_textFieldAddInputAccessoryViewButtonWithTitle:@"测试"];
    
}

- (void)gradualProgressWithView:(BAGradualProgressView *)gradualProgressView
{
    gradualProgressView.progress += 0.1;
    
    if (gradualProgressView.progress == 1.0)
    {
        return;
    }
    [self performSelector:@selector(gradualProgressWithView:) withObject:gradualProgressView afterDelay:0.3];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.textField.frame = CGRectMake(20, 80, BAKit_SCREEN_WIDTH - 20 * 2, 30);
    self.textField1.frame = CGRectMake(20, _textField.bottom + 20, BAKit_SCREEN_WIDTH - 20 * 2, 30);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [_textField1 ba_textFieldHistoryArrayHide];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (_textField1 == textField)
    {
        // 当开始编辑的时候，显示 历史数据
        [_textField1 ba_textFieldHistoryArrayShow];
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_textField1 == textField)
    {
        
        CGRect keyboardFrame = [BAKit_SharedApplication ba_applicationGetKeyboardFrame];
        
        NSLog(@"键盘 frame：%@", NSStringFromCGRect(keyboardFrame));
        
        // 输入内容错误，晃动提醒报错
        [_textField1 ba_shake:10 withDelta:5 speed:0.05 shakeDirection:BAKit_ShakeDirectionHorizontal];
        // 点击 return，一定要记得 同步数据
        [_textField1 ba_textFieldHistoryArraySynchronize];
        
        // 同步完数据后，记得隐藏 历史数据
        [_textField1 ba_textFieldHistoryArrayHide];
        _textField1.text = nil;
        [_textField1 resignFirstResponder];
        return YES;
    }
    return NO;
}

#pragma mark - setter / getter

- (UITextField *)textField
{
    if (!_textField)
    {
        _textField = [UITextField new];
        _textField.placeholder = @"这里是 placeholder！限制最大位数：6！";
        _textField.backgroundColor = BAKit_Color_Gray_11;
        
        // placeholder：文字颜色
        _textField.ba_placeholderColor = BAKit_Color_Green;
        // placeholder：文字字体
        _textField.ba_placeholderFont = BAKit_Font_boldSystemFontOfSize_11;
        // 限制最大输入长度
        _textField.ba_maxLength = 6;

        [self.view addSubview:_textField];
    }
    return _textField;
}

- (UITextField *)textField1
{
    if (!_textField1)
    {
        _textField1 = [UITextField new];
        _textField1.placeholder = @"点击 return 后，可以保存输入历史！【限制输入11位】";
        _textField1.backgroundColor = BAKit_Color_Gray_11;
        _textField1.delegate = self;
        
        // placeholder：文字颜色，默认：黑色
        _textField1.ba_placeholderColor = BAKit_Color_Orange;
        // placeholder：文字字体
        _textField1.ba_placeholderFont = BAKit_Font_boldSystemFontOfSize_13;
        // 限制最大输入长度
        _textField1.ba_maxLength = 11;
        // textFieldID：识别 ID，要用到历史记录，请务必添加
        _textField1.ba_textFieldID = @"user_account";
        
        // clearButton 标题，默认：清楚历史内容
        _textField1.ba_clearButtonTitle = @"clear";
        // clearButton 标题颜色，默认：[[UIColor blueColor] colorWithAlphaComponent:0.5f]
        _textField1.ba_clearButtonTitleColor = BAKit_Color_Cyan;
        
        [self.view addSubview:_textField1];
    }
    return _textField1;
}

@end
