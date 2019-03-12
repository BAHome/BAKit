//
//  BAKitVC_BadgeValueView.m
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BadgeValueView.h"

@interface BAKitVC_BadgeValueView ()

@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIButton *button2;
@property(nonatomic, strong) UIButton *button3;

@end

@implementation BAKitVC_BadgeValueView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    _button = [UIButton ba_buttonWithFrame:CGRectMake(20, 100, 100, 40) title:@"测试" backgroundColor:BAKit_Color_Yellow];
    [_button ba_buttonAddTarget:self tag:0 action:@selector(handleButtonClick:)];
    [self.view addSubview:_button];
    
    _button2 = [UIButton ba_buttonWithFrame:CGRectMake(20, _button.bottom + 20, 100, 40) title:@"测试" backgroundColor:BAKit_Color_Yellow];
    [_button2 ba_buttonAddTarget:self tag:1 action:@selector(handleButtonClick:)];
    [self.view addSubview:_button2];
    
    _button3 = [UIButton ba_buttonWithFrame:CGRectMake(20, _button2.bottom + 20, 100, 70) title:@"测试" backgroundColor:BAKit_Color_Yellow];
    [_button3 ba_buttonAddTarget:self tag:2 action:@selector(handleButtonClick:)];
    [_button3 ba_buttonSetImage:BAKit_ImageName(@"tabbar_contactsHL") selectedImage:nil highlightedImage:nil disabledImage:nil];
    [_button3 ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeCenterImageTop padding:5];
    [self.view addSubview:_button3];
    
    [_button ba_addBadgeWithNumber:888];
    [_button3 ba_addBadgeWithNumber:2];
    [_button2 ba_addBadgeWithText:@"new"];

    [_button3 ba_addBadgeWithNumber:5];
    [_button3 ba_moveBadgeWithX:-30 Y:10];
    
    [self base_setupNavi];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationItem.leftBarButtonItem ba_addBadgeWithNumber:0];
        [self.navigationItem.rightBarButtonItem ba_addBadgeWithText:@"new"];
    });
}

- (void)base_setupNavi
{
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:BAKit_ImageName(@"dinnerHL") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightNavi:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleLeftNavi)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(handleRightNavi)];

//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
//    // 1.给UIBarButtonItem添加badge
//    // 1.1 左边
//    [self.navigationItem.rightBarButtonItem ba_addBadgeWithNumber:1];
//    // 调整badge大小
//    //    [self.navigationItem.leftBarButtonItem pp_setBadgeHeightPoints:25];
//    // 调整badge的位置
//    //    [self.navigationItem.leftBarButtonItem pp_moveBadgeWithX:-7 Y:5];
//    // 自定义badge的属性: 字体大小/颜色, 背景颜色...(默认系统字体13,白色,背景色为系统badge红色)
//    [self.navigationItem.leftBarButtonItem ba_setBadgeLabelAttributes:^(BABadgeLabel *badgeLabel) {
//        badgeLabel.backgroundColor = [UIColor redColor];
//        //        badgeLabel.font =  [UIFont systemFontOfSize:13];
//        //        badgeLabel.textColor = [UIColor blueColor];
//    }];

}

- (void)handleButtonClick:(UIButton *)sender
{
    if (sender.tag == 0)
    {
        [_button ba_increase];
    }
    else if (sender.tag == 1)
    {
        [_button2 ba_hiddenBadge];
    }
    else if (sender.tag == 2)
    {
        [_button3 ba_decrease];
    }
}

- (void)handleLeftNavi
{
    [self.navigationItem.leftBarButtonItem ba_increase];
}

- (void)handleRightNavi
{
    [self.navigationItem.rightBarButtonItem ba_hiddenBadge];
    [self.navigationItem.leftBarButtonItem ba_decrease];
}

@end
