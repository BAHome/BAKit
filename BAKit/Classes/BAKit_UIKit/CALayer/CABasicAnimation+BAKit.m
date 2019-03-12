//
//  CABasicAnimation+BAKit.m
//  BAKit
//
//  Created by boai on 2017/7/12.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "CABasicAnimation+BAKit.h"

@implementation CABasicAnimation (BAKit)

/**
 创建一个动画：无限闪烁

 @param duration 持续时间
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_opacityFlashingWithDuration:(CFTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation ba_basicAnimation_opacityWithDuration:duration repeatCount:FLT_MAX beginTime:0 fromValueOpacity:1.0f toValueOpacity:0.f autoreverses:NO];

    return animation;
}

/**
 创建一个动画：有次数闪烁
 
 @param duration 持续时间
 @param repeatCount 重复次数
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_opacityFlashingWithDuration:(CFTimeInterval)duration
                                                        repeatCount:(CGFloat)repeatCount
{
    CABasicAnimation *animation = [CABasicAnimation ba_basicAnimation_opacityWithDuration:duration repeatCount:repeatCount beginTime:0 fromValueOpacity:1.0f toValueOpacity:0.f autoreverses:YES];
    
    return animation;
}

/**
 CABasicAnimation：透明度

 @param duration duration description
 @param repeatCount repeatCount description
 @param beginTime beginTime description
 @param fromValueOpacity fromValueOpacity description
 @param toValueOpacity toValueOpacity description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_opacityWithDuration:(CFTimeInterval)duration
                                                repeatCount:(float)repeatCount
                                                  beginTime:(CFTimeInterval)beginTime
                                           fromValueOpacity:(CGFloat)fromValueOpacity
                                             toValueOpacity:(CGFloat)toValueOpacity
                                               autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_Opacity beginTime:beginTime fromValue:@(fromValueOpacity) toValue:@(toValueOpacity) duration:duration repeatCount:repeatCount autoreverses:autoreverses];

    return animation;
}

/**
 CABasicAnimation：缩放

 @param duration duration description
 @param repeatCount repeatCount description
 @param beginTime beginTime description
 @param fromValueScale fromValueScale description
 @param toValueScale toValueScale description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_scaleWithDuration:(CFTimeInterval)duration
                                              repeatCount:(float)repeatCount
                                                beginTime:(CFTimeInterval)beginTime
                                           fromValueScale:(CGFloat)fromValueScale
                                             toValueScale:(CGFloat)toValueScale
                                             autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformScale beginTime:beginTime fromValue:@(fromValueScale) toValue:@(toValueScale) duration:duration repeatCount:repeatCount autoreverses:autoreverses];

    return animation;
}

/**
 CABasicAnimation：缩放 X
 
 @param duration duration description
 @param repeatCount repeatCount description
 @param beginTime beginTime description
 @param fromValueScale fromValueScale description
 @param toValueScale toValueScale description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_scaleXWithDuration:(CFTimeInterval)duration
                                               repeatCount:(float)repeatCount
                                                 beginTime:(CFTimeInterval)beginTime
                                            fromValueScale:(CGFloat)fromValueScale
                                              toValueScale:(CGFloat)toValueScale
                                              autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformScaleX beginTime:beginTime fromValue:@(fromValueScale) toValue:@(toValueScale) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：缩放 Y
 
 @param duration duration description
 @param repeatCount repeatCount description
 @param beginTime beginTime description
 @param fromValueScale fromValueScale description
 @param toValueScale toValueScale description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_scaleYWithDuration:(CFTimeInterval)duration
                                               repeatCount:(float)repeatCount
                                                 beginTime:(CFTimeInterval)beginTime
                                            fromValueScale:(CGFloat)fromValueScale
                                              toValueScale:(CGFloat)toValueScale
                                              autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformScaleY beginTime:beginTime fromValue:@(fromValueScale) toValue:@(toValueScale) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：圆角

 @param duration duration description
 @param repeatCount repeatCount description
 @param beginTime beginTime description
 @param fromValueCornerRadius fromValueCornerRadius description
 @param toValueCornerRadius toValueCornerRadius description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_cornerRadiusWithDuration:(CFTimeInterval)duration
                                                     repeatCount:(float)repeatCount
                                                       beginTime:(CFTimeInterval)beginTime
                                           fromValueCornerRadius:(CGFloat)fromValueCornerRadius
                                             toValueCornerRadius:(CGFloat)toValueCornerRadius
                                                    autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_CornerRadius beginTime:beginTime fromValue:@(fromValueCornerRadius) toValue:@(toValueCornerRadius) duration:duration repeatCount:repeatCount autoreverses:autoreverses];

    return animation;
}

/**
 CABasicAnimation：改变背景颜色

 @param duration 持续时间
 @param repeatCount 重复次数
 @param fromValuebackgroundColor 开始的 backgroundColor
 @param toValuebackgroundColor 结束的 backgroundColor
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_backgroundColorWithDuration:(CFTimeInterval)duration
                                                        repeatCount:(float)repeatCount
                                                          beginTime:(CFTimeInterval)beginTime
                                           fromValuebackgroundColor:(UIColor *)fromValuebackgroundColor
                                             toValuebackgroundColor:(UIColor *)toValuebackgroundColor
                                                       autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_BGColor beginTime:beginTime fromValue:(__bridge id _Nullable)(((UIColor *)fromValuebackgroundColor).CGColor) toValue:(__bridge id _Nullable)(((UIColor *)toValuebackgroundColor).CGColor) duration:duration repeatCount:repeatCount autoreverses:autoreverses];

    return animation;
}

/**
 CABasicAnimation：横向移动 x

 @param duration duration description
 @param beginTime beginTime description
 @param fromValueX fromValueX description
 @param toValueX toValueX description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_moveXWithDuration:(CFTimeInterval)duration
                                                beginTime:(CFTimeInterval)beginTime
                                               fromValueX:(CGFloat)fromValueX
                                                 toValueX:(CGFloat)toValueX
                                             autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformTranslationX beginTime:beginTime fromValue:@(fromValueX) toValue:@(toValueX) duration:duration repeatCount:0 autoreverses:autoreverses];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    return animation;
}

/**
 CABasicAnimation：纵向移动 y

 @param duration duration description
 @param beginTime beginTime description
 @param fromValueY fromValueY description
 @param toValueY toValueY description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_moveYWithDuration:(CFTimeInterval)duration
                                                beginTime:(CFTimeInterval)beginTime
                                               fromValueY:(CGFloat)fromValueY
                                                 toValueY:(CGFloat)toValueY
                                             autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformTranslationY beginTime:beginTime fromValue:@(fromValueY) toValue:@(toValueY) duration:duration repeatCount:0 autoreverses:autoreverses];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;

    return animation;
}

/**
 CABasicAnimation：旋转

 @param duration duration description
 @param beginTime beginTime description
 @param toValueAngle toValueAngle description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_rotationWithDuration:(CFTimeInterval)duration
                                                   beginTime:(CFTimeInterval)beginTime
                                                toValueAngle:(CGFloat)toValueAngle
                                                 repeatCount:(CGFloat)repeatCount
                                                autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformRotation beginTime:beginTime fromValue:[NSValue new] toValue:@(toValueAngle) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：旋转 X
 
 @param duration duration description
 @param beginTime beginTime description
 @param toValueAngle toValueAngle description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_rotationXWithDuration:(CFTimeInterval)duration
                                                    beginTime:(CFTimeInterval)beginTime
                                                 toValueAngle:(CGFloat)toValueAngle
                                                  repeatCount:(CGFloat)repeatCount
                                                 autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformRotationX beginTime:beginTime fromValue:[NSValue new] toValue:@(toValueAngle) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：旋转 Y
 
 @param duration duration description
 @param beginTime beginTime description
 @param toValueAngle toValueAngle description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_rotationYWithDuration:(CFTimeInterval)duration
                                                    beginTime:(CFTimeInterval)beginTime
                                                 toValueAngle:(CGFloat)toValueAngle
                                                  repeatCount:(CGFloat)repeatCount
                                                 autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformRotationY beginTime:beginTime fromValue:[NSValue new] toValue:@(toValueAngle) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：旋转 Z

 @param duration duration description
 @param beginTime beginTime description
 @param toValueAngle toValueAngle description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_rotationZWithDuration:(CFTimeInterval)duration
                                                    beginTime:(CFTimeInterval)beginTime
                                                 toValueAngle:(CGFloat)toValueAngle
                                                  repeatCount:(CGFloat)repeatCount
                                                 autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_TransformRotationZ beginTime:beginTime fromValue:[NSValue new] toValue:@(toValueAngle) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：position

 @param duration duration description
 @param beginTime beginTime description
 @param fromValuePosition fromValuePosition description
 @param toValuePosition toValuePosition description
 @param repeatCount repeatCount description
 @param autoreverses autoreverses description
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_positionWithDuration:(CFTimeInterval)duration
                                                   beginTime:(CFTimeInterval)beginTime
                                           fromValuePosition:(CGPoint)fromValuePosition
                                             toValuePosition:(CGPoint)toValuePosition
                                                 repeatCount:(CGFloat)repeatCount
                                                autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_Position beginTime:beginTime fromValue:[NSValue valueWithCGPoint:fromValuePosition] toValue:[NSValue valueWithCGPoint:toValuePosition] duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：position X
 
 @param duration duration description
 @param beginTime beginTime description
 @param fromValuePositionX fromValuePositionX description
 @param toValuePositionX toValuePositionX description
 @param repeatCount repeatCount description
 @param autoreverses autoreverses description
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_positionXWithDuration:(CFTimeInterval)duration
                                                    beginTime:(CFTimeInterval)beginTime
                                           fromValuePositionX:(CGFloat)fromValuePositionX
                                             toValuePositionX:(CGFloat)toValuePositionX
                                                  repeatCount:(CGFloat)repeatCount
                                                 autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_PositionX beginTime:beginTime fromValue:@(fromValuePositionX) toValue:@(toValuePositionX) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

/**
 CABasicAnimation：position Y
 
 @param duration duration description
 @param beginTime beginTime description
 @param fromValuePositionY fromValuePositionY description
 @param toValuePositionY toValuePositionY description
 @param repeatCount repeatCount description
 @param autoreverses autoreverses description
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_basicAnimation_positionYWithDuration:(CFTimeInterval)duration
                                                    beginTime:(CFTimeInterval)beginTime
                                           fromValuePositionY:(CGFloat)fromValuePositionY
                                             toValuePositionY:(CGFloat)toValuePositionY
                                                  repeatCount:(CGFloat)repeatCount
                                                 autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:kBAKit_animationKeyPath_PositionY beginTime:beginTime fromValue:@(fromValuePositionY) toValue:@(toValuePositionY) duration:duration repeatCount:repeatCount autoreverses:autoreverses];
    
    return animation;
}

#pragma mark - 重复型动画
/**
 CABasicAnimation：重复型动画

 @param keyPath keyPath description
 @param beginTime beginTime description
 @param toValue toValue description
 @param duration duration description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_baseAnimationWithKeyPath:(NSString *)keyPath
                                        beginTime:(CFTimeInterval)beginTime
                                          toValue:(NSValue *)toValue
                                         duration:(NSTimeInterval)duration
                                      repeatCount:(float)repeatCount
                                     autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:keyPath beginTime:beginTime fromValue:[NSValue new] toValue:toValue duration:duration repeatCount:repeatCount autoreverses:autoreverses];

    return animation;
}

#pragma mark - 一次性动画
/**
 CABasicAnimation：一次性动画

 @param keyPath keyPath description
 @param beginTime beginTime description
 @param fromValue fromValue description
 @param toValue toValue description
 @param duration duration description
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_baseAnimationWithKeyPath:(NSString *)keyPath
                                        beginTime:(CFTimeInterval)beginTime
                                        fromValue:(id)fromValue
                                          toValue:(id)toValue
                                         duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:keyPath beginTime:beginTime fromValue:fromValue toValue:toValue duration:duration repeatCount:0 autoreverses:false];

    return animation;
}

#pragma mark - 不回弹的动画

/**
 CABasicAnimation：不回弹的动画


 @param keyPath keyPath description
 @param beginTime beginTime description
 @param fromValue fromValue description
 @param toValue toValue description
 @param duration duration description
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_baseAnimationForwardsWithKeyPath:(NSString *)keyPath
                                                beginTime:(CFTimeInterval)beginTime
                                                fromValue:(id)fromValue
                                                  toValue:(id)toValue
                                                 duration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation ba_baseAnimatioWithKeyPath:keyPath beginTime:beginTime fromValue:fromValue toValue:toValue duration:duration repeatCount:0 autoreverses:false];

    animation.fillMode = kCAFillModeForwards;
    return animation;
}

/**
 CABasicAnimation：总

 @param keyPath keyPath description
 @param fromValue fromValue description
 @param toValue toValue description
 @param beginTime beginTime description
 @param duration duration description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CABasicAnimation
 */
