
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

#import <UIKit/UIKit.h>

typedef void (^BAKit_UIViewActionBlock)(UIView *view);
typedef void (^BAKit_UIViewLayoutSubViewsBlock)(UIView *view);

@interface UIView (BAKit)

/**
 UIView：给 UIView 添加点击事件
 */
@property(nonatomic, copy) BAKit_UIViewActionBlock ba_viewActionBlock;

/**
 UIView：获取 UIView LayoutSubViews 后回调
 */
@property(nonatomic, copy) BAKit_UIViewLayoutSubViewsBlock ba_viewLayoutSubViewsBlock;

/**
 UIView：快速创建 view
 
 @param frame frame
 @param backgroundColor backgroundColor
 @return view
 */
+ (UIView *)ba_viewCreatWithFrame:(CGRect)frame
                  backgroundColor:(UIColor *)backgroundColor;


- (void)ba_viewSetSystemCornerRadius:(CGFloat)cornerRadius;

/**
UIView：快速设置 view 的边框【系统方法】

@param borderColor 边框颜色
@param cornerRadius 边框角度
@param borderWidth 边框线宽度
*/
- (void)ba_viewSetSystemCornerRadius:(CGFloat)cornerRadius
                         borderColor:(UIColor *)borderColor
                         borderWidth:(CGFloat)borderWidth;

/**
 UIView：快速设置 view 的边框【自定义】
 
 @param borderColor 边框颜色
 @param cornerRadius 边框角度
 @param borderWidth 边框线宽度
 */
- (void)ba_viewSetCornerRadius:(CGFloat)cornerRadius
                   borderColor:(UIColor *)borderColor
                   borderWidth:(CGFloat)borderWidth;

/**
 UIView：删除边框
 */
- (void)ba_viewRemoveBorder;

/**
 UIView：创建阴影
 
 @param offset 偏移量
 @param opacity 透明度
 @param shadowRadius 模糊程度
 */
- (void)ba_viewSetRectShadowWithOffset:(CGSize)offset
                               opacity:(CGFloat)opacity
                          shadowRadius:(CGFloat)shadowRadius;

/**
 UIView：删除阴影
 */
- (void)ba_viewRemoveShadow;

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
                                 shadowRadius:(CGFloat)shadowRadius;

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
                                 shadowRadius:(CGFloat)shadowRadius;

/**
 *  UIView：添加子 View
 *
 *  @param array 添加子的ViewArray
 */
- (void)ba_viewAddSubViewsWithArray:(NSArray *)array;

/**
 *  UIView：移除所有 subviews
 *
 */
- (void)ba_viewRemoveAllSubviews;

/**
 *  UIView：获取当前 View 的 VC
 *
 *  @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentViewController;

/**
 *  UIView：获取当前 View 的 VC
 *
 *  @return 获取当前 View 的 VC
 */
- (UIViewController *)ba_viewGetCurrentParentController;

/*!
 *  UIView：显示警告框
 *
 *  @param title   title description
 *  @param message message description
 */
- (void)ba_viewShowAlertViewWithTitle:(NSString *)title
                              message:(NSString *)message;

/**
 UIView：创建一条线，frame、color
 
 @param frame frame description
 @param color color description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color;

/**
 UIView：创建一条线，frame、color、tag
 
 @param frame frame description
 @param color color description
 @param tag tag description
 @return UIView
 */
+ (UIView *)ba_viewAddLineViewWithFrame:(CGRect)frame
                                  color:(UIColor *)color
                                    tag:(NSInteger)tag;

/**
 UIView：给 View 添加点击音效（一般用于 button 按钮的点击音效），注意，此方法不带播放结束回调，如果需要播放结束回调，请将 .m 文件中的 C 函数（soundCompleteCallBack）回调复制到播放按钮的.m 里，在里面做相关处理即可
 
 @param filename 音乐文件名称
 @param isNeedShock 是否播放音效并震动
 */
- (void)ba_viewPlaySoundEffectWithFileName:(NSString *)filename
                               isNeedShock:(BOOL)isNeedShock;

/**
 UIView：停止播放音乐（按钮点击音效的停止）
 */
- (void)ba_viewStopAlertSound;

@end

// 渐变色

@interface UIView (WBGradient)

@property(nullable, copy) NSArray *ba_colors;

@property(nullable, copy) NSArray<NSNumber *> *ba_locations;

@property CGPoint ba_startPoint;
@property CGPoint ba_endPoint;

+ (UIView *_Nullable)ba_gradientViewWithColors:(NSArray<UIColor *> *_Nullable)colors
                                     locations:(NSArray<NSNumber *> *_Nullable)locations
                                    startPoint:(CGPoint)startPoint
                                      endPoint:(CGPoint)endPoint;

- (void)ba_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors
                                 locations:(NSArray<NSNumber *> *_Nullable)locations
                                startPoint:(CGPoint)startPoint
                                  endPoint:(CGPoint)endPoint;

- (void)ba_setGradientBackgroundWithCGColors:(NSArray<UIColor *> *_Nullable)colors
                                   locations:(NSArray<NSNumber *> *_Nullable)locations
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint;
@end
