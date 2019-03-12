
/*!
 *  @header BAKit.h
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright  Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用 BAKit 的过程中如果出现 bug 请及时以以下任意一种方式联系我，我会及时修复 bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * BAHome : https://github.com/BAHome
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */


#import "UIFont+BAKit.h"
#import "NSMutableArray+BAKit.h"
#import <CoreText/CoreText.h>

// Feature and deployment target check
#if  ! __has_feature(objc_arc)
#error This file must be compiled with ARC.
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 40100
#error This file must be compiled with Deployment Target greater or equal to 4.1
#endif

// Activate Xcode only logging
#ifdef DEBUG
#define UIFontWDCustomLoaderDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define UIFontWDCustomLoaderDLog(...)
#endif

@implementation UIFont (STKit)

/**
 获取 iOS 系统所有字体名字

 @return NSArray
 */
+ (NSArray *)ba_fontGetAllFamilyFontNames
{
    // 返回所有已安装字体系列名称的数组
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    
    NSArray *familyNames = [UIFont familyNames];
    
    for(NSString *familyName in familyNames )
    {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames )
        {
            [temp addObject:fontName];
        }
    }
    // 排序
    NSArray *fontNameArray = [temp sortedArrayUsingSelector:@selector(compare:)];
    
    return fontNameArray;
}

#pragma mark - Added font.

+ (UIFont *)HYQiHeiWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HYQiHei-BEJF" size:size];
}

#pragma mark - System font.

+ (UIFont *)AppleSDGothicNeoThinWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:size];
}

+ (UIFont *)AvenirWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir" size:size];
}

+ (UIFont *)AvenirLightWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

+ (UIFont *)HeitiSCWithFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"Heiti SC" size:size];
}

+ (UIFont *)HelveticaNeueFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+ (UIFont *)HelveticaNeueBoldFontSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}

static CGFloat const kSizePlaceholder = 1.0f;
static NSMutableDictionary *appRegisteredCustomFonts = nil;

/**
 Check features for full font collections support
 
 @return YES if all features are supported
 */
+ (BOOL)deviceHasFullSupportForFontCollections {
    
    return (&CTFontManagerCreateFontDescriptorsFromURL != NULL); // 10.6 or 7.0
    
}

/**
 Inner method for font(s) registration from a file
 
 @param fontURL A font URL
 
 @return Registration result
 */
+ (BOOL)registerFromURL:(NSURL *)fontURL {
    
    CFErrorRef error;
    BOOL registrationResult = YES;
    
    registrationResult = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)fontURL, kCTFontManagerScopeProcess, &error);
    
    if (!registrationResult) {
        UIFontWDCustomLoaderDLog(@"Error with font registration: %@", error);
        CFRelease(error);
        return NO;
    }
    
    return YES;
}

/**
 Inner method for font registration from a graphic font.
 
 @param fontRef A CGFontRef
 
 @return Registration result
 */
+ (BOOL)registerFromCGFont:(CGFontRef)fontRef {
    
    CFErrorRef error;
    BOOL registrationResult = YES;
    
    registrationResult = CTFontManagerRegisterGraphicsFont(fontRef, &error);
    
    if (!registrationResult) {
        UIFontWDCustomLoaderDLog(@"Error with font registration: %@", error);
        CFRelease(error);
        return NO;
    }
    
    return YES;
}

