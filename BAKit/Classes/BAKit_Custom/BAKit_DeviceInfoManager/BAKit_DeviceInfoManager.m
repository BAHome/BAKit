//
//  BAKit_DeviceInfoManager.m
//  BAKit
//
//  Created by boai on 2017/8/26.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKit_DeviceInfoManager.h"

// 获取当前设备型号
#import "sys/utsname.h"

// 获取手机当前 WiFi 相关信息
#import <SystemConfiguration/CaptiveNetwork.h>

// 获取mac地址
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <arpa/inet.h>

// IDFA
#import <AdSupport/AdSupport.h>

// 获取 CPU 信息
#include <mach/mach.h>

// 获取 ip
#include <ifaddrs.h>

// 域名转IP
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netdb.h>

// 磁盘
#import <sys/mount.h>

#import <objc/runtime.h>

@interface BAKit_DeviceInfoManager ()

@property (nonatomic, assign) BOOL batteryMonitoringEnabled;

/**
 DeviceInfo：设备电池总容量
 */
@property (nonatomic, assign) NSUInteger ba_batteryCapacity;

///**
// DeviceInfo：当前电池电压
// */
//@property (nonatomic, assign) CGFloat ba_batteryVoltage;

/**
 DeviceInfo：当前电池电量百分比
 */
@property (nonatomic, assign) NSUInteger ba_batteryLevelPercent;

/**
 DeviceInfo：当前电池电量容量
 */
//@property (nonatomic, assign) NSUInteger ba_batteryLevelMAH;

@end

@implementation BAKit_DeviceInfoManager
BAKit_SingletonM(DeviceInfoManager)

#pragma mark - 设备相关
/**
 DeviceInfo：获取当前设备 型号，例如：iPhone SE
 
 @return 当前设备 型号，例如：iPhone SE
 */
- (NSString *)ba_deviceGetDeviceModel
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (Cellular)";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (Cellular)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (Cellular)";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"i386Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"x86_64Simulator";
    
    
    return deviceString;
}

/**
 DeviceInfo：获取当前设备的 用户自定义的别名，例如：博爱的 iPhone 9
 
 @return 当前设备的 用户自定义的别名，例如：博爱的 iPhone 9
 */
- (NSString *)ba_deviceGetCurrentDeviceName
{
    return [UIDevice currentDevice].name;
}

/**
 DeviceInfo：获取当前设备的 地方型号 国际化区域名称，例如：iPhone
 
 @return 获取当前设备的 地方型号 国际化区域名称，例如：iPhone
 */
- (NSString *)ba_deviceGetCurrentLocalizedModel
{
    return [UIDevice currentDevice].localizedModel;
}

/**
 DeviceInfo：获取当前设备的 系统名称，例如：iOS
 
 @return 当前设备的 系统名称，例如：iOS
 */
- (NSString *)ba_deviceGetCurrentSystemName
{
    return [UIDevice currentDevice].systemName;
}

/**
 DeviceInfo：获取当前设备的 系统版本号，例如：11.0
 
 @return 当前设备的 系统版本号，例如：11.0
 */
- (NSString *)ba_deviceGetCurrentSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

/**
 DeviceInfo：获取当前设备 UUID，例如：6073****-53E1****-***A45
 
 @return 当前设备 UUID，例如：6073****-53E1****-***A45
 */
- (NSString *)ba_deviceGetUUID
{
    return [[NSUUID UUID] UUIDString];
}

/**
 DeviceInfo：获取当前设备广告标识符，注意：ios10 更新之后一旦开启了 设置->隐私->广告->限制广告跟踪之后  获取到的 idfa 将会是一串00000，跟 mac 地址一个尿性，而且每次开启在关闭之后 相应的 idfa 也会重新生成，相当于还原了一次广告标识符。吾等屌丝搬砖者容易吗，苹果你要这么整我们。。。但凡能唯一标识手机的方法，你们全给封了，让俺们这些广告开发者怎么玩，用点私有的API你们还不给个活路，只能说一句 你挺(T)萌(M)的。
 
 @return 当前设备广告标识符
 */
