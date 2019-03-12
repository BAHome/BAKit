//
//  BAMobleCountryCodeManger.h
//  BBB
//
//  Created by 孙博岩 on 2019/1/23.
//  Copyright © 2019 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#warning 使用前请引入 CoreTelephony.framework 框架

NS_ASSUME_NONNULL_BEGIN

@interface BAMobleCountryCodeManger : NSObject

/**
 获取当前运营商的标识符
 
 @return 返回运营商标示符(成功返回标示符,失败返回nil)
 
 中国移动 00 02 07
 中国联通 01 06
 中国电信 03 05
 中国铁通 20
 
 */
+ (NSString *)serviceProvider;
+ (CTCarrier *)serviceCarrier;


@end

NS_ASSUME_NONNULL_END
