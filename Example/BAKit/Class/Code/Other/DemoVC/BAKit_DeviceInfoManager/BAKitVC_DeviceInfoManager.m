//
//  BAKitVC_DeviceInfoManager.m
//  BAKit
//
//  Created by boai on 2017/8/26.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_DeviceInfoManager.h"

#import "BAKit_DeviceInfoManager.h"
#import "BAKit_Color.h"

#import "BAKit_UITableView.h"
#import "BAKit_DefineCommon.h"

#import "UIView+BAAnimation.h"
#import "NSDateFormatter+BAKit.h"

@interface BAKitVC_DeviceInfoManager ()

@property(nonatomic, strong) NSArray *sectionTitleArray;
@property(nonatomic, strong) NSArray <NSArray *>*titleArray;
//@property(nonatomic, strong) NSMutableArray *contentsArray;
@property(nonatomic, strong) NSArray <NSArray *>*descTitleArray;

@property(nonatomic, strong) NSMutableArray *mutableDataArray;

@property(nonatomic, strong) NSString *currentBatteryInfoState;
@property(nonatomic, assign) NSUInteger currentBatteryLevelPercent;

@end

@implementation BAKitVC_DeviceInfoManager

- (void)ba_base_viewWillAppear
{
    [self ba_battery];
}

- (void)ba_base_viewDidDisappear
{
    // 停止监测电池电量
    [BAKit_DeviceInfoManagerShared ba_deviceInfoBatteryStopMonitoring];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ba_base_setupUI
{
    self.tableView.backgroundColor = BAKit_Color_Clear;
    self.dataArray = [self.mutableDataArray mutableCopy];
    self.tableView.ba_tableViewCellStyle = UITableViewCellStyleSubtitle;
    
    BAKit_WeakSelf
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15.0f];
        cell.detailTextLabel.textColor = BAKit_Color_Red;
        cell.backgroundColor = BAKit_Color_Clear;
    };
    
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        if (indexPath.section == self.dataArray.count-1)
        {
            [self test];
        }
    };
}

- (void)ba_battery
{
    // 开始监测电池电量
    [BAKit_DeviceInfoManagerShared ba_deviceInfoBatteryStartMonitoring];
    
    BAKit_DeviceInfoManagerShared.ba_batteryInfoBlock = ^(BAKit_BatteryInfoState batteryInfoState, NSUInteger batteryLevelPercent) {
        
        self.currentBatteryLevelPercent = batteryLevelPercent;
        switch (batteryInfoState) {
            case BAKit_BatteryInfoStateCharging:
            {
                self.currentBatteryInfoState = @"正在充电";
            }
                break;
                
            case BAKit_BatteryInfoStateFull:
            {
                self.currentBatteryInfoState = @"已充满";
            }
                break;
            case BAKit_BatteryInfoStateUnplugged:
            {
                self.currentBatteryInfoState = @"没有充电";
            }
                break;
            case BAKit_BatteryInfoStateUnknown:
            {
                self.currentBatteryInfoState = @"未知状态";
            }
                break;
                
            default:
                break;
        }
        
        [self test];
    };
}

- (void)test
{
    NSString *msg = [NSString stringWithFormat:@"当前电量：%lu%%\n当前电池状态：%@", (unsigned long)self.currentBatteryLevelPercent, self.currentBatteryInfoState];
    BAKit_ShowAlertWithMsg_ios8(msg);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
        
    BAKit_UITableViewSetSeparator(self.tableView, BAKit_Color_Cyan, UIEdgeInsetsMake(0, 0, 0, 0));
    [self.view ba_animation_createGradientWithColorArray:@[BAKit_Color_Pink_WaterPink, BAKit_Color_White] frame:self.view.bounds direction:UIViewLinearGradientDirectionVertical];
}

#pragma mark - setter / getter