- (NSString *)ba_deviceGetIDFA
{
    if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled])
    {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return @"请在设置->隐私->广告->限制广告跟踪打开开关才能使用！";
}

/**
 DeviceInfo：获取当前设备上次重启的时间
 
 @return 设备上次重启的时间
 */
- (NSDate *)ba_deviceGetLastSystemUptime
{
    NSTimeInterval time = [[NSProcessInfo processInfo] systemUptime];
    return [[NSDate alloc] initWithTimeIntervalSinceNow:(0 - time)];
}

#pragma mark - APP 

/**
 DeviceInfo：获取当前设备的 App Name，例如：博爱微信，注意：用此方法请务必在 info.plist 中添加 DisplayName（如：$(BUNDLE_DISPLAY_NAME)）
 
 @return 当前设备的 App Name，例如：博爱微信
 */
- (NSString *)ba_deviceGetCurrentAppDisplayName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

/**
 DeviceInfo：获取当前 app 的 版本号，例如：1.0.0
 
 @return 当前 app 的 版本号，例如：1.0.0
 */
- (NSString *)ba_deviceGetCurrentAppShortVersionString
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/**
 DeviceInfo：获取当前 app 的 build 版本号，例如：99（int类型 ）
 
 @return 获取当前 app 的 build 版本号，例如：99（int类型 ）
 */
- (NSString *)ba_deviceGetCurrentAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

#pragma mark - CPU
/**
 DeviceInfo：获取当前设备 CPU 频率
 
 @return 当前设备 CPU 频率
 */
- (NSUInteger)ba_deviceGetCPUFrequency
{
    return [self ba_deviceInfoGetSystemInfo:HW_CPU_FREQ];
}

/**
 DeviceInfo：获取当前设备总线程频率
 
 @return 当前设备总线程频率
 */
- (NSUInteger)ba_deviceGetBusFrequency
{
    return [self ba_deviceInfoGetSystemInfo:HW_BUS_FREQ];
}

/**
 DeviceInfo：获取当前设备 CPU 数量
 
 @return 当前设备 CPU 数量
 */
- (NSUInteger)ba_deviceGetCPUCount
{
    // 两种方式获取
    return [self ba_deviceInfoGetSystemInfo:HW_NCPU];
    //    return [NSProcessInfo processInfo].activeProcessorCount;
}

/**
 DeviceInfo：获取当前设备 可用 CPU 数量
 
 @return 当前设备 可用 CPU 数量
 */
- (NSUInteger)ba_deviceGetCanUseCPUCount
{
    return [self ba_deviceInfoGetSystemInfo:HW_AVAILCPU];
}

/**
 DeviceInfo：获取当前设备 CPU 总的使用百分比
 
 @return 当前设备 CPU 总的使用百分比
 */
- (float)ba_deviceGetCPUUsage
{
    float cpu = 0;
    NSArray *cpus = [self ba_deviceInfoGetPerCPUUsage];
    if (cpus.count == 0) return -1;
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}

/**
 DeviceInfo：获取单个 CPU 使用百分比
 
 @return 单个 CPU 使用百分比
 */
- (NSArray *)ba_deviceGetPerCPUUsage
{
    return [self ba_deviceInfoGetPerCPUUsage];
}

#pragma mark - Disk

/**
 DeviceInfo：获取当前设备 ROM 硬盘存储空间 大小，例如：128 G，返回 128
 
 @return 当前设备 ROM 硬盘存储空间 大小，例如：128 G，返回 128
 */
- (int64_t)ba_deviceGetTotalDiskSpace
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
    
//    NSError *error = nil;
//    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
//    if (error) return -1;
//    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
//    if (space < 0) space = -1;
//    return space;
}

/**
 DeviceInfo：获取当前设备未使用的磁盘空间
 
 @return 当前设备未使用的磁盘空间
 */
