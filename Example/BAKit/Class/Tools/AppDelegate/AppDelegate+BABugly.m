//
//  AppDelegate+BABugly.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/1/31.
//  Copyright © 2019 boai. All rights reserved.
//

#import "AppDelegate+BABugly.h"
#import "AvoidCrash.h"

static NSString *Bugly_ErrorName_AvoidCrash = @"AvoidCrash拦截的异常";

@implementation AppDelegate (BABugly)

- (void)initBugly {
//#if DEBUG
//    return;
//#endif
    
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.blockMonitorEnable = YES;
    config.blockMonitorTimeout = 5;
    config.consolelogEnable = YES;
    config.delegate = self;
    config.unexpectedTerminatingDetectionEnable = YES;
    config.viewControllerTrackingEnable = YES;
    config.reportLogLevel = BuglyLogLevelWarn;
    config.deviceIdentifier = [BAKit_DeviceInfoManager.shared ba_deviceGetUUID];
    config.channel = @"dev";
    
//#if DEBUG
//    config.debugMode = YES;
//#endif
    
    [Bugly startWithAppId:BADefine_APPKey_Bugly_AppID
//#if DEBUG
        developmentDevice:YES
//#endif
                   config:config];
    
    [Bugly setUserIdentifier:[BAKit_DeviceInfoManager.shared ba_deviceGetUUID]];
    
    [self initAvoidCrash];
}

#pragma mark - AvoidCrash

- (void)initAvoidCrash {
    [AvoidCrash makeAllEffective];
    NSArray *noneSelClassStrings = @[
                                     @"NSString",
                                     @"NSNull",
                                     @"NSNumber",
                                     @"NSDictionary",
                                     @"NSArray",
                                     ];
    [AvoidCrash setupNoneSelClassStringsArr:noneSelClassStrings];
    
    NSArray *noneSelClassPrefix = @[
                                    @"YZ"
                                    ];
    [AvoidCrash setupNoneSelClassStringPrefixsArr:noneSelClassPrefix];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    NSDictionary *info = note.userInfo;
    NSString *errorReason = [NSString stringWithFormat:@"【ErrorReason】%@========【ErrorPlace】%@========【DefaultToDo】%@========【ErrorName】%@",
                             info[@"errorReason"],
                             info[@"errorPlace"],
                             info[@"defaultToDo"],
                             info[@"errorName"]];
    NSArray *callStack = info[@"callStackSymbols"];
    // 附加信息
    NSString *versionInfo = BADefine_APPVersion_VersionBuildString;
//    NSString *userInfo = [YZAuthModel fetchAccount];
//    NSString *log = [[YZLogger shared] getLatestLoggerContent];
    NSMutableString *str = [@"" mutableCopy];
    [str appendFormat:@"VersionInfo:\n%@\n\n", versionInfo];
//    [str appendFormat:@"UserInfo:\n%@\n\n", userInfo];
//    [str appendFormat:@"Log:\n%@", log];
    NSDictionary *extraInfo = @{
                                @"extraInfo\n\n": str
                                };
    [Bugly reportExceptionWithCategory:3 name:Bugly_ErrorName_AvoidCrash reason:errorReason callStack:callStack extraInfo:extraInfo terminateApp:NO];
    
    // 上传服务
//    [YZBehaviorLoggerFileUploadManager autoUploadLog];
}

#pragma mark - BuglyDelegate
- (NSString *)attachmentForException:(NSException *)exception {
    NSMutableString *str = [@"" mutableCopy];
    NSString *versionInfo = BADefine_APPVersion_VersionBuildString;
//    NSString *userInfo = [YZAuthModel fetchAccount];
//    NSString *log = [[YZLogger shared] getLatestLoggerContent];
    
    [str appendFormat:@"VersionInfo: %@\n\n\n", versionInfo];
//    [str appendFormat:@"UserInfo: %@\n\n\n", userInfo];
//    [str appendFormat:@"Log: %@", log];
    [str appendFormat:@"Exception: %@\n\n\n", exception.userInfo];
    return str;
}

@end
