//
//  NSBundle+BALanguage.m
//  yunlian_APP
//
//  Created by boai on 2018/3/27.
//  Copyright © 2018年 云联惠. All rights reserved.
//

#import "NSBundle+BALanguage.h"
#import <objc/runtime.h>

static const char _bundle = 0;

@interface BABundleEx : NSBundle

@end

@implementation BABundleEx

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end

@implementation NSBundle (BALanguage)

+ (void)ba_setLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle], [BABundleEx class]);
    });
    
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
