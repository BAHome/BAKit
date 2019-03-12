//
//  NSString+BAImageNameUrlString.m
//  BARYTest
//
//  Created by boai on 2017/8/23.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "NSString+BAImageNameUrlString.h"
#import "pinyin.h"

#import "BAKit_DefineCommon.h"
#import "BAKit_Color.h"

@interface BAKit_DefaultPortraitView : UIView

@property(nonatomic, strong) NSString *firstCharacter;

- (void)ba_setColorAndLabelWithNickname:(NSString *)nickname
                        backgroundColor:(UIColor *)backgroundColor;

- (UIImage *)ba_imageFromView;

@end

@implementation NSString (BAImageNameUrlString)

/**
 根据 用户名 转换出 用户名首字母或者第一个汉字 的图片 URL string，类似 阿里钉钉 的默认头像

 @param userName 用户名
 @param userId 用户 id，用来识别图像是否已生成，会自动保存本地
 @param imageSize 图像大小，默认：40
 @param backgroundColor 图像的 backgroundColor，可为空，如果为空：则默认为随机颜色
 @return URL string
 */
+ (NSString *)ba_stringDefaultUserPortraitWithUserName:(NSString *)userName
                                                userId:(NSString *)userId
                                             imageSize:(CGFloat)imageSize
                                       backgroundColor:(UIColor *)backgroundColor
{
    if (imageSize == 0)
    {
        imageSize = 40;
    }
    NSString *filePath = [[self class] ba_getIconCachePath:[NSString stringWithFormat:@"user_%@.png", userId]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSURL *portraitPath = [NSURL fileURLWithPath:filePath];
        return [portraitPath absoluteString];
    }
    else
    {
        BAKit_DefaultPortraitView *defaultPortrait =
        [[BAKit_DefaultPortraitView alloc] initWithFrame:CGRectMake(0, 0, imageSize, imageSize)];
        [defaultPortrait ba_setColorAndLabelWithNickname:userName backgroundColor:backgroundColor];
        UIImage *portrait = [defaultPortrait ba_imageFromView];
        
        BOOL result = [UIImagePNGRepresentation(portrait) writeToFile:filePath
                                                           atomically:YES];
        if (result)
        {
            NSURL *portraitPath = [NSURL fileURLWithPath:filePath];
            return [portraitPath absoluteString];
        }
        else
        {
            return nil;
        }
    }
}

+ (NSString *)ba_getIconCachePath:(NSString *)fileName
{
    NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 保存文件的名称
    NSString *filePath = [cachPath stringByAppendingPathComponent:[NSString stringWithFormat:@"CachedIcons/%@", fileName]];
    
    NSString *dirPath = [cachPath stringByAppendingPathComponent:[NSString stringWithFormat:@"CachedIcons"]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:dirPath])
    {
        [fileManager createDirectoryAtPath:dirPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    return filePath;
}

/**
 *  汉字转拼音
 *
 *  @param hanZi 汉字
 *
 *  @return 转换后的拼音
 */
+ (NSString *)ba_hanZiToPinYinWithString:(NSString *)hanZi
{
    if (!hanZi)
    {
        return nil;
    }
    NSString *pinYinResult = [NSString string];
    for (int j = 0; j < hanZi.length; j++)
    {
        NSString *singlePinyinLetter = nil;
        if ([self ba_isChinese:[hanZi substringWithRange:NSMakeRange(j, 1)]])
        {
//            singlePinyinLetter = [[NSString stringWithFormat:@"%c", pinyinFirstLetter([hanZi characterAtIndex:j])] uppercaseString];
        }
        else
        {
            singlePinyinLetter = [hanZi substringWithRange:NSMakeRange(j, 1)];
        }
        
        pinYinResult = [pinYinResult stringByAppendingString:singlePinyinLetter];
    }
    return pinYinResult;
}

+ (BOOL)ba_isChinese:(NSString *)text
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:text];
}

+ (NSString *)getFirstUpperLetter:(NSString *)hanzi
{
    NSString *pinyin = [self ba_hanZiToPinYinWithString:hanzi];
    NSString *firstUpperLetter = [[pinyin substringToIndex:1] uppercaseString];
    if ([firstUpperLetter compare:@"A"] != NSOrderedAscending &&
        [firstUpperLetter compare:@"Z"] != NSOrderedDescending)
    {
        return firstUpperLetter;
    }
    else
    {
        return @"#";
    }
}

+ (BOOL)ba_isContains:(NSString *)firstString withString:(NSString *)secondString
{
    if (firstString.length == 0 || secondString.length == 0)
    {
        return NO;
    }
    NSString *twoStr = [[secondString stringByReplacingOccurrencesOfString:@" "  withString:@""] lowercaseString];
    if ([[firstString lowercaseString] containsString:[secondString lowercaseString]] || [[firstString lowercaseString] containsString:twoStr]
        || [[[self ba_hanZiToPinYinWithString:firstString] lowercaseString] containsString:twoStr]) {
        return YES;
    }
    return NO;
}

@end


@implementation BAKit_DefaultPortraitView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

- (void)ba_setColorAndLabelWithNickname:(NSString *)nickname
                        backgroundColor:(UIColor *)backgroundColor
{
    // 设置背景色
    if (BAKit_ObjectIsNull(backgroundColor))
    {
        self.backgroundColor = BAKit_Color_RandomRGB();
    }
    else
    {
        self.backgroundColor = backgroundColor;
    }
    [self ba_setLabelBackgroundColorWithNickname:nickname];
}

- (void)ba_setLabelBackgroundColorWithNickname:(NSString *)nickname
{
    // 设置字母 Label
    UILabel *firstCharacterLabel = [[UILabel alloc] init];
    
    NSString *firstLetter = nil;
    if(nickname.length > 0)
    {
        firstLetter = [nickname substringToIndex:1];
    }
    else
    {
        firstLetter = @"#";
    }
    firstCharacterLabel.text = firstLetter;
    firstCharacterLabel.textColor = [UIColor whiteColor];
    firstCharacterLabel.textAlignment = NSTextAlignmentCenter;
    firstCharacterLabel.font = [UIFont systemFontOfSize:50];
    firstCharacterLabel.frame = CGRectMake(self.frame.size.width / 2 - 30, self.frame.size.height / 2 - 30, 60, 60);
    //    firstCharacterLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:firstCharacterLabel];
}


- (UIImage *)ba_imageFromView
{
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
