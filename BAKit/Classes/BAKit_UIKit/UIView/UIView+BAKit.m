
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
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
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */

#import "UIView+BAKit.h"
#import <AudioToolbox/AudioToolbox.h>

#import "BAKit_UserDefaults.h"
#import "BAKit_DefineCommon.h"
#import "UIView+BARectCorner.h"

@implementation UIView (BAKit)

/**
 UIView：快速创建 view
 
 @param frame frame
 @param backgroundColor backgroundColor
 @return view
 */
+ (UIView *)ba_viewCreatWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)backgroundColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = backgroundColor;
    
    return view;
}

/**
 UIView：快速设置 view 的边框【系统方法】

 @param color 边框颜色
 @param cornerRadius 边框角度
 @param width 边框线宽度
 */
- (void)ba_viewSetSystemBorderWithColor:(UIColor *)color
                           cornerRadius:(CGFloat)cornerRadius
                                  width:(CGFloat)width
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

/**
 UIView：快速设置 view 的边框【自定义】
 
 @param color 边框颜色
 @param cornerRadius 边框角度
 @param width 边框线宽度
 */
- (void)ba_viewSetBorderWithColor:(UIColor *)color
                     cornerRadius:(CGFloat)cornerRadius
                            width:(CGFloat)width
{
    [self ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:cornerRadius borderWidth:width borderColor:color];
}

/**
 UIView：删除边框
 */
- (void)ba_viewRemoveBorder
{
    [self ba_viewSetBorderWithColor:nil cornerRadius:0 width:0];
}

/**
 UIView：创建阴影
 
 @param offset 偏移量
 @param opacity 透明度
 @param shadowRadius 模糊程度
 */
- (void)ba_viewSetRectShadowWithOffset:(CGSize)offset
                               opacity:(CGFloat)opacity
                          shadowRadius:(CGFloat)shadowRadius
{
    [self ba_viewSetRoundShadowWithCornerRadius:0 shadowColor:nil offset:offset opacity:opacity shadowRadius:shadowRadius];
}

/**
 UIView：删除阴影
 */
- (void)ba_viewRemoveShadow
{
    [self.layer setShadowColor:[[UIColor clearColor] CGColor]];
    [self ba_viewSetRectShadowWithOffset:CGSizeMake(0.0f, 0.0f) opacity:0.0f shadowRadius:0.f];
}

/**
 UIView：创建圆角半径阴影，带半径
 
 @param cornerRadius 半径
 @param offset 偏移量
 @param opacity 透明度
 @param shadowRadius 模糊程度
 */
- (void)ba_viewSetRoundShadowWithCornerRadius:(CGFloat)cornerRadius
                                       offset:(CGSize)offset
                                      opacity:(CGFloat)opacity
                                 shadowRadius:(CGFloat)shadowRadius
{
    [self ba_viewSetRoundShadowWithCornerRadius:cornerRadius shadowColor:nil offset:offset opacity:opacity shadowRadius:shadowRadius];
}

/**
 UIView：创建圆角半径阴影，带半径、阴影颜色
 
 @param cornerRadius 半径
 @param shadowColor 阴影颜色
 @param offset 偏移量
 @param opacity 透明度
 @param shadowRadius 模糊程度
 */
- (void)ba_viewSetRoundShadowWithCornerRadius:(CGFloat)cornerRadius
                                  shadowColor:(UIColor *)shadowColor
                                       offset:(CGSize)offset
                                      opacity:(CGFloat)opacity
                                 shadowRadius:(CGFloat)shadowRadius
{
    if (!shadowColor)
    {
        shadowColor = [UIColor blackColor];
    }
    // 设置阴影的颜色
    self.layer.shadowColor = shadowColor.CGColor;
    // 设置阴影的透明度
    self.layer.shadowOpacity = opacity;
    // 设置阴影的偏移量
    self.layer.shadowOffset = offset;
    // 设置阴影的模糊程度
    self.layer.shadowRadius = shadowRadius;
    // 设置是否栅格化
    self.layer.shouldRasterize = YES;
    // 设置圆角半径
    self.layer.cornerRadius = cornerRadius;
    // 设置阴影的路径
    //    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds]
    //                                                        cornerRadius:cornerRadius] CGPath];
    // 设置边界是否遮盖
    self.layer.masksToBounds = NO;
}

/**
 *  UIView：添加子 View
 *
 *  @param array 添加的 ViewArray
 */
- (void)ba_viewAddSubViewsWithArray:(NSArray *)array
{
    if (array)
    {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addSubview:obj];
        }];
    }
    else
    {
        NSLog(@"数组 %@ 为空！", array);
    }
}

