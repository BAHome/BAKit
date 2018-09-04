//
//  BAKit_LanguageSwitchManager.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/4.
//  Copyright © 2018 boai. All rights reserved.
//

#import "BAKit_LanguageSwitchManager.h"
#import "NSBundle+BALanguage.h"

@implementation BAKit_LanguageSwitchManager

BAKit_SingletonM(BAKit_LanguageSwitchManager)

- (void)setLanguageType:(BAKit_LanguageType)languageType
{
    _languageType = languageType;
    
    switch (languageType) {
        case BAKit_LanguageType_CN:
        {
            [self ba_changeLanguageTo:BAKit_Define_NotiName_Language_CN];
        }
            break;
        case BAKit_LanguageType_EN:
        {
            [self ba_changeLanguageTo:BAKit_Define_NotiName_Language_EN];
        }
            break;
            
        default:
            break;
    }
}

- (void)ba_changeLanguageTo:(NSString *)language
{
    [NSBundle ba_setLanguage:language];
    
    [BAKit_UserDefaults ba_archive_setObject:language forKey:BAKit_Define_NotiName_Language_Key];
}


@end
