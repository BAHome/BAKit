//
//  BAKit_LanguageSwitchManager.h
//  BAKit
//
//  Created by 孙博岩 on 2018/9/4.
//  Copyright © 2018 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define BAKit_Define_NotiName_Language_CN   @"zh-Hans"
#define BAKit_Define_NotiName_Language_EN   @"en"
#define BAKit_Define_NotiName_Language_Key  @"BAKit_Define_NotiName_Language_Key"

#define BAKit_LanguageSwitchManagerShared  [BAKit_LanguageSwitchManager sharedBAKit_LanguageSwitchManager]

typedef NS_ENUM(NSUInteger, BAKit_LanguageType) {
    BAKit_LanguageType_EN,
    BAKit_LanguageType_CN
};

@interface BAKit_LanguageSwitchManager : NSObject
BAKit_SingletonH(BAKit_LanguageSwitchManager)

@property(nonatomic, assign) BAKit_LanguageType languageType;


@end

NS_ASSUME_NONNULL_END
