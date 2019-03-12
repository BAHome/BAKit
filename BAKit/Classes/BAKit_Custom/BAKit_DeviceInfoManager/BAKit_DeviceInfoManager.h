//
//  BAKit_DeviceInfoManager.h
//  BAKit
//
//  Created by boai on 2017/8/26.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BAKit_Singleton.h"

/**
 DeviceInfo：当前设备电池的状态

 - BAKit_BatteryInfoStateCharging: 正在充电
 - BAKit_BatteryInfoStateFull: 已充满
 - BAKit_BatteryInfoStateUnplugged: 不插电，没有充电
 - BAKit_BatteryInfoStateUnknown: 未知状态
 */
typedef NS_ENUM(NSUInteger, BAKit_BatteryInfoState) {
    BAKit_BatteryInfoStateCharging,
    BAKit_BatteryInfoStateFull,
    BAKit_BatteryInfoStateUnplugged,
    BAKit_BatteryInfoStateUnknown
};

/**
 DeviceInfo：Block 实时监测当前设备电池的状态

 @param batteryInfoState 当前设备电池的状态
 @param batteryLevelPercent 当前设备电池的电量（百分比）
 */
typedef void (^BAKit_BatteryInfoBlock)(BAKit_BatteryInfoState batteryInfoState, NSUInteger batteryLevelPercent);

#define BAKit_DeviceInfoManagerShared [BAKit_DeviceInfoManager sharedDeviceInfoManager]

@interface BAKit_DeviceInfoManager : NSObject
BAKit_SingletonH(DeviceInfoManager)

#pragma mark - 设备相关
/**
 DeviceInfo：获取当前设备 型号，例如：iPhone SE
 
 @return 当前设备 型号，例如：iPhone SE
 */
- (NSString *)ba_deviceGetDeviceModel;

/**
 DeviceInfo：获取当前设备的 用户自定义的别名，例如：博爱的 iPhone 9
 
 @return 当前设备的 用户自定义的别名，例如：博爱的 iPhone 9
 */
- (NSString *)ba_deviceGetCurrentDeviceName;

/**
 DeviceInfo：获取当前设备的 地方型号 国际化区域名称，例如：iPhone
 
 @return 获取当前设备的 地方型号 国际化区域名称，例如：iPhone
 */
- (NSString *)ba_deviceGetCurrentLocalizedModel;

/**
 DeviceInfo：获取当前设备的 系统名称，例如：iOS
 
 @return 当前设备的 系统名称，例如：iOS
 */
- (NSString *)ba_deviceGetCurrentSystemName;

/**
 DeviceInfo：获取当前设备的 系统版本号，例如：11.0
 
 @return 当前设备的 系统版本号，例如：11.0
 */
- (NSString *)ba_deviceGetCurrentSystemVersion;

/**
 DeviceInfo：获取当前设备 UUID，例如：6073****-53E1****-***A45
 
 @return 当前设备 UUID，例如：6073****-53E1****-***A45
 */
- (NSString *)ba_deviceGetUUID;

/**
 DeviceInfo：获取当前设备广告标识符，注意：ios10 更新之后一旦开启了 设置->隐私->广告->限制广告跟踪之后  获取到的 idfa 将会是一串00000，跟 mac 地址一个尿性，而且每次开启在关闭之后 相应的 idfa 也会重新生成，相当于还原了一次广告标识符。吾等屌丝搬砖者容易吗，苹果你要这么整我们。。。但凡能唯一标识手机的方法，你们全给封了，让俺们这些广告开发者怎么玩，用点私有的API你们还不给个活路，只能说一句 你挺(T)萌(M)的。
 
 @return 当前设备广告标识符
 */
- (NSString *)ba_deviceGetIDFA;

/**
 DeviceInfo：获取当前设备上次重启的时间
 
 @return 设备上次重启的时间
 */
- (NSDate *)ba_deviceGetLastSystemUptime;

#pragma mark - APP

/**
 DeviceInfo：获取当前设备的 App Name，例如：博爱微信，注意：用此方法请务必在 info.plist 中添加 DisplayName（如：$(BUNDLE_DISPLAY_NAME)）
 
 @return 当前设备的 App Name，例如：博爱微信
 */
- (NSString *)ba_deviceGetCurrentAppDisplayName;

/**
 DeviceInfo：获取当前 app 的 版本号，例如：1.0.0
 
 @return 当前 app 的 版本号，例如：1.0.0
 */
- (NSString *)ba_deviceGetCurrentAppShortVersionString;

/**
 DeviceInfo：获取当前 app 的 build 版本号，例如：99（int类型 ）
 
 @return 获取当前 app 的 build 版本号，例如：99（int类型 ）
 */
- (NSString *)ba_deviceGetCurrentAppVersion;

#pragma mark - CPU
/**
 DeviceInfo：获取当前设备 CPU 频率
 
 @return 当前设备 CPU 频率
 */
- (NSUInteger)ba_deviceGetCPUFrequency;

/**
 DeviceInfo：获取当前设备总线程频率
 
 @return 当前设备总线程频率
 */
- (NSUInteger)ba_deviceGetBusFrequency;

