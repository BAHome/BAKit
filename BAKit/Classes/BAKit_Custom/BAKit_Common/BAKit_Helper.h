
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
 
 */ //  博爱公共工具类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAKit_Helper : NSObject

/*!
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 */
+ (void)ba_helperTelWithPhoneNumber:(NSString *)phoneNumber;

/*!
 *  跳转Safari浏览器
 *
 *  @param url 需要用Safari打开的url
 */
+ (void)ba_helperGotoSafariBrowserWithURL:(NSString *)url;

/**
 当前存在的 VisibleViewController

 @return 当前存在的 VisibleViewController
 */
+ (nullable UIViewController *)ba_helperVisibleViewController;

/**
 自定义切换 状态栏颜色，默认：UIStatusBarStyleDefault（黑色字体），注意：需要在 info.plist 文件中将 【View controller-based status bar appearance】 设置为 NO
 
 @param sure YES：UIStatusBarStyleDefault（黑色字体），NO：UIStatusBarStyleLightContent（白色字体）
 */
+ (void)ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:(BOOL)sure;

/**
 快速自定义 navi 所有设置
 
 @param barTintColor navi 背景颜色
 @param tintColor 字体颜色、返回按钮颜色
 @param font 字体
 @param fontColor 字体颜色
 @param isNeedBottomLine 是否需要底部的分割线
 @param navigationController navigationController
 */
+ (void)ba_helperSetNaviBarBarTintColor:(UIColor *__nullable)barTintColor
                              tintColor:(UIColor *__nullable)tintColor
                                   font:(UIFont *__nullable)font
                              fontColor:(UIColor *__nullable)fontColor
                       isNeedBottomLine:(BOOL)isNeedBottomLine
                   navigationController:(UINavigationController *)navigationController;

/**
 快速自定义 tabbar 所有设置

 @param selectedTintColor 选中颜色
 @param normalTintColor 非选中颜色
 @param backgroundImage 背景图片
 @param backgroundColor 背景颜色（和背景图片二选一）
 */
+ (void)ba_helperSetTabbarSelectedTintColor:(UIColor * __nullable)selectedTintColor
                            normalTintColor:(UIColor * __nullable)normalTintColor
                            backgroundImage:(UIImage * __nullable)backgroundImage
                            backgroundColor:(UIColor * __nullable)backgroundColor;

@end

@interface BAKit_Helper (NSNULL)

/*!
 *  判断字典是否为空
 *
 *  @param obj 传进来的字典
 *
 *  @return YES：为空，NO：不为空
 */
+ (BOOL)ba_helperIsNSDictionaryNULL:(id)obj;

/*!
 *  判断字符串判断是否为空
 *
 *  @param stirng 传进来的字符
 *
 *  @return YES：为空，NO：不为空
 */
+ (BOOL)ba_helperIsNSStringNULL:(NSString *)stirng;

/*!
 *  判断字符串为空和只为空格
 *
 *  @param string 传进来的字符
 *
 *  @return YES：为空，NO：不为空
 */
+ (BOOL)ba_helperIsBlankString:(NSString *)string;


@end

@interface BAKit_Helper (Location)

/*!
 *  判断是否打开定位
 *
 *  @return YES / NO
 */
+ (BOOL)ba_helperIsLocationOpen;

@end

@interface BAKit_Helper (NSArray)

/*!
*  判断数组是否包含有某个 object
*
*  @param array  需要判断的数组
*  @param object 需要判断的数组字段
*
*  @return YES / NO
*/
+ (BOOL)ba_helperIsArray:(NSArray *)array containsObject:(NSString *)object;

@end

@interface BAKit_Helper (PathExtension)

/*!
 *  判断 URL 是否是 MP4
 *
 *  @return YES / NO
 */
+ (BOOL)ba_helperURLIsMp4WithUrl:(NSString *)url;

@end

@interface BAKit_Helper (Animation)

/**
 BAKit_Helper：view 简单入场动画
 
 @param view view
 */
+ (void)ba_helperViewAnimation:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
