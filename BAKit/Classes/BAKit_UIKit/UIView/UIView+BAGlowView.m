//
//  UIView+BAGlowView.m
//  BAKit
//
//  Created by boai on 2017/7/18.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UIView+BAGlowView.h"
#import "BAKit_Color.h"
#import "BAKit_DefineCommon.h"
#import "CABasicAnimation+BAKit.h"

@interface UIView ()

@property (nonatomic, strong) CALayer           *ba_glowLayer;
@property (nonatomic, strong) dispatch_source_t  ba_dispatchSource;

@end

@implementation UIView (BAGlowView)

/**
 *  创建出辉光 layer
 */
- (void)ba_viewCreateGlowLayer
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    [[self ba_accessGlowColor] setFill];
    [path fillWithBlendMode:kCGBlendModeSourceAtop alpha:1.0f];
    
    self.ba_glowLayer = [CALayer layer];
    self.ba_glowLayer.frame = self.bounds;
    self.ba_glowLayer.contents = (__bridge id _Nullable)(UIGraphicsGetImageFromCurrentImageContext().CGImage);
    self.ba_glowLayer.opacity = 0.f;
    self.ba_glowLayer.shadowOffset = CGSizeMake(0, 0);
    self.ba_glowLayer.shadowOpacity = 1.0f;
    
    UIGraphicsEndImageContext();
}

/**
 *  插入辉光的 layer
 */
- (void)ba_viewInsertGlowLayer
{
    if (self.ba_glowLayer)
    {
        [self.layer addSublayer:self.ba_glowLayer];
    }
}

/**
 *  移除辉光的layer
 */
- (void)ba_viewRemoveGlowLayer
{
    if (self.ba_glowLayer)
    {
        [self.ba_glowLayer removeFromSuperlayer];
    }
}

/**
 *  显示辉光
 */
