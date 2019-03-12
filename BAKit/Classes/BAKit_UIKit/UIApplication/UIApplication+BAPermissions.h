
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
 
 */ // 源码：https://github.com/JackRostron/UIApplication-Permissions


#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>


/**
 权限类别

 - BAKit_PermissionTypeBluetoothLE: 蓝牙
 - BAKit_PermissionTypeCalendar: 日历
 - BAKit_PermissionTypeContacts: 通讯录
 - BAKit_PermissionTypeLocation: 位置
 - BAKit_PermissionTypeMicrophone: 麦克风
 - BAKit_PermissionTypeMotion: 运动
 - BAKit_PermissionTypePhotos: 照片
 - BAKit_PermissionTypeReminders: 提醒
 */
typedef NS_ENUM(NSUInteger, BAKit_PermissionType) {
    BAKit_PermissionTypeBluetoothLE,
    BAKit_PermissionTypeCalendar,
    BAKit_PermissionTypeContacts,
    BAKit_PermissionTypeLocation,
    BAKit_PermissionTypeMicrophone,
    BAKit_PermissionTypeMotion,
    BAKit_PermissionTypePhotos,
    BAKit_PermissionTypeReminders,
};

/**
 权限状态

 - BAKit_PermissionAccessDenied: 用户已拒绝
 - BAKit_PermissionAccessGranted: 用户已接受
 - BAKit_PermissionAccessRestricted: 由父母控制或系统设置阻止
 - BAKit_PermissionAccessUnknown: 不确定
 - BAKit_PermissionAccessUnsupported: 设备不支持，例如：蓝牙
 - BAKit_PermissionAccessMissingFramework: 开发人员没有将所需的框架导入项目
 */
typedef NS_ENUM(NSUInteger, BAKit_PermissionAccess) {
    BAKit_PermissionAccessDenied,
    BAKit_PermissionAccessGranted,
    BAKit_PermissionAccessRestricted,
    BAKit_PermissionAccessUnknown,
    BAKit_PermissionAccessUnsupported,
    BAKit_PermissionAccessMissingFramework
};

@interface UIApplication (BAPermissions)

// 检查服务的许可。 在不要求用户许可的情况下，无法检查麦克风或运动
/**
 BluetoothLE 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToBluetoothLE;

/**
 Calendar 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToCalendar;

/**
 Contacts 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToContacts;

/**
 Location 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToLocation;

/**
 Photos 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToPhotos;

/**
 Reminders 权限状态
 
 @return BAKit_PermissionAccess
 */
- (BAKit_PermissionAccess)ba_hasAccessToReminders;


#pragma mark - Request permissions

/**
 Calendar 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToCalendarWithSuccessBlock:(void(^)())successBlock
                                      failureBlock:(void(^)())failureBlock;

/**
 Contacts 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToContactsWithSuccessBlock:(void(^)())successBlock
                                      failureBlock:(void(^)())failureBlock;

/**
 Microphone 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToMicrophoneWithSuccessBlock:(void(^)())successBlock
                                        failureBlock:(void(^)())failureBlock;

/**
 Motion 运动权限监测
 
 @param successBlock successBlock description
 */
- (void)ba_requestAccessToMotionWithSuccessBlock:(void(^)())successBlock;

/**
 Photos 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToPhotosWithSuccessBlock:(void(^)())successBlock
                                    failureBlock:(void(^)())failureBlock;

/**
 Reminders 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToRemindersWithSuccessBlock:(void(^)())successBlock
                                       failureBlock:(void(^)())failureBlock;

#pragma mark - Needs investigating
/**
 Location 权限监测
 
 @param successBlock successBlock description
 @param failureBlock failureBlock description
 */
- (void)ba_requestAccessToLocationWithDelegate:(id<CLLocationManagerDelegate>)delegate
                                 successBlock:(void(^)())successBlock
                                 failureBlock:(void(^)())failureBlock;

@end
