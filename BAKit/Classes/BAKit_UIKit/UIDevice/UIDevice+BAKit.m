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

@implementation UIDevice (BAKit)

/*!
 *  强制锁定屏幕方向
 *
 *  @param orientation 屏幕方向
 */
+ (void)ba_deviceInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    // arc下
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
    {
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
- (BOOL)ba_deviceIsJailBreak
{
    if([self getYueYu])
    {
        NSLog(@"The device is jail broken!");
        return YES;
    }
    else
    {
        if([self getPathYueYu])
        {
            return YES;
        }
        else
        {
            BOOL isyueyu = [self printDYLD];
            return isyueyu;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    
    return NO;
}

// 判断是否存在文件
- (BOOL)getPathYueYu
{
    NSArray *paths = @[ @"/Applications/Cydia.app",
                        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                        @"/bin/bash",
                        @"/usr/sbin/sshd",
                        @"/etc/apt"];
    for (NSInteger i = 0; i < paths.count; i++)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:paths[i]])
        {
            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}

- (BOOL)printDYLD
{
    
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

- (BOOL)getYueYu
{
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