- (void)ba_viewGlowToShowAnimated:(BOOL)animated
{
    self.ba_glowLayer.shadowColor = [self ba_accessGlowColor].CGColor;
    self.ba_glowLayer.shadowRadius = [self ba_accessGlowRadius].floatValue;
    
    if (animated)
    {
        CABasicAnimation *animation = [CABasicAnimation ba_basicAnimation_opacityWithDuration:[self ba_accessAnimationDuration].floatValue repeatCount:0 beginTime:0 fromValueOpacity:0.f toValueOpacity:[self ba_accessGlowOpacity].floatValue autoreverses:NO];
        self.ba_glowLayer.opacity = [self ba_accessGlowOpacity].floatValue;

        [self.ba_glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
    }
    else
    {
        [self.ba_glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.ba_glowLayer.opacity = [self ba_accessGlowOpacity].floatValue;
    }
}

/**
 *  隐藏辉光
 */
- (void)ba_viewGlowToHideAnimated:(BOOL)animated
{
    self.ba_glowLayer.shadowColor = [self ba_accessGlowColor].CGColor;
    self.ba_glowLayer.shadowRadius = [self ba_accessGlowRadius].floatValue;
    
    if (animated)
    {
        CABasicAnimation *animation = [CABasicAnimation ba_basicAnimation_opacityWithDuration:[self ba_accessAnimationDuration].floatValue repeatCount:0 beginTime:0 fromValueOpacity:[self ba_accessGlowOpacity].floatValue toValueOpacity:0.f autoreverses:NO];
        self.ba_glowLayer.opacity = 0.f;
        
        [self.ba_glowLayer addAnimation:animation forKey:@"glowLayerOpacity"];
    }
    else
    {
        [self.ba_glowLayer removeAnimationForKey:@"glowLayerOpacity"];
        self.ba_glowLayer.opacity = 0.f;
    }
}

/**
 *  开始循环辉光
 */
- (void)ba_viewStartGlowLoop
{
    if (self.ba_dispatchSource == nil)
    {
        CGFloat seconds      = [self ba_accessAnimationDuration].floatValue * 2 + [self ba_accessGlowDuration].floatValue + [self ba_accessHideDuration].floatValue;
        CGFloat delaySeconds = [self ba_accessAnimationDuration].floatValue + [self ba_accessGlowDuration].floatValue;
        
        self.ba_dispatchSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        
        __weak UIView *weakSelf = self;
        dispatch_source_set_timer(self.ba_dispatchSource, dispatch_time(DISPATCH_TIME_NOW, 0), NSEC_PER_SEC * seconds, 0);
        dispatch_source_set_event_handler(self.ba_dispatchSource, ^{
            
            [weakSelf ba_viewGlowToShowAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delaySeconds), dispatch_get_main_queue(), ^{
                
                [weakSelf ba_viewGlowToHideAnimated:YES];
            });
        });
        
        dispatch_resume(self.ba_dispatchSource);
    }
    
}


#pragma mark - setter getter

- (UIColor *)ba_accessGlowColor
{
    if (self.ba_glowColor)
    {
        return self.ba_glowColor;
    }
    else
    {
        return BAKit_Color_Red;
    }
}

- (NSNumber *)ba_accessGlowRadius
{
    if (self.ba_glowRadius)
    {
        if (self.ba_glowRadius.floatValue <= 0)
        {
            return @(2.0f);
        }
        else
        {
            return self.ba_glowRadius;
        }
    }
    else
    {
        return @(2.0f);
    }
}

- (NSNumber *)ba_accessAnimationDuration
{
    if (self.ba_glowAnimationDuration)
    {
        if (self.ba_glowAnimationDuration.floatValue <= 0)
        {
            return @(1.0f);
        }
        else
        {
            return self.ba_glowAnimationDuration;
        }
    }
    else
    {
        return @(1.0f);
    }
}

- (NSNumber *)ba_accessHideDuration
{
    if (self.ba_hideDuration)
    {
        if (self.ba_hideDuration.floatValue < 0)
        {
            return @(0.5f);
        }
        else
        {
            return self.ba_hideDuration;
        }
    }
    else
    {
        return @(0.5f);
    }
}

- (NSNumber *)ba_accessGlowDuration
{
    if (self.ba_glowDuration)
    {
        if (self.ba_glowDuration.floatValue <= 0)
        {
            return @(0.5f);
        }
        else
        {
            return self.ba_glowDuration;
        }
    }
    else
    {
        return @(0.5f);
    }
}

- (NSNumber *)ba_accessGlowOpacity
{
    if (self.ba_glowOpacity)
    {
        if (self.ba_glowOpacity.floatValue <= 0 || self.ba_glowOpacity.floatValue > 1)
        {
            return @(0.8f);
        }
        else
        {
            return self.ba_glowOpacity;
        }
    }
    else
    {
        return @(0.8f);
    }
}

- (void)setBa_dispatchSource:(dispatch_source_t)ba_dispatchSource
{
    BAKit_Objc_setObj(@selector(ba_dispatchSource), ba_dispatchSource);
}

- (dispatch_source_t)ba_dispatchSource
{
    return BAKit_Objc_getObj;
}

- (void)setBa_glowColor:(UIColor *)ba_glowColor
{
    BAKit_Objc_setObj(@selector(ba_glowColor), ba_glowColor);
}

- (UIColor *)ba_glowColor
{
    return BAKit_Objc_getObj;
}

- (void)setBa_glowOpacity:(NSNumber *)ba_glowOpacity
{
    BAKit_Objc_setObj(@selector(ba_glowOpacity), ba_glowOpacity);
}

- (NSNumber *)ba_glowOpacity
{
    return BAKit_Objc_getObj;
}

- (void)setBa_glowRadius:(NSNumber *)ba_glowRadius
{
    BAKit_Objc_setObj(@selector(ba_glowRadius), ba_glowRadius);
}

- (NSNumber *)ba_glowRadius
{
    return BAKit_Objc_getObj;
}

- (void)setBa_glowAnimationDuration:(NSNumber *)ba_glowAnimationDuration
{
    BAKit_Objc_setObj(@selector(ba_glowAnimationDuration), ba_glowAnimationDuration);
}

- (NSNumber *)ba_glowAnimationDuration
{
    return BAKit_Objc_getObj;
}

- (void)setBa_glowDuration:(NSNumber *)ba_glowDuration
{
    BAKit_Objc_setObj(@selector(ba_glowDuration), ba_glowDuration);
}

- (NSNumber *)ba_glowDuration
{
    return BAKit_Objc_getObj;
}

- (void)setBa_hideDuration:(NSNumber *)ba_hideDuration
{
    BAKit_Objc_setObj(@selector(ba_hideDuration), ba_hideDuration);
}

- (NSNumber *)ba_hideDuration
{
    return BAKit_Objc_getObj;
}

- (void)setBa_glowLayer:(CALayer *)ba_glowLayer
{
    BAKit_Objc_setObj(@selector(ba_glowLayer), ba_glowLayer);
}

- (CALayer *)ba_glowLayer
{
    return BAKit_Objc_getObj;
}

@end
