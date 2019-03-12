
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import <UIKit/UIKit.h>

// 源码：https://github.com/rFlex/SCViewShaker

#define kDefaultShakeOptions  (SCShakeOptionsDirectionHorizontal | SCShakeOptionsForceInterpolationExpDown | SCShakeOptionsAtEndComplete)
#define kDefaultShakeForce    (0.075)
#define kDefaultShakeDuration (0.5)
#define kDefaultShakeIterationDuration (0.03)

typedef enum : NSUInteger {
    
    SCShakeOptionsDirectionRotate                = 0,
    SCShakeOptionsDirectionHorizontal            = 1,
    SCShakeOptionsDirectionVertical              = 2,
    SCShakeOptionsDirectionHorizontalAndVertical = 3,
    SCShakeOptionsForceInterpolationNone         = 4,
    SCShakeOptionsForceInterpolationLinearUp     = 8,
    SCShakeOptionsForceInterpolationLinearDown   = 16,
    SCShakeOptionsForceInterpolationExpUp        = 32,
    SCShakeOptionsForceInterpolationExpDown      = 64,
    SCShakeOptionsForceInterpolationRandom       = 128,
    SCShakeOptionsAtEndRestart                   = 256,
    SCShakeOptionsAtEndComplete                  = 512,
    SCShakeOptionsAtEndContinue                  = 1024,
    SCShakeOptionsAutoreverse                    = 2048
    
} SCShakeOptions;

typedef void(^ShakeCompletionHandler)();

/** BAKit_ShakeDirection
 *
 * NS_ENUM that specifies the direction of the shake
 */
typedef NS_ENUM(NSInteger, BAKit_ShakeDirection) {
    /** Shake left and right */
    BAKit_ShakeDirectionHorizontal,
    /** Shake up and down */
    BAKit_ShakeDirectionVertical
};

/**
 * @name UIView+Shake
 * A UITextField category that add the ability to shake the component
 */
@interface UIView (BAShake)

/** Shake the UITextField
 *
 * Shake the text field with default values
 */
- (void)ba_shake;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 */
- (void)ba_shake:(int)times withDelta:(CGFloat)delta;

/** Shake the UITextField
 *
 * Shake the text field a given number of times
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)ba_shake:(int)times withDelta:(CGFloat)delta
      completion:(nullable void (^)(void))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 */
- (void)ba_shake:(int)times withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)ba_shake:(int)times withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval
      completion:(nullable void (^)(void))handler;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 */
- (void)ba_shake:(int)times withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval
  shakeDirection:(BAKit_ShakeDirection)shakeDirection;

/** Shake the UITextField at a custom speed
 *
 * Shake the text field a given number of times with a given speed
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param shakeDirection of the shake
 * @param handler A block object to be executed when the shake sequence ends
 */
- (void)ba_shake:(int)times
       withDelta:(CGFloat)delta
           speed:(NSTimeInterval)interval
  shakeDirection:(BAKit_ShakeDirection)shakeDirection
      completion:(nullable void (^)(void))handler;

/**
 *  Returns whether the view is currently shaking or not.
 */
@property (readonly, nonatomic) BOOL isShaking;

/**
 *  Shake the view using the default options. The view will be shaken for a short amount of time.
 */
- (void)shake;

/*
 Shake the view using the specified options.
 |shakeOptions| is an enum of options that can be activated by using the OR operator (like SCShakeOptionsDirectionRotate | SCShakeOptionsForceInterpolationNone).
 
 |force| is the coefficient of force to apply on each shake iteration (typically between 0 and 1 even though nothing prevents you for setting a higher value if you want).
 
 |duration| is the total duration of the shaking motion. This may be ignored depending of the options you set.
 iterationDuration is how long each shake iteration will last. You may want to set a very low value (like 0.02) if you want a proper shake effect.
 
 |completionHandler|, if not null, is the block that will be invoked when the shake finishes.
 */
- (void)shakeWithOptions:(SCShakeOptions)shakeOptions
                   force:(CGFloat)force duration:(CGFloat)duration
       iterationDuration:(CGFloat)iterationDuration
       completionHandler:(ShakeCompletionHandler _Nullable )completionHandler;

/**
 *  End the current shaking action, if any
 */
- (void)endShake;

@end
