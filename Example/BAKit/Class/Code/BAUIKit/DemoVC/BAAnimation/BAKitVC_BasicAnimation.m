//
//  BAKitVC_BasicAnimation.m
//  BAKit
//
//  Created by boai on 2017/7/8.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BasicAnimation.h"

//#import "UIView+BAAnimation.h"
#import "UIView+BAFrame.h"
#import "BAKit_Color.h"
#import "BAKit_DefineCommon.h"
#import "BAKit_DefineFont.h"

#import "BAButton.h"

#define frame_x  self.imageView.frame.origin.x
#define frame_y  self.imageView.frame.origin.y

@interface BAKitVC_BasicAnimation ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIButton *animationButton;

@end

@implementation BAKitVC_BasicAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI {
    self.title = @"UIView 基本动画";
    self.imageView.hidden = NO;
    self.animationButton.hidden = NO;
    
}


#pragma mark - custom metohd

- (void)handleButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    switch (self.animationType) {
        case 0: {
            [self ba_changFrame];
        }
            break;
        case 1: {
            [self ba_changeBounds];
        }
            break;
        case 2: {
            [self ba_changeCenter];
        }
            break;
        case 3: {
            [self ba_changeAlpha];
        }
            break;
        case 4: {
            [self ba_changeSpring];
        }
            break;
        case 5: {
            [self ba_changeBackgroundColor];
        }
            break;
        case 6: {
            [self ba_changeScale:sender.selected];
        }
            break;
            
        default:
            break;
    }
}

- (void)ba_changFrame {
    CGRect originalFrame = self.imageView.frame;
    CGRect newFrame = CGRectMake(frame_x - 20, frame_y - 100, 100, 100);
    
    [self.imageView ba_animation_changFrameWithDuration:1.f originalFrame:originalFrame newFrame:newFrame finishBlock:^{
        
    }];
}

- (void)ba_changeBounds {
    CGRect originalBounds = self.imageView.bounds;
    /*! 尽管这个 newFrame 的 x，y 跟原始的不同，动画也只是改变了宽高 */
    CGRect newBounds = CGRectMake(0, 0, 300, 100);
    
    [self.imageView ba_animation_changBoundsWithDuration:1.f originalBounds:originalBounds newBounds:newBounds finishBlock:^{
        
    }];
}

- (void)ba_changeCenter {
    CGPoint originalCenter = self.imageView.center;
    CGPoint newCenter = CGPointMake(100, 100);
    
    [self.imageView ba_animation_changCenterWithDuration:1.f originalCenter:originalCenter newCenter:newCenter finishBlock:^{
        
    }];
}

- (void)ba_changeAlpha {
    [self.imageView ba_animation_alphaWithDuration:1.5f startAlpha:0.2f finishAlpha:1.0f];
}

- (void)ba_changeSpring {
//    CGRect originalFrame = self.imageView.frame;
//    CGRect newFrame = CGRectMake(frame_x - 50, frame_y, originalFrame.size.width * 0.3, originalFrame.size.height * 0.3);
//    
//    [self.imageView ba_animation_springWithDuration:1.0f damping:0.2f initialSpringVelocity:5.0f startOptions:UIViewAnimationOptionCurveEaseIn finishOptions:UIViewAnimationOptionCurveEaseIn startBlock:^{
//        self.imageView.frame = newFrame;
//    } finishBlock:^{
//        self.imageView.frame = originalFrame;
//    }];
    
    self.imageView.transform =  CGAffineTransformMakeTranslation(self.imageView.x - 60, self.imageView.y - 100);
    
    [self.imageView ba_animation_springWithDuration:1.0f delay:0.f damping:0.2f initialSpringVelocity:5.0f startOptions:UIViewAnimationOptionCurveEaseIn finishOptions:UIViewAnimationOptionCurveEaseIn startBlock:^{
        self.imageView.transform = CGAffineTransformIdentity;
    } finishBlock:^{

    }];

}

- (void)ba_changeBackgroundColor {
    [UIView animateKeyframesWithDuration:10.0f delay:0.f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.f relativeDuration:1.0 / 4 animations:^{
            self.imageView.backgroundColor = [UIColor colorWithRed:0.9888 green:0.2021 blue:0.1823 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:1.0f / 4 relativeDuration:1.0 / 4 animations:^{
            self.imageView.backgroundColor = [UIColor colorWithRed:0.1888 green:0.7021 blue:0.0823 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:2.0f / 4 relativeDuration:1.0 / 4 animations:^{
            self.imageView.backgroundColor = [UIColor colorWithRed:0.1888 green:0.2021 blue:0.7823 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:3.0f / 4 relativeDuration:1.0 / 4 animations:^{
            self.imageView.backgroundColor = [UIColor colorWithRed:0.5888 green:0.1021 blue:0.6823 alpha:1.0];
        }];
        [UIView addKeyframeWithRelativeStartTime:4.0f / 4 relativeDuration:1.0 / 4 animations:^{
            self.imageView.backgroundColor = [UIColor whiteColor];
        }];
        
    } completion:^(BOOL finished) {
        NSLog(@"动画结束");
    }];
}

- (void)ba_changeScale:(BOOL)isAnimation {
    if (isAnimation) {
        [self.imageView ba_animation_scaleShowWithDuration:1.f ratio:1.f finishBlock:^{
            
        }];
    } else {
        [self.imageView ba_animation_scaleDismissWithDuration:1.f ratio:1.f finishBlock:^{
            
        }];
    }
}

#pragma mark - setter getter
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = BAKit_Color_Yellow;
        
        _imageView.image = BAKit_ImageName(@"test5");
        if (self.animationType == 5) {
            self.imageView.image = BAKit_ImageName(@"tom6");
        }
        
        self.imageView.frame = CGRectMake(0, 0, 200, 200);
        self.imageView.center = self.view.center;
        self.imageView.centerY -= self.imageView.height / 2;
        
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)animationButton {
    if (!_animationButton) {
        _animationButton = [UIButton ba_buttonWithFrame:CGRectZero title:@"点我试试" titleColor:BAKit_Color_Red titleFont:BAKit_Font_systemFontOfSize_15 backgroundColor:BAKit_Color_Gray_11];
        [_animationButton ba_buttonAddTarget:self tag:0 action:@selector(handleButtonAction:)];
        self.animationButton.frame = CGRectMake(0, self.imageView.bottom + 20, 100, 50);
        self.animationButton.centerX = self.view.centerX;
        
        [self.view addSubview:_animationButton];
    }
    return _animationButton;
}


@end
