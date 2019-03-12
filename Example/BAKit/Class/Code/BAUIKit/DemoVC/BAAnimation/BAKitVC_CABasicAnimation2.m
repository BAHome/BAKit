//
//  BAKitVC_CABasicAnimation2.m
//  BAKit
//
//  Created by boai on 2017/7/13.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_CABasicAnimation2.h"

#import "BAKit_DefineCommon.h"

#import "CABasicAnimation+BAKit.h"
#import "UIView+BAFrame.h"
#import "BAKit_Color.h"

@interface BAKitVC_CABasicAnimation2 ()

@property(nonatomic, strong) UIImageView *imageView;

@end

@implementation BAKitVC_CABasicAnimation2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.imageView.hidden = NO;
    
    CABasicAnimation *animation1 = [CABasicAnimation ba_basicAnimation_opacityFlashingWithDuration:0.2f];
    CABasicAnimation *animation2 = [CABasicAnimation ba_basicAnimation_opacityFlashingWithDuration:0.2f repeatCount:5];
    CABasicAnimation *animation3 = [CABasicAnimation ba_basicAnimation_scaleWithDuration:2.0f repeatCount:FLT_MAX beginTime:1.0f fromValueScale:1.0f toValueScale:0.2f autoreverses:NO];
    CABasicAnimation *animation4 = [CABasicAnimation ba_basicAnimation_scaleXWithDuration:2.0f repeatCount:FLT_MAX beginTime:1.0f fromValueScale:1.0f toValueScale:0.2f autoreverses:NO];
    CABasicAnimation *animation5 = [CABasicAnimation ba_basicAnimation_scaleYWithDuration:2.0f repeatCount:FLT_MAX beginTime:1.0f fromValueScale:1.0f toValueScale:0.2f autoreverses:NO];
    CABasicAnimation *animation6 = [CABasicAnimation ba_basicAnimation_moveXWithDuration:1.0f beginTime:0.0f fromValueX:0 toValueX:100 autoreverses:YES];
    CABasicAnimation *animation7 = [CABasicAnimation ba_basicAnimation_moveYWithDuration:1.0f beginTime:0.0f fromValueY:0 toValueY:100 autoreverses:YES];

    CABasicAnimation *animation8 = [CABasicAnimation ba_basicAnimation_rotationWithDuration:3.0f beginTime:0 toValueAngle:M_PI*2 repeatCount:5 autoreverses:NO];
    CABasicAnimation *animation9 = [CABasicAnimation ba_basicAnimation_rotationXWithDuration:3.0f beginTime:0 toValueAngle:M_PI*2 repeatCount:5 autoreverses:NO];
    CABasicAnimation *animation10 = [CABasicAnimation ba_basicAnimation_rotationYWithDuration:3.0f beginTime:0 toValueAngle:M_PI*2 repeatCount:5 autoreverses:NO];
    CABasicAnimation *animation11 = [CABasicAnimation ba_basicAnimation_rotationZWithDuration:3.0f beginTime:0 toValueAngle:M_PI*2 repeatCount:5 autoreverses:NO];
    
    BAKit_WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BAKit_StrongSelf
        switch (_animationType) {
            case 1:
            {
                [self.imageView.layer addAnimation:animation1 forKey:nil];
            }
                break;
            case 2:
            {
                [self.imageView.layer addAnimation:animation2 forKey:nil];
            }
                break;
            case 3:
            {
                [self.imageView.layer addAnimation:animation3 forKey:nil];
            }
                break;
            case 4:
            {
                [self.imageView.layer addAnimation:animation4 forKey:nil];
            }
                break;
            case 5:
            {
                [self.imageView.layer addAnimation:animation5 forKey:nil];
            }
                break;
            case 6:
            {
                [self.imageView.layer addAnimation:animation6 forKey:nil];
            }
                break;
            case 7:
            {
                [self.imageView.layer addAnimation:animation7 forKey:nil];
            }
                break;
            case 8:
            {
                [self.imageView.layer addAnimation:animation8 forKey:nil];
            }
                break;
            case 9:
            {
                [self.imageView.layer addAnimation:animation9 forKey:nil];
            }
                break;
            case 10:
            {
                [self.imageView.layer addAnimation:animation10 forKey:nil];
            }
                break;
            case 11:
            {
                [self.imageView.layer addAnimation:animation11 forKey:nil];
            }
                break;
                
            default:
                break;
        }

    });
    
}

#pragma mark - setter getter
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = BAKit_Color_Yellow;
        
        _imageView.image = BAKit_ImageName(@"test5");
        
        self.imageView.frame = CGRectMake(0, 0, 200, 200);
        self.imageView.center = self.view.center;
        self.imageView.centerY -= self.imageView.height / 2;
        
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

@end
