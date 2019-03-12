//
//  BAInfiniteRotationView.m
//  BAKit
//
//  Created by boai on 2017/8/1.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAInfiniteRotationView.h"
#import "CABasicAnimation+BAKit.h"

@interface BAInfiniteRotationView ()

@property (nonatomic) BOOL   didStartAnimation;

@end

@implementation BAInfiniteRotationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.clockWise = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventDidBecomeActive:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventDidBecomeActive:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventDidBecomeActive:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)startRotateAnimation {

    if (_didStartAnimation == NO) {
        
        _didStartAnimation = YES;
        [self rotateViewAnimationWithView:self];
    }
}

- (void)reset
{
    [self.layer removeAllAnimations];
    _didStartAnimation = NO;
}

- (void)rotateViewAnimationWithView:(UIView *)view
{
    NSTimeInterval tmpSpeed = (_speed <= 0) ? 1 : _speed;
    CABasicAnimation *rotationAnimation = [CABasicAnimation ba_basicAnimation_rotationZWithDuration:(tmpSpeed * 100000) beginTime:0 toValueAngle:(_clockWise ? (M_PI * 100000) : (-M_PI * 100000) + _startAngle) repeatCount:0 autoreverses:NO];
    [view.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)eventDidBecomeActive:(id)obj
{
    NSNotification *fication = obj;
    if ([fication.name isEqualToString:UIApplicationDidBecomeActiveNotification]) {
        
        [UIView animateWithDuration:0.1f animations:^{
            
            self.alpha = 1.f;
            
            if (_didStartAnimation == YES) {
                
                [self rotateViewAnimationWithView:self];
            }
        }];
        
    } else if ([fication.name isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        
        [UIView animateWithDuration:0.1f animations:^{
            
            self.alpha = 0.f;
        }];
        
    } else if ([fication.name isEqualToString:UIApplicationWillResignActiveNotification]) {
        
        [UIView animateWithDuration:0.1f animations:^{
            
            self.alpha = 0.f;
        }];
    }
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