- (NSArray<NSArray *> *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[
                       @[
                           @"获取当前设备 型号，例如：iPhone SE",
                           @"获取当前设备的 用户自定义的别名，例如：博爱的 iPhone 9",
                           @"获取当前设备的 地方型号 国际化区域名称，例如：iPhone",
                           @"获取当前设备的 系统名称，例如：iOS",
                           @"获取当前设备的 系统版本号，例如：11.0",
                           @"获取当前设备 UUID，例如：6073****-53E1****-***A45",
                           @"当前设备广告标识符",
                           @"获取当前设备上次重启的时间"
                           ],
                       @[
                           @"获取当前设备的 App Name，例如：博爱微信",
                           @"获取当前 app 的 版本号，例如：1.0.0",
                           @"获取当前 app 的 build 版本号，例如：99（int类型 ）"
                           ],
                       @[
                           @"当前设备 CPU 频率",
                           @"当前设备总线程频率",
                           @"当前设备 CPU 数量",
                           @"当前设备 可用 CPU 数量",
                           @"当前设备 CPU 总的使用百分比",
                           @"单个 CPU 使用百分比"
                           ],
                       @[
                           @"当前设备 RAM 内存 大小",
                           @"当前设备未使用的磁盘空间",
                           @"当前设备已使用的磁盘空间",
                           @"本 App 所占磁盘空间"
                           ],
                       @[
                           @"当前设备总内存空间",
                           @"当前设备活跃的内存空间",
                           @"当前设备不活跃的内存空间",
                           @"当前设备空闲的内存空间",
                           @"当前设备正在使用的内存空间",
                           @"当前设备存放内核的内存空间",
                           @"当前设备可释放的内存空间",
                           @"当前任务所占用的内存"
                           ],
                       @[
                           @"当前设备 IP 地址",
                           @"当前设备 WiFi 无线局域网 iP 地址",
                           @"当前设备 蜂窝网 iP 地址",
                           @"域名转 IP",
                           @"手机当前连接的 WiFi 名字"
                           ],
                       @[
                           @"当前电池电量百分比",
                           @"当前电池电量状态"
                           ]
                       ];

    }
    return _titleArray;
}

- (NSArray *)sectionTitleArray
{
    if (!_sectionTitleArray)
    {
        _sectionTitleArray = @[
                               @"设备相关",
                               @"APP",
                               @"CPU",
                               @"Disk",
                               @"Memory",
                               @"网络相关",
                               @"电池电量相关"
                               ];
    }
    return _sectionTitleArray;
}

