//
//  BAKitVC_UIWindow.m
//  BAKit
//
//  Created by 孙博岩 on 2018/8/5.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKitVC_UIWindow.h"

@interface BAKitVC_UIWindow ()

@property(nonatomic, strong) UIWindow *window1;
@property(nonatomic, strong) UIWindow *window2;
@property(nonatomic, strong) UIWindow *window3;

@property(nonatomic, strong) UIButton *button1;

@end

@implementation BAKitVC_UIWindow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = BAKit_Color_Blue_SkyBlue;
    
    self.button1.hidden = NO;
    
    [self handleActions];
}

- (void)handleActions
{
    BAKit_WeakSelf
    self.button1.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
        BAKit_StrongSelf
        
        button.selected = !button.selected;
        if (button.selected)
        {
            [self test2];
        }
        else
        {
//        [self test1];
            [self test3];
            // 查看当前所有的window
            NSLog(@"当前所有的window = %@ \nself.window3 = %@",[UIApplication sharedApplication].windows,self.window3);
            
            /*
             当前所有的window = (
             "<UIWindow: 0x163d03c50; frame = (0 0; 414 736); gestureRecognizers = <NSArray: 0x281e88630>; layer = <UIWindowLayer: 0x2810d88e0>>",
             "<UIWindow: 0x15ff029b0; frame = (0 0; 414 736); alpha = 0.5; gestureRecognizers = <NSArray: 0x281e9c1e0>; layer = <UIWindowLayer: 0x2810c2b80>>",
             "<UIWindow: 0x161f026a0; frame = (0 0; 414 736); hidden = YES; gestureRecognizers = <NSArray: 0x281ec4b40>; layer = <UIWindowLayer: 0x281098780>>"
             )
             self.window3 = <UIWindow: 0x163d03c50; frame = (0 0; 414 736); gestureRecognizers = <NSArray: 0x281e88630>; layer = <UIWindowLayer: 0x2810d88e0>>
             */
            
            /*
             通过以上总结如下：
             1、UIWindowLevel的值不仅仅只有UIWindowLevelNormal、UIWindowLevelAlert、UIWindowLevelStatusBar 这三个，可以通过test3看出，只要你想可以是随意值，负数都可以。
             2、UIWindow的显示的确可以通过UIWindowLevel来区分优先级，所有的window都会被加在界面上，只不过会通过优先级罗列起来，UIWindowLevel大的在上面显示，UIWindowLevel小的在下面显示。
             3、UIWindowLevel优先级相等的情况下，看谁后实例化了，谁后实例化谁先显示
             */
        }
    };
}


- (void)handleWindowButtonAction:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
        {
            self.window1.hidden = YES;
        }
            break;
        case 2:
        {
            self.window2.hidden = YES;
        }
            break;

        default:
            break;
    }
    
    
//    [self test2];
//    [self test3];
}

/**
 * 这个方法证明两个问题
 * 1、创建 window 不用添加到任何的控件上面，直接创建完毕就能添加
 * 2、创建一个比默认window的windowLevel大的window来看一下什么效果，效果是会盖在原来的window上面
 */
- (void)test1
{
    if (!_window1)
    {
        self.window1 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        UIButton *windowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [windowBtn setTitle:@"window1点我隐藏" forState:UIControlStateNormal];
        windowBtn.backgroundColor = [UIColor redColor];
        windowBtn.frame = CGRectMake(100, 300, 150, 150);
        [windowBtn addTarget:self action:@selector(handleWindowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        windowBtn.tag = 1;
        [self.window1 addSubview:windowBtn];
    }
    
    self.window1.backgroundColor = BAKit_Color_Yellow_CornColor;
    self.window1.windowLevel = 100;
    self.window1.hidden = NO;
}

/**
 * 这个方法证明两个问题
 * 1、创建 window 不用添加到任何的控件上面，直接创建完毕就能添加
 * 2、创建一个和默认window的windowLevel一样大的window来看一下什么效果，效果是会盖在原来的window上面
 */
- (void)test2
{
    if (!_window2)
    {
        self.window2 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        UIButton *windowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [windowBtn setTitle:@"window2点我隐藏" forState:UIControlStateNormal];
        windowBtn.backgroundColor = [UIColor redColor];
        windowBtn.frame = CGRectMake(100, 300, 150, 150);
        [windowBtn addTarget:self action:@selector(handleWindowButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        windowBtn.tag = 2;
        [self.window2 addSubview:windowBtn];
    }
    
    self.window2.backgroundColor = BAKit_Color_Yellow_Goldenrod;
    // 设置 window 的 windowLevel，设置的和当前存在的window一样
    self.window2.windowLevel = self.view.window.windowLevel;
    self.window2.hidden = NO;
    [self.window2 makeKeyAndVisible];
}

- (void)test3
{
    self.view.window.alpha = 0.5;

    if (!_window3)
    {
        self.window3 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    self.window3.backgroundColor = BAKit_Color_Yellow_LemonChiffon;
    // 设置 window 的 windowLevel，设置的和当前存在的window一样
    self.window3.windowLevel = -1;
    self.window3.hidden = NO;
    [self.window3 makeKeyAndVisible];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    min_x = 50;
    min_y = 100;
    min_w = 100;
    min_h = min_w;
    
    self.button1.frame = CGRectMake(min_x, min_y, min_w, min_h);
}


- (UIButton *)button1
{
    if (!_button1)
    {
        _button1 = [UIButton ba_buttonWithFrame:CGRectZero title:@"点我啊" backgroundColor:BAKit_Color_Red];
        _button1.tag = 0;

        [self.view addSubview:_button1];
    }
    return _button1;
}

@end
