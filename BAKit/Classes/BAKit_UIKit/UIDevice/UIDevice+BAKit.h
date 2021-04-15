//
//  UIDevice+BAKit.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (BAKit)

- (NSString *)platform;
- (NSString *)platformString;
- (float)iOSVersion;

- (NSUInteger)cpuFrequency;
- (NSUInteger)busFrequency;
- (NSUInteger)cpuCount;
- (NSUInteger)totalMemory;
- (NSUInteger)userMemory;

- (NSNumber *)totalDiskSpace;
- (NSNumber *)freeDiskSpace;

- (NSString *)macAddress;
- (NSString *)ipAddresses;


/*!
 *  强制锁定屏幕方向
 *
 *  @param orientation 屏幕方向
 */
+ (void)ba_deviceInterfaceOrientation:(UIInterfaceOrientation)orientation;

/**
 监测设备是否越狱

 @return YES/NO;
 */
- (BOOL)ba_deviceIsJailBreak;

@end
