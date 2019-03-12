//
//  BAScaleAnimationView.m
//  BAKit
//
//  Created by boai on 2017/7/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAScaleAnimationView.h"
#import "BAKit_Color.h"

#import "CABasicAnimation+BAKit.h"
#import "UIView+BAKit.h"


@interface BAScaleAnimationView ()

@property(nonatomic, strong) UIView *animationView;

@end

@implementation BAScaleAnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.animationView.hidden = NO;
    self.backgroundColor = BAKit_Color_Black;
    
}

- (CAAnimationGroup *)ba_createGroupAnimation
{
    CABasicAnimation *animation1 = [CABasicAnimation ba_basicAnimation_positionWithDuration:8.0f beginTime:0 fromValuePosition:_animationView.layer.position toValuePosition:CGPointMake(_animationView.layer.position.x, _animationView.layer.position.y - 50) repeatCount:0 autoreverses:NO];
    
    CABasicAnimation *animation2 = [CABasicAnimation ba_basicAnimation_scaleWithDuration:3.0f repeatCount:0 beginTime:0 fromValueScale:0.1 toValueScale:1.0 autoreverses:NO];
    
    CABasicAnimation *animation3 = [CABasicAnimation ba_basicAnimation_scaleYWithDuration:5.0f repeatCount:0 beginTime:3.0f fromValueScale:1.0f toValueScale:3.0f autoreverses:NO];
    
    NSArray *animations = @[animation1, animation2, animation3];
    CAAnimationGroup *group = [CABasicAnimation ba_animationGroupAnimations:animations duration:8.0f repeatCount:0 removedOnCompletion:NO];

    return group;
}

#pragma mark - setter getter

- (UIView *)animationView
{
    if (!_animationView)
    {
        _animationView = [UIView new];
        _animationView.frame = CGRectMake(0, 0, 40, 40);
        _animationView.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)-10);
        
        _animationView.backgroundColor = BAKit_Color_Red;
        [self addSubview:_animationView];

        [_animationView ba_viewSetBorderWithColor:nil cornerRadius:20 width:0];
        
        [_animationView.layer addAnimation:[self ba_createGroupAnimation] forKey:nil];
        _animationView.layer.speed = 0;
        _animationView.layer.timeOffset = 0;
        
    }
    return _animationView;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    _animationView.layer.timeOffset = progress;
}

@end