+ (CABasicAnimation *)ba_baseAnimatioWithKeyPath:(NSString *)keyPath
                                       beginTime:(CFTimeInterval)beginTime
                                       fromValue:(NSValue *)fromValue
                                         toValue:(NSValue *)toValue
                                        duration:(NSTimeInterval)duration
                                     repeatCount:(float)repeatCount
                                    autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = fromValue;
    animation.toValue = toValue;
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.autoreverses = autoreverses;
    animation.removedOnCompletion= false;
    animation.beginTime = beginTime;
    
    return animation;
}

#pragma mark - 组合动画
/**
 CAAnimationGroup：组合动画

 @param animations animations description
 @param duration duration description
 @param repeatCount repeatCount description
 @param removedOnCompletion removedOnCompletion description
 @return CAAnimationGroup
 */
+ (CAAnimationGroup *)ba_animationGroupAnimations:(NSArray *)animations
                                         duration:(float)duration
                                      repeatCount:(float)repeatCount
                              removedOnCompletion:(BOOL)removedOnCompletion
{
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = animations;
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.removedOnCompletion = removedOnCompletion;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

#pragma mark - 根据路径执行的位移关键帧动画
/**
 CAKeyframeAnimation：根据路径执行的位移关键帧动画

 @param beginTime beginTime description
 @param duration duration description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @param path path description
 @return CAKeyframeAnimation
 */
+ (CAKeyframeAnimation *)ba_keyframeAnimationWithBeginTime:(CFTimeInterval)beginTime
                                                  duration:(NSTimeInterval)duration
                                               repeatCount:(float)repeatCount
                                              autoreverses:(BOOL)autoreverses
                                                      path:(CGPathRef)path
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:kBAKit_animationKeyPath_Position];
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = duration;
    pathAnimation.repeatCount = repeatCount;
    pathAnimation.autoreverses = autoreverses;
    pathAnimation.path = path;
    
    return pathAnimation;
}

#pragma mark - 关键帧动画
/**
 CAKeyframeAnimation：关键帧动画

 @param keyPath keyPath description
 @param beginTime beginTime description
 @param duration duration description
 @param times times description
 @param toValues toValues description
 @param repeatCount repeatCount description
 @param autoreverses 是否自动重复
 @return CAKeyframeAnimation
 */
+ (CAKeyframeAnimation *)ba_keyFrameAnimationForwardsWithKeyPath:(NSString *)keyPath
                                                       beginTime:(CFTimeInterval)beginTime
                                                        duration:(NSTimeInterval)duration
                                                           times:(NSArray<NSNumber *> *)times
                                                        toValues:(NSArray<id> *)toValues
                                                     repeatCount:(float)repeatCount
                                                    autoreverses:(BOOL)autoreverses
{
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.duration = duration;
    keyAnimation.repeatCount = repeatCount;
    keyAnimation.autoreverses = autoreverses;
    keyAnimation.keyTimes = times;
    keyAnimation.values = toValues;
    keyAnimation.beginTime = beginTime;
    keyAnimation.fillMode = kCAFillModeForwards;
    
    return keyAnimation;
}

@end