- (int64_t)ba_deviceGetFreeDiskSpace
{
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

/**
 DeviceInfo：获取当前设备已使用的磁盘空间
 
 @return 当前设备已使用的磁盘空间
 */
- (int64_t)ba_deviceGetUsedDiskSpace
{
    int64_t totalDisk = [self ba_deviceGetTotalDiskSpace];
    int64_t freeDisk = [self ba_deviceGetFreeDiskSpace];
    if (totalDisk < 0 || freeDisk < 0) return -1;
    int64_t usedDisk = totalDisk - freeDisk;
    if (usedDisk < 0) usedDisk = -1;
    return usedDisk;
}

/**
 DeviceInfo：获取本 App 所占磁盘空间
 
 @return 本 App 所占磁盘空间
 */
- (NSString *)ba_deviceGetApplicationSize
{
    unsigned long long documentSize   =  [self ba_deviceInfoGetSizeOfFolder:[self ba_deviceInfoGetDocumentPath]];
    unsigned long long librarySize   =  [self ba_deviceInfoGetSizeOfFolder:[self ba_deviceInfoGetLibraryPath]];
    unsigned long long cacheSize =  [self ba_deviceInfoGetSizeOfFolder:[self ba_deviceInfoGetCachePath]];
    
    unsigned long long total = documentSize + librarySize + cacheSize;
    
    NSString *applicationSize = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return applicationSize;
}

#pragma mark - Memory
/**
 DeviceInfo：获取当前设备总内存空间 RAM，例如：iPhone 7 内存 为 2G，返回 2
 
 @return 当前设备总内存空间 RAM，例如：iPhone 7 内存 为 2G，返回 2
 */
- (int64_t)ba_deviceGetTotalMemory
{
    int64_t totalMemory = [[NSProcessInfo processInfo] physicalMemory];
    if (totalMemory < -1) totalMemory = -1;
    return totalMemory;
}

/**
 DeviceInfo：获取当前设备活跃的内存空间
 
 @return 当前设备活跃的内存空间
 */
- (int64_t)ba_deviceGetActiveMemory
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.active_count * page_size;
}

/**
 DeviceInfo：获取当前设备不活跃的内存空间
 
 @return 当前设备不活跃的内存空间
 */
- (int64_t)ba_deviceGetInActiveMemory
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.inactive_count * page_size;
}

/**
 DeviceInfo：获取当前设备空闲的内存空间
 
 @return 当前设备空闲的内存空间
 */
- (int64_t)ba_deviceGetFreeMemory
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.free_count * page_size;
}

/**
 DeviceInfo：获取当前设备正在使用的内存空间
 
 @return 当前设备正在使用的内存空间
 */
- (int64_t)ba_deviceGetUsedMemory
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return page_size * (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count);
}

/**
 DeviceInfo：获取当前设备存放内核的内存空间
 
 @return 当前设备存放内核的内存空间
 */
- (int64_t)ba_deviceGetWritedMemory
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.wire_count * page_size;
}

/**
 DeviceInfo：获取当前设备可释放的内存空间
 
 @return 当前设备可释放的内存空间
 */
- (int64_t)ba_deviceGetPurgableMemory
{
    mach_port_t host_port = mach_host_self();
    mach_msg_type_number_t host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t page_size;
    vm_statistics_data_t vm_stat;
    kern_return_t kern;
    
    kern = host_page_size(host_port, &page_size);
    if (kern != KERN_SUCCESS) return -1;
    kern = host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size);
    if (kern != KERN_SUCCESS) return -1;
    return vm_stat.purgeable_count * page_size;
}

/**
 DeviceInfo：获取当前任务所占用的内存

 @return 当前任务所占用的内存
 */
- (double)ba_deviceGetCurrentTaskUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)&taskInfo, &infoCount);
    
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return taskInfo.resident_size;
}

#pragma mark - 网络相关
/**
 DeviceInfo：获取当前设备 IP 地址
 
 @return 当前设备 IP 地址
 */
