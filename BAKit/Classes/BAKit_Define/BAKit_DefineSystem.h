//
//  BAKit_DefineSystem.h
//  BAKit
//
//  Created by boai on 2017/9/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BAKit_DefineSystem_h
#define BAKit_DefineSystem_h

/*! 获取sharedApplication */
#define BAKit_SharedApplication    [UIApplication sharedApplication]

/*! 用safari打开URL */
#define BAKit_OpenUrl(urlStr)      [BAKit_SharedApplication openURL:[NSURL URLWithString:urlStr]]

/*! 复制文字内容 */
#define BAKit_CopyContent(content) [[UIPasteboard generalPasteboard] setString:content]


#pragma mark - iOS 版本判断

// 操作系统版本号
#define BAKit_IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

#define BAKit_isIOS8          (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f && [UIDevice currentDevice].systemVersion.floatValue < 9.0f) ? YES : NO)
#define BAKit_isIOS8_Or_Later (([UIDevice currentDevice].systemVersion.floatValue >= 8.0f) ? YES : NO)
#define BAKit_isIOS9          (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f && [UIDevice currentDevice].systemVersion.floatValue < 10.0f) ? YES : NO)
#define BAKit_isIOS9_Or_Later (([UIDevice currentDevice].systemVersion.floatValue >= 9.0f) ? YES : NO)
#define BAKit_isIOS10          (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f && [UIDevice currentDevice].systemVersion.floatValue < 11.0f) ? YES : NO)
#define BAKit_isIOS10_Or_Later (([UIDevice currentDevice].systemVersion.floatValue >= 10.0f) ? YES : NO)



#endif /* BAKit_DefineSystem_h */
