//
//  BAKitVC_PhotoKitManager.m
//  BAKit
//
//  Created by boai on 2017/6/28.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_PhotoKitManager.h"

@interface BAKitVC_PhotoKitManager ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIButton *button;

@end

@implementation BAKitVC_PhotoKitManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = BAKit_Color_White;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.imageView.frame = CGRectMake(100, 100, 100, 100);
    self.imageView.center = self.view.center;
    
    self.button.frame = CGRectMake(self.imageView.x, self.imageView.bottom + 20, 100, 40);
    
}

- (void)handleButtonAction:(UIButton *)sender
{
    [BAKit_PhotoKitManager ba_photoKitManagerSaveImageToLocalWithImage:self.imageView.image viewController:self];
}

#pragma mark - setter / getter
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.image = BAKit_ImageName(@"icon1.jpg");
        
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton ba_buttonWithFrame:CGRectZero title:@"保存图片" titleColor:BAKit_Color_Red titleFont:BAKit_Font_systemFontOfSize_15 backgroundColor:BAKit_Color_Gray_11];

        [_button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_button];
    }
    return _button;
}


@end