- (NSString *)ba_deviceGetDeviceIPAddresses
{
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

/**
 DeviceInfo：获取当前设备 WiFi 无线局域网 iP 地址
 
 @return 当前设备 WiFi 无线局域网 iP 地址
 */
- (NSString *)ba_deviceGetIpAddressWIFI
{
    return [self ba_deviceInfoGetIpAddressWithIfaName:@"en0"];
}

/**
 DeviceInfo：获取当前设备 蜂窝网 iP 地址
 
 @return 当前设备 蜂窝网 iP 地址
 */
- (NSString *)ba_deviceGetIpAddressCellular
{
    return [self ba_deviceInfoGetIpAddressWithIfaName:@"pdp_ip0"];
}

/**
 DeviceInfo：域名转 IP，注意：需有网络才能进行
 
 @param domain 域名
 @return 该域名所在的 IP
 */
- (NSString *)ba_deviceInfoQueryIpWithDomain:(NSString *)domain
{
    struct hostent *hs;
    struct sockaddr_in server;
    if ((hs = gethostbyname([domain UTF8String])) != NULL)
    {
        server.sin_addr = *((struct in_addr*)hs->h_addr_list[0]);
        return [NSString stringWithUTF8String:inet_ntoa(server.sin_addr)];
    }
    return nil;
}

///**
// DeviceInfo：通过查询网址 url，解析 html 得到 IP 地址
// 
// @param urlString 需要解析的 URL
// @return 该网址 URL 的 IP 地址
// */
//- (NSString *)ba_deviceInfoGetIpAddressWithUrlString:(NSString *)urlString
//{
//    NSError *error;
//    NSURL *ipURL = [NSURL URLWithString:urlString];
//    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:1 error:&error];
//    
//    NSRange range = [ip rangeOfString:@"<center>ÄúµÄIPÊÇ£º["];
//    NSString *str = @"<center>ÄúµÄIPÊÇ£º[";
//    if (range.location > 0 && range.location < ip.length)
//    {
//        range.location += str.length ;
//        range.length = 17;
//        ip = [ip substringWithRange:range];
//        
//        range = [ip rangeOfString:@"]"];
//        range.length = range.location;
//        range.location = 0;
//        ip = [ip substringWithRange:range];
//    }
//    
//    return ip ? ip : nil;
//}

/**
 DeviceInfo：获取手机当前连接的 WiFi 名字

 @return 手机当前连接的 WiFi 名字
 */
- (NSString *)ba_deviceInfoGetCuttrntConnectWifiName
{
    NSDictionary *dict = [self ba_deviceInfoGetSSIDInfo];
    
    return dict[@"SSID"];
}

#pragma mark - 电池电量相关

/**
 DeviceInfo：开始监测电池电量
 */
- (void)ba_deviceInfoBatteryStartMonitoring
{
    if (!self.batteryMonitoringEnabled)
    {
        self.batteryMonitoringEnabled = YES;
        UIDevice *device = [UIDevice currentDevice];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(batteryLevelUpdatedCB:)
                                                     name:UIDeviceBatteryLevelDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(batteryStatusUpdatedCB:)
                                                     name:UIDeviceBatteryStateDidChangeNotification
                                                   object:nil];
        
        [device setBatteryMonitoringEnabled:YES];
        
        // If by any chance battery value is available - update it immediately
        if ([device batteryState] != UIDeviceBatteryStateUnknown)
        {
            [self ba_deviceInfoBatteryUpdateBatteryState];
        }
    }
}

/**
 DeviceInfo：停止监测电池电量
 */
