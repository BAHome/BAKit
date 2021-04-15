//
//  NSString+BATrims.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//


#import "NSString+BATrims.h"

@implementation NSString (BATrims)

/*!
 * 清除html标签
 *
 * @return 清除后的结果
 */
- (NSString *)ba_trimStrippingHTMLString {
    return [self stringByReplacingOccurrencesOfString:@"<[^>]+>" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, self.length)];
}

/*!
 * 清除js脚本
 *
 * @return 清楚js后的结果
 */
- (NSString *)ba_trimScriptsAndStrippingHTMLString {
    NSMutableString *mString = [self mutableCopy];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<script[^>]*>[\\w\\W]*</script>" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:mString options:NSMatchingReportProgress range:NSMakeRange(0, [mString length])];
    for (NSTextCheckingResult *match in [matches reverseObjectEnumerator]) {
        [mString replaceCharactersInRange:match.range withString:@""];
    }
    return [mString ba_trimStrippingHTMLString];
}

/*!
 * 去除空格
 *
 * @return 去除空格后的字符串
 */
- (NSString *)ba_trimWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/*!
 * 去除字符串与空行
 *
 * @return 去除字符串与空行的字符串
 */
- (NSString *)ba_trimWhitespaceAndNewlines {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 去掉字符串中的 html 标签的方法

 @param HTMLString HTMLString
 @return 去掉字符串中的 html 标签后的 string
 */
+ (NSString *)ba_trimfilterHTML:(NSString *)HTMLString {
    NSScanner *scanner = [NSScanner scannerWithString:HTMLString];
    NSString *text = nil;
    while([scanner isAtEnd]==NO) {
        // 找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        // 找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        // 替换字符
        HTMLString = [HTMLString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    // 去掉 html 里面的空格
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    // 去掉换行
    HTMLString = [HTMLString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    // 去掉前后两边空白
    HTMLString = [HTMLString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //    NSLog(@"html:------------%@",html);
    return HTMLString;
}

/*!
 *  去除字符串的特殊字符
 *
 *  @param string 需要处理的字符串（如：NSString *string = @"<f7091300 00000000 830000c4 00002c00 0000c500>";）
 *
 * @return 去除字符串的特殊字符
 */
+ (nullable NSString *)ba_trimWithString:(nullable NSString *)string {
    // 去除字符串的特殊字符
    //    NSString *string = @"<f7091300 00000000 830000c4 00002c00 0000c500>";
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、<>[]{}#%-*+=_\\|~＜＞$?^?'@#$%^&*()_+'\""];
    NSString*trimmedString = [string stringByTrimmingCharactersInSet:set];
    NSLog(@"trimmedString1:%@",trimmedString);
    // 去除字符串的空格
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"trimmedString2: %@",trimmedString);
    
    return trimmedString;
}

/**
 十六进制转换为普通 string

 @param hexString 十六进制 string
 @return 转换后的 string
 */
- (NSString *)ba_stringFromHexString:(NSString *)hexString {
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
//    NSLog(@"------字符串=======%@",unicodeString);
    return unicodeString;
}

/*!
 *  obj 转 json
 *
 *  @param id 传入的 obj
 *
 *  @return 返回 json 字符串
 */
+ (NSString *)ba_stringToJsonWithObj:(id)obj {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"字典转json出错,返回空字符串---%@",error);
        return @"";
    } else {
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
}

/**
 获取 string 的长度

 @param string string
 @return string 的长度
 */
+ (NSUInteger)ba_stringGetLengthOfString:(NSString*)string {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [string dataUsingEncoding:enc];
    return [data length];
}

/**
 重复字符串 N 次

 @param repeatString 需要重复的 string
 @param repeatCount 重复次数
 @return 重复后的 string
 */
+ (NSString *)ba_stringWithNeedRepeatString:(NSString *)repeatString
                                repeatCount:(NSInteger)repeatCount {
    NSMutableString *String = [NSMutableString new];
    for (int i = 0; i < repeatCount; i++) {
        [String appendString:repeatString];
    }
    return String;
}

+ (NSString *)ba_getNumberFromStr:(NSString *)str {
    NSCharacterSet *nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return[[str componentsSeparatedByCharactersInSet:nonDigitCharacterSet] componentsJoinedByString:@""];
    
}

+ (NSInteger)ba_scanNumFromVersionString:(NSString *)versionString maxLength:(NSInteger)maxLength {
    NSString *numberString = [NSString ba_getNumberFromStr:versionString];
    if (numberString.length < maxLength) {
        NSString *a = @"";
        NSInteger b = maxLength - numberString.length;
        for (NSInteger i = 0; i < b; ++i) {
            a = [a stringByAppendingString:@"0"];
        }
        numberString = [numberString stringByAppendingString:a];
    }
    NSInteger number = numberString.intValue;
    
    return number;
}

- (NSString *)ba_stringByURLEncode {
    NSString *url = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,                                                                  (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",NULL, kCFStringEncodingUTF8));
    return url;
}

- (NSString *)ba_stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
#pragma clang diagnostic pop
    }
}

@end
