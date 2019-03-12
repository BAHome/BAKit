
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
//  源码：https://github.com/jkpang/PPBadgeView

#import <UIKit/UIKit.h>

@class BABadgeLabel;
@interface UIBarButtonItem (BABadgeView)

/**
 添加带文本内容的Badge, 默认右上角, 红色, 18pts
 
 Add Badge with text content, the default upper right corner, red backgroundColor, 18pts
 */
- (void)ba_addBadgeWithText:(NSString *)text;

/**
 添加带数字的Badge, 默认右上角,红色,18pts
 
 Add the Badge with numbers, the default upper right corner, red backgroundColor, 18pts
 */
- (void)ba_addBadgeWithNumber:(NSInteger)number;

/**
 添加带颜色的小圆点, 默认右上角, 红色, 8pts
 
 Add small dots with color, the default upper right corner, red backgroundColor, 8pts
 */
- (void)ba_addDotWithColor:(UIColor *)color;

/**
 设置Badge的高度,因为Badge宽度是动态可变的,通过改变Badge高度,其宽度也按比例变化,方便布局
 
 (注意: 此方法需要将Badge添加到控件上后再调用!!!)
 
 Set the height of Badge, because the Badge width is dynamically and  variable.
 By changing the Badge height in proportion to facilitate the layout.
 
 (Note: this method needs to add Badge to the controls and then use it !!!)
 
 @param points 高度大小
 */
- (void)ba_setBadgeHeightPoints:(CGFloat)points;

/**
 设置Badge的偏移量, Badge中心点默认为其父视图的右上角
 
 Set Badge offset, Badge center point defaults to the top right corner of its parent view
 
 @param x X轴偏移量 (x<0: 左移, x>0: 右移) axis offset (x <0: left, x> 0: right)
 @param y Y轴偏移量 (y<0: 上移, y>0: 下移) axis offset ( Y <0: up, y> 0: down)
 */
- (void)ba_moveBadgeWithX:(CGFloat)x Y:(CGFloat)y;

/**
 设置Bage的属性
 
 Set properties for Badge
 */
- (void)ba_setBadgeLabelAttributes:(void(^)(BABadgeLabel *badgeLabel))attributes;

/// 显示Badge
- (void)ba_showBadge;

/// 隐藏Badge
- (void)ba_hiddenBadge;

#pragma mark - 数字增加/减少, 注意:以下方法只适用于Badge内容为纯数字的情况
/// Digital increase /decrease, note: the following method applies only to cases where the Badge content is purely numeric
- (void)ba_increase;
- (void)ba_increaseBy:(NSInteger)number;
- (void)ba_decrease;
- (void)ba_decreaseBy:(NSInteger)number;

@end