- (void)ba_deviceInfoBatteryStopMonitoring
{
    if (self.batteryMonitoringEnabled)
    {
        self.batteryMonitoringEnabled = NO;
        [[UIDevice currentDevice] setBatteryMonitoringEnabled:NO];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)batteryLevelUpdatedCB:(NSNotification *)notification
{
    [self ba_deviceInfoBatteryUpdateBatteryState];
}

- (void)batteryStatusUpdatedCB:(NSNotification *)notification
{
    [self ba_deviceInfoBatteryUpdateBatteryState];
}

- (void)ba_deviceInfoBatteryUpdateBatteryState
{
//    float batteryMultiplier = [[UIDevice currentDevice] batteryLevel];
    float batteryMultiplier = [self ba_deviceInfoGetCurrentBatteryLevel];
    self.ba_batteryLevelPercent = batteryMultiplier;
//    self.ba_batteryLevelMAH =  self.ba_batteryCapacity * batteryMultiplier;
    
    switch ([[UIDevice currentDevice] batteryState]) {
        case UIDeviceBatteryStateCharging:
        {
            // UIDeviceBatteryStateFull seems to be overwritten by UIDeviceBatteryStateCharging
            // when charging therefore it's more reliable if we check the battery level here
            // explicitly.
            if (self.ba_batteryLevelPercent == 100)
            {
                self.ba_batteryState = BAKit_BatteryInfoStateFull;
            }
            else
            {
                self.ba_batteryState = BAKit_BatteryInfoStateCharging;
            }
            
            break;
        }
        case UIDeviceBatteryStateFull:
        {
            self.ba_batteryState = BAKit_BatteryInfoStateFull;
            
            break;
        }
        case UIDeviceBatteryStateUnplugged:
        {
            self.ba_batteryState = BAKit_BatteryInfoStateUnplugged;
            
            break;
        }
        case UIDeviceBatteryStateUnknown:
        {
            self.ba_batteryState = BAKit_BatteryInfoStateUnknown;
            
            break;
        }
            
        default:
            break;
    }
    
    if (self.ba_batteryInfoBlock)
    {
        self.ba_batteryInfoBlock(self.ba_batteryState, self.ba_batteryLevelPercent);
    }
}

#pragma mark - Private Method
- (NSUInteger)ba_deviceInfoGetSystemInfo:(uint)typeSpecifier
{
    size_t size = sizeof(int);
    int result;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &result, &size, NULL, 0);
    return (NSUInteger)result;
}

- (NSArray *)ba_deviceInfoGetPerCPUUsage
{
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = { CTL_HW, HW_NCPU };
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    if (_status)
        _numCPUs = 1;
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = (
                          (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                          );
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

- (NSString *)ba_deviceInfoGetDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)ba_deviceInfoGetLibraryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (NSString *)ba_deviceInfoGetCachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *basePath = [paths firstObject];
    return basePath;
}

- (unsigned long long)ba_deviceInfoGetSizeOfFolder:(NSString *)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    unsigned long long folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] intValue];
    }
    return folderSize;
}

- (NSString *)ba_deviceInfoGetIpAddressWithIfaName:(NSString *)name
{
    if (name.length == 0) return nil;
    NSString *address = nil;
    struct ifaddrs *addrs = NULL;
    if (getifaddrs(&addrs) == 0) {
        struct ifaddrs *addr = addrs;
        while (addr) {
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                sa_family_t family = addr->ifa_addr->sa_family;
                switch (family) {
                    case AF_INET: { // IPv4
                        char str[INET_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    } break;
                        
                    case AF_INET6: { // IPv6
                        char str[INET6_ADDRSTRLEN] = {0};
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        if (strlen(str) > 0) {
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        
                    default: break;
                }
                if (address) break;
            }
            addr = addr->ifa_next;
        }
    }
    freeifaddrs(addrs);
    return address ? address : @"该设备不存在该ip地址";
}

- (NSDictionary *)ba_deviceInfoGetSSIDInfo
{
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    NSDictionary *SSIDInfoDict = nil;
    
    for (NSString *ifnam in ifs)
    {
        SSIDInfoDict = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (SSIDInfoDict && [SSIDInfoDict count])
        {
            break;
        }
    }
    
    return SSIDInfoDict;
}

- (int)ba_deviceInfoGetCurrentBatteryLevel
{
    UIApplication *app = [UIApplication sharedApplication];
    if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
        Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
        id status  = object_getIvar(app, ivar);
        for (id aview in [status subviews]) {
            int batteryLevel = 0;
            for (id bview in [aview subviews]) {
                if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0)
                {
                    
                    Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
                    if(ivar)
                    {
                        batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
                        //这种方式也可以
                        /*ptrdiff_t offset = ivar_getOffset(ivar);
                         unsigned char *stuffBytes = (unsigned char *)(__bridge void *)bview;
                         batteryLevel = * ((int *)(stuffBytes + offset));*/
                        NSLog(@"电池电量:%d",batteryLevel);
                        if (batteryLevel > 0 && batteryLevel <= 100) {
                            return batteryLevel;
                            
                        } else {
                            return 0;
                        }
                    }
                    
                }
                
            }
        }
    }
    
    return 0;
}

@end