- (NSArray<NSArray *> *)descTitleArray
{
    if (!_descTitleArray)
    {
        // 单个 CPU 运行比率
        NSArray *CPUArray = [BAKit_DeviceInfoManagerShared ba_deviceGetPerCPUUsage];
        NSMutableString *perCPUUsage = [NSMutableString string];
        
        [CPUArray enumerateObjectsUsingBlock:^(NSNumber *per, NSUInteger idx, BOOL * _Nonnull stop) {
            [perCPUUsage appendFormat:@"CPU %lu：%.2f，", (unsigned long)idx, per.floatValue];
        }];
        
        // 磁盘总空间
        int64_t totalDisk = [BAKit_DeviceInfoManagerShared ba_deviceGetTotalDiskSpace];
        NSString *totalDiskNumber = [NSString stringWithFormat:@"%.2f M = %.2f G", totalDisk/1024/1024.0, totalDisk/1024/1024/1024.0];
        
        // 磁盘可用空间
        int64_t freeDisk = [BAKit_DeviceInfoManagerShared ba_deviceGetFreeDiskSpace];
        NSString *freeDiskNumber = [NSString stringWithFormat:@"%.2f M = %.2f G", freeDisk/1024/1024.0, freeDisk/1024/1024/1024.0];
        
        // 磁盘已用空间
        int64_t usedDisk = [BAKit_DeviceInfoManagerShared ba_deviceGetUsedDiskSpace];
        NSString *usedDiskNumber = [NSString stringWithFormat:@"%.2f M = %.2f G", usedDisk/1024/1024.0, usedDisk/1024/1024/1024.0];
        
//        @"当前设备总内存空间",
        int64_t totalMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetTotalMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *totalMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", totalMemory/1024/1024.0, totalMemory/1024/1024/1024.0];
//        @"当前设备活跃的内存空间",
        int64_t activeMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetActiveMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *activeMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", activeMemory/1024/1024.0, activeMemory/1024/1024/1024.0];
//        @"当前设备不活跃的内存空间",
        int64_t inActiveMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetInActiveMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *inActiveMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", inActiveMemory/1024/1024.0, inActiveMemory/1024/1024/1024.0];
//        @"当前设备空闲的内存空间",
        int64_t freeMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetFreeMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *freeMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", freeMemory/1024/1024.0, freeMemory/1024/1024/1024.0];
//        @"当前设备正在使用的内存空间",
        int64_t usedMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetUsedMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *usedMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", usedMemory/1024/1024.0, usedMemory/1024/1024/1024.0];
//        @"当前设备存放内核的内存空间",
        int64_t writedMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetWritedMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *writedMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", writedMemory/1024/1024.0, writedMemory/1024/1024/1024.0];
//        @"当前设备可释放的内存空间",
        int64_t purgableMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetPurgableMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *purgableMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", purgableMemory/1024/1024.0, purgableMemory/1024/1024/1024.0];
//        @"当前任务所占用的内存（单位：MB）"
        int64_t currentTaskUsedMemory = [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentTaskUsedMemory];
        NSLog(@"totalMemory-->%lld", totalMemory);
        NSString *currentTaskUsedMemoryNumber = [NSString stringWithFormat:@" %.2f M = %.2f G", currentTaskUsedMemory/1024/1024.0, currentTaskUsedMemory/1024/1024/1024.0];
        
        _descTitleArray = @[
                            @[
                                [BAKit_DeviceInfoManagerShared ba_deviceGetDeviceModel],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentDeviceName],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentLocalizedModel],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentSystemName],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentSystemVersion],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetUUID],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetIDFA],
                                [[NSDateFormatter ba_setupDateFormatterWithYMDHMS] stringFromDate:[BAKit_DeviceInfoManagerShared ba_deviceGetLastSystemUptime]]
                                ],
                            @[
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentAppDisplayName],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentAppShortVersionString],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetCurrentAppVersion]
                                ],
                            @[
                                @([BAKit_DeviceInfoManagerShared ba_deviceGetCPUFrequency]),
                                @([BAKit_DeviceInfoManagerShared ba_deviceGetBusFrequency]),
                                @([BAKit_DeviceInfoManagerShared ba_deviceGetCPUCount]),
                                @([BAKit_DeviceInfoManagerShared ba_deviceGetCanUseCPUCount]),
                                @([BAKit_DeviceInfoManagerShared ba_deviceGetCPUUsage]),
                                perCPUUsage
                                ],
                            @[
                                totalDiskNumber,
                                freeDiskNumber,
                                usedDiskNumber,
                                [BAKit_DeviceInfoManagerShared ba_deviceGetApplicationSize]
                                ],
                            @[
                                totalMemoryNumber,
                                activeMemoryNumber,
                                inActiveMemoryNumber,
                                freeMemoryNumber,
                                usedMemoryNumber,
                                writedMemoryNumber,
                                purgableMemoryNumber,
                                currentTaskUsedMemoryNumber
                                ],
                            @[
                                [BAKit_DeviceInfoManagerShared ba_deviceGetDeviceIPAddresses],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetIpAddressWIFI],
                                [BAKit_DeviceInfoManagerShared ba_deviceGetIpAddressCellular],
                                [NSString stringWithFormat:@"域名：%@，转换为 iP：%@", @"www.baidu.com", [BAKit_DeviceInfoManagerShared ba_deviceInfoQueryIpWithDomain:@"www.baidu.com"]],
                                [BAKit_DeviceInfoManagerShared ba_deviceInfoGetCuttrntConnectWifiName]
                                ],
                            @[
                                @"请插拔 USB 充电线 再查看弹出的 alert ！",
//                                self.currentBatteryInfoState
                                @"请插拔 USB 充电线 再查看弹出的 alert ！"
                                ]
                            ];
    }
    
    return _descTitleArray;
}

- (NSMutableArray *)mutableDataArray
{
    if (!_mutableDataArray)
    {
        _mutableDataArray = @[].mutableCopy;
        
        for (NSInteger i = 0; i < self.sectionTitleArray.count; i ++)
        {
            BABaseListViewSectionModel *sectionModel = [BABaseListViewSectionModel new];
            sectionModel.sectionTitle = self.sectionTitleArray[i];
            NSMutableArray *cellModelArray = @[].mutableCopy;
            
            for (NSInteger j = 0; j < self.titleArray[i].count; j ++)
            {
                BABaseListViewCellModel *cellModel = [BABaseListViewCellModel new];
                
                cellModel.title = self.titleArray[i][j];
                cellModel.detailString = self.descTitleArray[i][j];
                
                [cellModelArray addObject:cellModel];
            }
            sectionModel.sectionDataArray = cellModelArray;
            [_mutableDataArray addObject:sectionModel];
            
        }
    }
    return _mutableDataArray;
}



@end
