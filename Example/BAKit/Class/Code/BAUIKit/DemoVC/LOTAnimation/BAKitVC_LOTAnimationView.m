//
//  BAKitVC_LOTAnimationView.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/6.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKitVC_LOTAnimationView.h"

#import <BAButton.h>
#import <Lottie/Lottie.h>

@interface BAKitVC_LOTAnimationView ()

@property(nonatomic, strong) UIButton *button;
@property (nonatomic, strong) LOTAnimationView *laAnimation;
@property (nonatomic, strong) NSArray *jsonFiles;

@end

@implementation BAKitVC_LOTAnimationView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)setupUI
{
    self.button.hidden = NO;
    [self test];
    
    BAKit_WeakSelf
    self.button.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
        BAKit_StrongSelf
        
        if (self.laAnimation.isAnimationPlaying) {
            [self.laAnimation pause];
        } else {
            [self.laAnimation play];
        }
    };
    
}

- (void)test
{
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat min_h = 60;
    self.button.frame = CGRectMake(100, 100, min_h, min_h);
    self.button.center = self.view.center;
    [self.button ba_button_setButtonLayoutType:BAKit_ButtonLayoutTypeCenterImageTop padding:2];
    
    //    min_h = 184;
    //    self.laAnimation.frame = CGRectMake(0, 0, min_h, min_h);
    //    CGPoint point = CGPointMake(self.button.center.x-1, self.button.center.y - 15.2);
    //    self.laAnimation.center = point;
    
    min_h = 45;
    self.laAnimation.frame = CGRectMake(0, 0, min_h, min_h);
    CGPoint point = CGPointMake(self.button.center.x-0.5, self.button.center.y-12.5);
    self.laAnimation.center = point;
}

- (LOTAnimationView *)laAnimation
{
    if (!_laAnimation)
    {
        _laAnimation = [LOTAnimationView animationNamed:@"laAnimation_Button.json"];
        _laAnimation.contentMode = UIViewContentModeScaleAspectFill;
        _laAnimation.loopAnimation = YES;
        _laAnimation.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.3];
        [_laAnimation play];
        [self.view addSubview:_laAnimation];
        [self.view bringSubviewToFront:_button];
    }
    return _laAnimation;
}

- (UIButton *)button
{
    if (!_button)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _button.backgroundColor = UIColor.greenColor;
        [_button setTitle:@"称重" forState:UIControlStateNormal];
        [_button setImage:BAKit_ImageName(@"称重-选中") forState:UIControlStateNormal];
        [_button setTitleColor:BAKit_Color_Red_pod forState:UIControlStateNormal];
        
        [self.view addSubview:_button];
    }
    return _button;
}

@end