+ (NSArray *)registerFontFromURL:(NSURL *)fontURL {
    // Dictionary creation
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appRegisteredCustomFonts = [NSMutableDictionary new];
    });
    
    // Result
    NSArray *fontPSNames = nil;
    
    
    // Critical section
    @synchronized(appRegisteredCustomFonts) {
        
        // Check if this library knows this url
        fontPSNames = [[appRegisteredCustomFonts objectForKey:fontURL] copy];
        
        if (fontPSNames == nil) {
            
            // Check features
            if ([UIFont deviceHasFullSupportForFontCollections]) {
                
                // Retrieve font descriptors from ttf, otf, ttc and otc files
                NSArray *fontDescriptors = (__bridge_transfer NSArray *)(CTFontManagerCreateFontDescriptorsFromURL((__bridge CFURLRef)fontURL));
                
                // Check errors
                if (fontDescriptors) {
                    
                    // Check how many fonts are already registered (or have the
                    // same name of another font)
                    NSMutableArray *verifiedFontPSNames = [NSMutableArray new];
                    
                    for (NSDictionary *fontDescriptor in fontDescriptors) {
                        NSString *fontPSName = [fontDescriptor objectForKey:@"NSFontNameAttribute"];
                        
                        if (fontPSName) {
                            if ([UIFont fontWithName:fontPSName size:kSizePlaceholder]) {
                                UIFontWDCustomLoaderDLog(@"Warning with font registration: Font '%@' already registered",fontPSName);
                            }
                            [verifiedFontPSNames addObject:fontPSName];
                        }
                    }
                    
                    fontPSNames = [NSArray arrayWithArray:verifiedFontPSNames];
                    
                    // At least one
                    if ([fontPSNames count] > 0) {
                        
                        // If registration went ok
                        if ([UIFont registerFromURL:fontURL]) {
                            // Add url to this library
                            [appRegisteredCustomFonts setObject:fontPSNames
                                                         forKey:fontURL];
                            
                        } else {
                            fontPSNames = nil;
                        }
                        
                    } else { // [fontPSNames count] <= 0
                        UIFontWDCustomLoaderDLog(@"Warning with font registration: All fonts in '%@' are already registered", fontURL);
                    }
                    
                } else { // CTFontManagerCreateFontDescriptorsFromURL fail
                    UIFontWDCustomLoaderDLog(@"Error with font registration: File '%@' is not a Font", fontURL);
                    fontPSNames = nil;
                }
            } else { // [UIFont deviceHasFullSupportForFontCollections] fail
                
                // Read data
                NSError *error;
                NSData *fontData = [NSData dataWithContentsOfURL:fontURL
                                                         options:NSDataReadingUncached
                                                           error:&error];
                
                // Check data creation
                if (fontData) {
                    
                    // Load font
                    CGDataProviderRef fontDataProvider = CGDataProviderCreateWithCFData((CFDataRef)fontData);
                    CGFontRef loadedFont = CGFontCreateWithDataProvider(fontDataProvider);
                    
                    // Check font
                    if (loadedFont != NULL) {
                        
                        // Prior to iOS7 is not easy to retrieve names from font collections
                        // But is possible to register collections
                        NSSet *singleFontValidExtensions = [NSSet setWithArray:@[@"ttf", @"otf"]];
                        
                        if ([singleFontValidExtensions containsObject:[fontURL pathExtension]]) {
                            // Read name
                            fontPSNames = @[(__bridge_transfer NSString *)(CGFontCopyPostScriptName(loadedFont))];
                            
                            // Check if registration is required
                            if ([UIFont fontWithName:fontPSNames[0] size:kSizePlaceholder] == nil) {
                                
                                // If registration went ok
                                if ([UIFont registerFromCGFont:loadedFont]) {
                                    // Add url to this library
                                    [appRegisteredCustomFonts setObject:fontPSNames
                                                                 forKey:fontURL];
                                    
                                } else {
                                    fontPSNames = nil;
                                }
                            } else {
                                UIFontWDCustomLoaderDLog(@"Warning with font registration: All fonts in '%@' are already registered", fontURL);
                            }
                            
                        } else {
                            // Is a collection
                            
                            //TODO find a way to read names
                            fontPSNames = @[];
                            
                            // Revert to url registration which allow collections
                            // If registration went ok
                            if ([UIFont registerFromURL:fontURL]) {
                                // Add url to this library
                                [appRegisteredCustomFonts setObject:fontPSNames
                                                             forKey:fontURL];
                                
                            } else {
                                fontPSNames = nil;
                            }
                        }
                        
                    } else { // CGFontCreateWithDataProvider fail
                        UIFontWDCustomLoaderDLog(@"Error with font registration: File '%@' is not a Font", fontURL);
                        fontPSNames = nil;
                    }
                    
                    // Release
                    CGFontRelease(loadedFont);
                    CGDataProviderRelease(fontDataProvider);
                } else {
                    UIFontWDCustomLoaderDLog(@"Error with font registration: URL '%@' cannot be read with error: %@", fontURL, error);
                    fontPSNames = nil;
                }
                
            }
            
        }
        
    }
    
    return fontPSNames;
}

+ (UIFont *) customFontWithURL:(NSURL *)fontURL size:(CGFloat)size {
    
    // Only single font with this method
    NSSet *singleFontValidExtensions = [NSSet setWithArray:@[@"ttf", @"otf"]];
    
    if (![singleFontValidExtensions containsObject:[fontURL pathExtension]]) {
        UIFontWDCustomLoaderDLog(@"Only ttf or otf files are supported by this method");
        return nil;
    }
    
    NSArray *fontPSNames = [UIFont registerFontFromURL:fontURL];
    
    if (fontPSNames == nil) {
        UIFontWDCustomLoaderDLog(@"Invalid Font URL: %@", fontURL);
        return nil;
    }
    if ([fontPSNames count] != 1) {
        UIFontWDCustomLoaderDLog(@"Font collections not supported by this method");
        return nil;
    }
    return [UIFont fontWithName:fontPSNames[0] size:size];
}

+ (UIFont *) customFontOfSize:(CGFloat)size withName:(NSString *)name withExtension:(NSString *)extension {
    // Get url for font resource
    NSURL *fontURL = [[[NSBundle mainBundle] URLForResource:name withExtension:extension] absoluteURL];
    
    return [UIFont customFontWithURL:fontURL size:size];
}

@end
