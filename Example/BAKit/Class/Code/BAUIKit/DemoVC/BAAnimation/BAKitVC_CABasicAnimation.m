//
//  BAKitVC_CABasicAnimation.m
//  BAKit
//
//  Created by boai on 2017/7/11.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_CABasicAnimation.h"
#import "BAKit_DefineFrame.h"

#import "BAKit_Color.h"

#import "CABasicAnimation+BAKit.h"
#import "UIView+BAAnimation.h"
#import "UIView+BAFrame.h"

#import "BAButton.h"
#import "BAKit_DefineFont.h"


#define min_y   100
#define min_y1  min_y + 80
#define min_y2  min_y1 + 80
#define min_w   BAKit_SCREEN_WIDTH / 8.0


#define kPoint_start CGPointMake(20, min_y)
#define kPoint_1     CGPointMake(min_w * 2.0, min_y)
#define kPoint_2     CGPointMake(min_w * 2.0, min_y2)
#define kPoint_3     CGPointMake(min_w * 4.0, min_y2)
#define kPoint_4     CGPointMake(min_w * 4.0, min_y1)
#define kPoint_5     CGPointMake(min_w * 6.0, min_y1)
#define kPoint_6     CGPointMake(min_w * 6.0, min_y)
#define kPoint_7     CGPointMake(min_w * 8.0 - 20, min_y)

#define min_duration(dur) dur / min_y


@interface BAKitVC_CABasicAnimation ()

@property(nonatomic, strong) UIView *animationView;
@property(nonatomic, strong) UIButton *animationButton;
@property(nonatomic, strong) UIBezierPath *path;

@end

@implementation BAKitVC_CABasicAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)ba_base_setupUI
{
    self.title = @"CABasicAnimation";
    self.animationView.hidden = NO;
    self.animationButton.hidden = NO;
    
    [self creatLine];
    
}

- (void)creatLine
{
    // 创建一个 UIBezierPath 对象
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 5.0;//宽度

    // 设置初始线段的起点
    [path moveToPoint:kPoint_start];
    
    // 添加线段，定义一或多个子路径
    [path addLineToPoint:kPoint_1];
    [path addLineToPoint:kPoint_2];
    [path addLineToPoint:kPoint_3];
    [path addLineToPoint:kPoint_4];
    [path addLineToPoint:kPoint_5];
    [path addLineToPoint:kPoint_6];
    [path addLineToPoint:kPoint_7];
    
    _path = path;

    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = BAKit_Color_Clear.CGColor;
    layer.strokeColor = BAKit_Color_Yellow.CGColor;
    layer.lineWidth = path.lineWidth;
    layer.lineCap = kCALineCapRound;  //线条拐角
    layer.lineJoin = kCALineJoinRound;  //终点处理
    
    [self.view.layer addSublayer:layer];
}

#pragma mark - custom method

- (void)handleButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected)
    {
        // 变动的属性, keyPath后面跟的属性是CALayer的属性
        [self startAnimation2];
    }
    else
    {
        [self startAnimation];
    }
}

#pragma mark - CAKeyframeAnimation 关键帧动画
- (void)startAnimation2
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    /*
     这个属性用以指定时间函数，类似于运动的加速度
     kCAMediaTimingFunctionLinear//线性
     kCAMediaTimingFunctionEaseIn//淡入
     kCAMediaTimingFunctionEaseOut//淡出
     kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
     kCAMediaTimingFunctionDefault//默认
     */
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    // 旋转的模式，auto 就是沿着切线方向动，autoReverse就是转180度沿着切线动
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.duration = 3.5;
    
    [self.animationView.layer addAnimation:animation forKey:@""];
}

