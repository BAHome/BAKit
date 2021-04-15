//
//  UIDevice+BAKit.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/2/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UIDevice+BAKit.h"

// 监测是否越狱
#import <mach-o/loader.h>
#import <mach-o/dyld.h>
#import <mach-o/arch.h>
#import <objc/runtime.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <sys/utsname.h>
#import <SystemConfiguration/CaptiveNetwork.h>
// 下面是获取IP需要的头文件
#import <sys/ioctl.h>
#include <ifaddrs.h>
#import <arpa/inet.h>

@implementation UIDevice (BAKit)

#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier {
    size_t size;
    sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    
    char *answer = malloc(size);
    sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
    
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];

    free(answer);
    return results;
}

- (NSString *)platform {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    return deviceString;
}

#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier {
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}

- (NSUInteger) cpuFrequency {
    return [self getSysInfo:HW_CPU_FREQ];
}

- (NSUInteger) busFrequency {
    return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) cpuCount {
    return [self getSysInfo:HW_NCPU];
}

- (NSUInteger) totalMemory {
    return [self getSysInfo:HW_PHYSMEM];
}

- (NSUInteger) userMemory {
    return [self getSysInfo:HW_USERMEM];
}

- (NSUInteger) maxSocketBufferSize {
    return [self getSysInfo:KIPC_MAXSOCKBUF];
}

/*
 extern NSString *NSFileSystemSize;
 extern NSString *NSFileSystemFreeSize;
 extern NSString *NSFileSystemNodes;
 extern NSString *NSFileSystemFreeNodes;
 extern NSString *NSFileSystemNumber;
*/

- (NSNumber *) totalDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

- (NSNumber *) freeDiskSpace {
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

- (NSString *)platformString{
    
    NSString *platform = [self platform];
    
    if([platform rangeOfString:@"iPhone"].location != NSNotFound){
        return [self iPhonePlatform:platform];
    }
    if([platform rangeOfString:@"iPad"].location != NSNotFound){
        return [self iPadPlatform:platform];
    }
    if([platform rangeOfString:@"iPod"].location != NSNotFound){
        return [self iPodPlatform:platform];
    }
    
    if ([platform isEqualToString:@"i386"]) {
        return @"Simulator";
    }
    if ([platform isEqualToString:@"x86_64"]) {
        return @"Simulator";
    }
    return platform;
}

- (NSString *)iPhonePlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
    if ([platform isEqualToString:@"iPhone10,1"])  return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])  return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])  return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])  return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])  return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])  return @"iPhone X";
    //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
    if ([platform isEqualToString:@"iPhone11,8"])  return  @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"])  return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])  return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])  return @"iPhone XS Max";
    //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
    if ([platform isEqualToString:@"iPhone12,1"])  return  @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"])  return  @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"])  return  @"iPhone 11 Pro Max";
    
    return platform;
}