/**
 *  UIView：移除所有 subviews
 *
 */
- (void)ba_viewRemoveAllSubviews
{
    [[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

/**
 *  UIView：获取当前 View 的 VC
 *
 *  @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentViewController
{
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 *  UIView：获取当前 View 的 VC
 *
 *  @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentParentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}

/*!
 *  UIView：显示警告框
 *
 *  @param title   title description
 *  @param message message description
 */
- (void)ba_viewShowAlertViewWithTitle:(NSString *)title
                              message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil] show];
}

/**
 UIView：创建一条线，frame、color
 
 @param frame frame description
 @param color color description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color
{
    UIView *line         = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    
    return line;
}

/**
 UIView：创建一条线，frame、color、tag
 
 @param frame frame description
 @param color color description
 @param tag tag description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color
                                    tag:(NSInteger)tag
{
    UIView *line         = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    line.tag             = tag;
    
    return line;
}

/**
 UIView：给 View 添加点击音效（一般用于 button 按钮的点击音效），注意，此方法不带播放结束回调，如果需要播放结束回调，请将 .m 文件中的 C 函数（soundCompleteCallBack）回调复制到播放按钮的.m 里，在里面做相关处理即可
 
 @param filename 音乐文件名称
 @param isNeedShock 是否播放音效并震动
 */
- (void)ba_viewPlaySoundEffectWithFileName:(NSString *)filename
                               isNeedShock:(BOOL)isNeedShock
{
    // 1、判断文件名是否为空
    if (filename == nil)
    {
        return;
    }
    [self ba_viewStopAlertSound];
    
    // 1、获取音效文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    // 2、创建音效文件 URL
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    // 3、音效声音的唯一标示 soundID
    SystemSoundID soundID = 0;
    
    /**
     * inFileUrl: 音频文件 url
     * outSystemSoundID: 声音 id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    // 4、将音效加入到系统音效服务中，NSURL 需要桥接成 CFURLRef，会返回一个长整形 soundID，用来做音效的唯一标示
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 6、播放音频
    AudioServicesPlaySystemSound(soundID);
    
    if (isNeedShock)
    {
        // 7、播放音效并震动
        AudioServicesPlayAlertSound(soundID);
    }
    
    // 保存
    [BAKit_UserDefaults ba_archive_setObject:@(soundID).stringValue forKey:@"soundID"];
    
}

/**
 UIView：停止播放音乐（按钮点击音效的停止）
 */
- (void)ba_viewStopAlertSound
{
    NSString *soundIDString = [BAKit_UserDefaults ba_archive_getObjectForKey:@"soundID"];
    
    if (BAKit_stringIsBlank(soundIDString))
    {
        return;
    }
    SystemSoundID soundID = [soundIDString intValue];
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(soundID);
    AudioServicesRemoveSystemSoundCompletion(soundID);
}

#pragma mark - view 点击事件
- (void)ba_handleViewAction
{
    if (self.ba_viewActionBlock)
    {
        self.ba_viewActionBlock(self);
    }
}

#pragma mark - setter getter

- (void)setBa_viewActionBlock:(BAKit_UIViewActionBlock)ba_viewActionBlock
{
    BAKit_Objc_setObj(@selector(ba_viewActionBlock), ba_viewActionBlock);
    
    // 先判断当前是否有交互事件，如果没有的话。。。所有 gesture 的交互事件都会被添加进 gestureRecognizers 中
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        // 添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ba_handleViewAction)];
        [self addGestureRecognizer:tap];
    }
}

- (BAKit_UIViewActionBlock)ba_viewActionBlock
{
    return BAKit_Objc_getObj;
}

- (void)setBa_viewLayoutSubViewsBlock:(BAKit_UIViewLayoutSubViewsBlock)ba_viewLayoutSubViewsBlock
{
    BAKit_Objc_setObj(@selector(ba_viewLayoutSubViewsBlock), ba_viewLayoutSubViewsBlock);
}

- (BAKit_UIViewLayoutSubViewsBlock)ba_viewLayoutSubViewsBlock
{
    return BAKit_Objc_getObj;
}

+ (void)load {
    BAKit_Objc_exchangeMethodAToB(@selector(layoutSubviews), @selector(ba_layoutSubviews))
}

- (void)ba_layoutSubviews
{
    [self ba_layoutSubviews];
    !self.ba_viewLayoutSubViewsBlock ?: self.ba_viewLayoutSubViewsBlock(self);
}


@end