/**
 DeviceInfo：获取当前设备 CPU 数量
 
 @return 当前设备 CPU 数量
 */
- (NSUInteger)ba_deviceGetCPUCount;

/**
 DeviceInfo：获取当前设备 可用 CPU 数量
 
 @return 当前设备 可用 CPU 数量
 */
- (NSUInteger)ba_deviceGetCanUseCPUCount;

/**
 DeviceInfo：获取当前设备 CPU 总的使用百分比
 
 @return 当前设备 CPU 总的使用百分比
 */
- (float)ba_deviceGetCPUUsage;

/**
 DeviceInfo：获取单个 CPU 使用百分比
 
 @return 单个 CPU 使用百分比
 */
- (NSArray *)ba_deviceGetPerCPUUsage;

#pragma mark - Disk

/**
 DeviceInfo：获取当前设备 ROM 硬盘存储空间 大小，例如：128 G，返回 128
 
 @return 当前设备 ROM 硬盘存储空间 大小，例如：128 G，返回 128
 */
- (int64_t)ba_deviceGetTotalDiskSpace;

/**
 DeviceInfo：获取当前设备未使用的磁盘空间
 
 @return 当前设备未使用的磁盘空间
 */
- (int64_t)ba_deviceGetFreeDiskSpace;

/**
 DeviceInfo：获取当前设备已使用的磁盘空间
 
 @return 当前设备已使用的磁盘空间
 */
- (int64_t)ba_deviceGetUsedDiskSpace;

/**
 DeviceInfo：获取本 App 所占磁盘空间
 
 @return 本 App 所占磁盘空间
 */
- (NSString *)ba_deviceGetApplicationSize;

#pragma mark - Memory
/**
 DeviceInfo：获取当前设备总内存空间 RAM，例如：iPhone 7 内存 为 2G，返回 2
 
 @return 当前设备总内存空间 RAM，例如：iPhone 7 内存 为 2G，返回 2
 */
- (int64_t)ba_deviceGetTotalMemory;

/**
 DeviceInfo：获取当前设备活跃的内存空间
 
 @return 当前设备活跃的内存空间
 */
- (int64_t)ba_deviceGetActiveMemory;

/**
 DeviceInfo：获取当前设备不活跃的内存空间
 
 @return 当前设备不活跃的内存空间
 */
- (int64_t)ba_deviceGetInActiveMemory;

/**
 DeviceInfo：获取当前设备空闲的内存空间
 
 @return 当前设备空闲的内存空间
 */
- (int64_t)ba_deviceGetFreeMemory;

/**
 DeviceInfo：获取当前设备正在使用的内存空间
 
 @return 当前设备正在使用的内存空间
 */
- (int64_t)ba_deviceGetUsedMemory;

/**
 DeviceInfo：获取当前设备存放内核的内存空间
 
 @return 当前设备存放内核的内存空间
 */
- (int64_t)ba_deviceGetWritedMemory;

/**
 DeviceInfo：获取当前设备可释放的内存空间
 
 @return 当前设备可释放的内存空间
 */
- (int64_t)ba_deviceGetPurgableMemory;

/**
 DeviceInfo：获取当前任务所占用的内存
 
 @return 当前任务所占用的内存
 */
- (double)ba_deviceGetCurrentTaskUsedMemory;

#pragma mark - 网络相关
/**
 DeviceInfo：获取当前设备 IP 地址
 
 @return 当前设备 IP 地址
 */
- (NSString *)ba_deviceGetDeviceIPAddresses;

/**
 DeviceInfo：获取当前设备 WiFi 无线局域网 iP 地址
 
 @return 当前设备 WiFi 无线局域网 iP 地址
 */
- (NSString *)ba_deviceGetIpAddressWIFI;

/**
 DeviceInfo：获取当前设备 蜂窝网 iP 地址
 
 @return 当前设备 蜂窝网 iP 地址
 */
- (NSString *)ba_deviceGetIpAddressCellular;

/**
 DeviceInfo：域名转 IP，注意：需有网络才能进行
 
 @param domain 域名
 @return 该域名所在的 IP
 */
- (NSString *)ba_deviceInfoQueryIpWithDomain:(NSString *)domain;

///**
// DeviceInfo：通过查询网址 url，解析 html 得到 IP 地址
// 
// @param urlString 需要解析的 URL
// @return 该网址 URL 的 IP 地址
// */
//- (NSString *)ba_deviceInfoGetIpAddressWithUrlString:(NSString *)urlString;

/**
 DeviceInfo：获取手机当前连接的 WiFi 名字
 
 @return 手机当前连接的 WiFi 名字
 */
- (NSString *)ba_deviceInfoGetCuttrntConnectWifiName;

#pragma mark - 电池电量相关

/**
 DeviceInfo：当前电池电量状态
 */
@property (nonatomic, assign) BAKit_BatteryInfoState ba_batteryState;

@property(nonatomic, copy) BAKit_BatteryInfoBlock ba_batteryInfoBlock;

/**
 DeviceInfo：开始监测电池电量
 */
- (void)ba_deviceInfoBatteryStartMonitoring;

/**
 DeviceInfo：停止监测电池电量
 */
- (void)ba_deviceInfoBatteryStopMonitoring;


@end