- (NSString *)iPadPlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad";
    if ([platform isEqualToString:@"iPad1,2"])   return @"iPad 3G";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2 (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2";
    if ([platform isEqualToString:@"iPad4,7"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])   return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])   return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])   return @"iPad Mini 4 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])   return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"])   return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])   return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])   return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])   return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,11"])  return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])  return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])   return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])   return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])   return @"iPad Pro 10.5 inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])   return @"iPad Pro 10.5 inch (Cellular)";
    if ([platform isEqualToString:@"iPad7,5"])   return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad7,6"])   return @"iPad (6th generation)";
    if ([platform isEqualToString:@"iPad8,1"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,2"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,3"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,4"])   return @"iPad Pro (11-inch)";
    if ([platform isEqualToString:@"iPad8,5"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,6"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,7"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    if ([platform isEqualToString:@"iPad8,8"])   return @"iPad Pro (12.9-inch) (3rd generation)";
    //2019年3月发布:
    if ([platform isEqualToString:@"iPad11,1"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,2"])   return @"iPad mini (5th generation)";
    if ([platform isEqualToString:@"iPad11,3"])   return @"iPad Air (3rd generation)";
    if ([platform isEqualToString:@"iPad11,4"])   return @"iPad Air (3rd generation)";

    return platform;
}

- (NSString *)iPodPlatform:(NSString *)platform{
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch (5th generation)";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod touch (6th generation)";
    //2019年5月发布，更新三种机型：iPod touch (7th generation)
    if ([platform isEqualToString:@"iPod9,1"])      return @"iPod touch (7th generation)";

    return @"Unknown iPod";
}

- (float)iOSVersion{
    return [[self systemVersion] floatValue];
}

#pragma mark MAC addy
- (NSString *)macAddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Error: Memory allocation error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2\n");
        free(buf); // Thanks, Remy "Psy" Demerest
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];

    free(buf);
    return outstring;
}

- (NSString *)ipAddresses{
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for(ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if(ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if(ifr->ifr_addr.sa_family != AF_INET) continue;
            if((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if(strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for(int i=0; i < ips.count; i++) {
        if(ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

/*!
 *  强制锁定屏幕方向
 *
 *  @param orientation 屏幕方向
 */
+ (void)ba_deviceInterfaceOrientation:(UIInterfaceOrientation)orientation {
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/**
 监测设备是否越狱
 
 @return YES/NO;
 */
- (BOOL)ba_deviceIsJailBreak {
    if([self getYueYu]) {
        NSLog(@"The device is jail broken!");
        return YES;
    } else {
        if([self getPathYueYu]) {
            return YES;
        } else {
            BOOL isyueyu = [self printDYLD];
            return isyueyu;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    
    return NO;
}

// 判断是否存在文件
- (BOOL)getPathYueYu {
    NSArray *paths = @[ @"/Applications/Cydia.app",
                        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                        @"/bin/bash",
                        @"/usr/sbin/sshd",
                        @"/etc/apt"];
    for (NSInteger i = 0; i < paths.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:paths[i]]) {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

- (BOOL)printDYLD {
    
    //Get count of all currently loaded DYLD
    uint32_t count = _dyld_image_count();
    //安装NZT插件后会把原有的越狱文件名称统一修改成在/usr/lib/目录下的libSystem.B.dylib
    NSString *jtpath=@"/usr/lib/libSystem.B.dylib";
    
    uint32_t countyueyu=0;
    
    for(uint32_t i = 0; i < count; i++) {
        //Name of image (includes full path)
        const char *dyld = _dyld_get_image_name(i);
        
        //Get name of file
        int slength = strlen(dyld);
        
        int j;
        for(j = slength - 1; j>= 0; --j)
            if(dyld[j] == '/') break;
        
        NSString *name = [[NSString alloc] initWithUTF8String:_dyld_get_image_name(i)];
        if([name compare:jtpath] == NSOrderedSame) {
            countyueyu++;
        }
        if([name containsString:@"/Library/MobileSubstrate"]) {
            return YES;
        }
    }
    if ( countyueyu > 2 ) return YES;
    return NO;
    printf("\n");
}

- (BOOL)getYueYu {
    NSMutableArray *proState = [NSMutableArray array];
    
    //获取用户手机已安装app
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    
    SEL mydefault = NSSelectorFromString(@"defaultWorkspace");
    
    NSObject* workspace =[LSApplicationWorkspace_class performSelector:mydefault];
    
    SEL myappinfoinstall =NSSelectorFromString(@"allApplications");
    
    NSString *appinfostring= [NSString stringWithFormat:@"%@",[workspace performSelector:myappinfoinstall]];
    
    NSLog(@"----foo89789-----%@",appinfostring);
    
    appinfostring =[appinfostring stringByReplacingOccurrencesOfString:@"<" withString:@""];
    appinfostring =[appinfostring stringByReplacingOccurrencesOfString:@">" withString:@""];
    appinfostring =[appinfostring stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    appinfostring =[appinfostring stringByReplacingOccurrencesOfString:@"(" withString:@""];
    appinfostring =[appinfostring stringByReplacingOccurrencesOfString:@")" withString:@""];
    NSLog(@"----foo0000-----:%@",appinfostring);
    NSArray* foo = [appinfostring componentsSeparatedByString:@","];
    NSLog(@"----foo-----");
    BOOL isyueyu          = NO;
    NSString *cydia       = @"com.saurik.Cydia";
    NSString *chudong     = @"com.touchsprite.ios";
    NSString *nzt         = @"NZT";
    for (NSString *dic in foo) {
        NSLog(@"----foo222-----");
        NSString * childString = [NSString stringWithFormat:@"%@",dic ];
        // NSLog(@"----foo222-----%@",childstring);
        childString  = [childString stringByReplacingOccurrencesOfString:@" " withString:@"&"];
        //childstring =[childstring stringByReplacingOccurrencesOfString:@"-" withString:@"."];
        NSLog(@"----foo222-----%@",childString);
        NSArray* foo2 = [childString componentsSeparatedByString:@"&"];
        NSString *appname;
        @try {
            appname = [NSString stringWithFormat:@"%@",[foo2 objectAtIndex: 6]];
        }
        @catch (NSException *exception) {
            appname = [NSString stringWithFormat:@"%@",[foo2 objectAtIndex: 5]];
        }
        if([appname compare:cydia] == NSOrderedSame) {
            isyueyu = YES;
            break;
        }
        if([appname compare:chudong] == NSOrderedSame) {
            isyueyu = YES;
            break;
        }
        if([appname compare:nzt]==NSOrderedSame) {
            isyueyu = YES;
            break;
        }
        
        // NSLog(@"----foo222yyyy-----%@",appname);
        NSString *msg = [NSString stringWithFormat:@"{\"name\":\"%@\",\"index\":\"%@\"}",appname, @""];
        [proState addObject:msg];
        NSLog(@"----foo3333-----");
    }
    return isyueyu;
}

@end
