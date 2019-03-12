
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
//                一人 我编程累 累得只想把觉睡
//                两眼 是辛酸泪 代码咋写都不对
//
//                重启是也不行 关机它也不灵
//                我狂敲键盘怒砸鼠标 异常也不停
//
//                这循环它有点绕 注释也很微妙
//                我看了半天稀里糊涂马隔壁我草
//
//                加断点 再抵坝 堆栈瞬间就爆炸
//                日志输出如雨下 看到异常就害怕
//
//                调试一夜没人陪 心想这锅该归谁
//                回想当初心后悔 不该重构这地雷
//
//                翻日志 看半天 博客看了几百篇
//                闪退还是没复现 低头又点一根烟
//
//                加着班我心烦乱 烂摊子我不想干
//                离职损失就几万 一拍桌子把工作换
//
//                离职 我不再忙 在家 我守空房
//                我闲得无聊掏出电脑 代码又写几行

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BAKit_BadgeViewPosition) {
    
    BAKit_BadgeViewPositionCenterLeft,
    BAKit_BadgeViewPositionCenterRight,
    
    BAKit_BadgeViewPositionTopLeft,
    BAKit_BadgeViewPositionTopRight,
    
    BAKit_BadgeViewPositionBottomLeft,
    BAKit_BadgeViewPositionBottomRight,
};

@interface BABadgeValueView : UIView

/**
 *  BABadgeValueView：bedge 值
 */
@property (nonatomic, strong) NSString  *ba_badgeViewBadgeValue;

/**
 *  BABadgeValueView：被附着的 view
 */
@property (nonatomic, weak)   UIView    *ba_badgeViewContentView;

/**
 *  BABadgeValueView：敏感字符增长宽度,默认值为4
 */
@property (nonatomic)  CGFloat        ba_badgeViewSensitiveTextWidth;

/**
 *  BABadgeValueView：敏感增长宽度,默认为10
 */
@property (nonatomic)  CGFloat        ba_badgeViewSensitiveWidth;

/**
 *  BABadgeValueView：固定高度,默认为20
 */
@property (nonatomic)  CGFloat        ba_badgeViewFixedHeight;

/**
 *  BABadgeValueView：位置信息，默认为 BAKit_BadgeViewPositionTopRight
 */
@property (nonatomic)  BAKit_BadgeViewPosition  ba_badgeViewPosition;

/**
 *  BABadgeValueView：字体，默认为12
 */
@property (nonatomic, strong) UIFont    *ba_badgeViewFont;

/**
 *  BABadgeValueView：字体颜色，默认为白色
 */
@property (nonatomic, strong) UIColor   *ba_badgeViewTextColor;

/**
 *  BABadgeValueView：bedge 背景颜色，默认为红色
 */
@property (nonatomic, strong) UIColor   *ba_badgeViewBackgroundColor;

/**
 *  BABadgeValueView：开始生效，无需 addSubView，只需设置好 contentView，然后 调用此方法就行了，
 */
- (void)ba_badgeViewMakeEffect;

/**
 *  BABadgeValueView：设置 BadgeValue，注意：设置 BadgeValue 务必在 ba_badgeViewMakeEffect 方法后设置才能生效
 *
 *  @param value    BadgeValue
 *  @param animated 是否执行动画
 */
- (void)ba_badgeViewSetBadgeValue:(NSString *)value animated:(BOOL)animated;

@end