#pragma mark - CABasicAnimation
- (void)startAnimation
{
    // 原生写法
//    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation1.fromValue = [NSValue valueWithCGPoint:kPoint_start];
//    animation1.toValue = [NSValue valueWithCGPoint:kPoint_1];
//    animation1.duration = min_duration(kPoint_1.y);
    // 简单写法
    CABasicAnimation *animation1 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_1.y) beginTime:0 fromValuePosition:kPoint_start toValuePosition:kPoint_1 repeatCount:0 autoreverses:NO];

    CABasicAnimation *animation2 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_2.y) beginTime:(animation1.beginTime + animation1.duration) fromValuePosition:kPoint_1 toValuePosition:kPoint_2 repeatCount:0 autoreverses:NO];

    CABasicAnimation *animation3 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_3.y) beginTime:(animation2.beginTime + animation2.duration) fromValuePosition:kPoint_2 toValuePosition:kPoint_3 repeatCount:0 autoreverses:NO];

    CABasicAnimation *animation4 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_4.y) beginTime:(animation3.beginTime + animation3.duration) fromValuePosition:kPoint_3 toValuePosition:kPoint_4 repeatCount:0 autoreverses:NO];

    CABasicAnimation *animation5 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_5.y) beginTime:(animation4.beginTime + animation4.duration) fromValuePosition:kPoint_4 toValuePosition:kPoint_5 repeatCount:0 autoreverses:NO];

    CABasicAnimation *animation6 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_6.y) beginTime:(animation5.beginTime + animation5.duration) fromValuePosition:kPoint_5 toValuePosition:kPoint_6 repeatCount:0 autoreverses:NO];

    CABasicAnimation *animation7 = [CABasicAnimation ba_basicAnimation_positionWithDuration:min_duration(kPoint_7.y) beginTime:(animation6.beginTime + animation6.duration) fromValuePosition:kPoint_6 toValuePosition:kPoint_7 repeatCount:0 autoreverses:NO];
    
    CGFloat min_totalDuration = animation7.beginTime + animation7.duration;
    
    // 透明度
    CABasicAnimation *opacityAnimation = [CABasicAnimation ba_basicAnimation_opacityWithDuration:2.5f repeatCount:0 beginTime:1.0f fromValueOpacity:1.0f toValueOpacity:0.2f autoreverses:YES];
    
    // 缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation ba_basicAnimation_scaleWithDuration:2.5f repeatCount:0 beginTime:animation3.beginTime fromValueScale:1.0 toValueScale:0.3 autoreverses:YES];
    
    // 圆角
//    CABasicAnimation *cornerAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
//    cornerAnimation.fromValue = @(0);
//    cornerAnimation.toValue = @(20);
//    cornerAnimation.autoreverses = YES;
//    cornerAnimation.beginTime = animation4.beginTime;
//    cornerAnimation.duration = 1.5;
//
//    // 背景颜色
//    CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];

    
    NSArray *animations = @[animation1, animation2, animation3, animation4, animation5, animation6, animation7, opacityAnimation, scaleAnimation];
    CAAnimationGroup *group = [CABasicAnimation ba_animationGroupAnimations:animations duration:min_totalDuration repeatCount:0 removedOnCompletion:YES];

    [self.animationView.layer addAnimation:group forKey:@"rotation"];
}

#pragma mark - setter getter

- (UIView *)animationView
{
    if (!_animationView)
    {
        _animationView = [UIView new];
        _animationView.frame = CGRectMake(0, 0, 50, 50);
        _animationView.center = self.view.center;
        
        [_animationView ba_animation_createGradientWithColorArray:@[BAKit_Color_White, BAKit_Color_Green_LightGreen, BAKit_Color_Green, BAKit_Color_Green_LightGreen, BAKit_Color_White] frame:_animationView.bounds direction:UIViewLinearGradientDirectionDiagonalFromLeftToRightAndTopToDown];
        [_animationView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:_animationView.width / 2];
        
        [self.view addSubview:_animationView];
    }
    return _animationView;
}

- (UIButton *)animationButton
{
    if (!_animationButton)
    {
        _animationButton = [UIButton ba_buttonWithFrame:CGRectZero title:@"点我试试" titleColor:BAKit_Color_Red titleFont:BAKit_Font_systemFontOfSize_15 backgroundColor:BAKit_Color_Gray_11];
        [_animationButton ba_buttonAddTarget:self tag:0 action:@selector(handleButtonAction:)];
        self.animationButton.frame = CGRectMake(0, BAKit_SCREEN_HEIGHT - 100 - 64, 100, 50);
        self.animationButton.centerX = self.view.centerX;
        
        [self.view addSubview:_animationButton];
    }
    return _animationButton;
}


@end
