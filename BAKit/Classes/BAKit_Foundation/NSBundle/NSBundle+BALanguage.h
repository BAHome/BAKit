//
//  NSBundle+BALanguage.h
//  yunlian_APP
//
//  Created by boai on 2018/3/27.
//  Copyright © 2018年 云联惠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (BALanguage)

/**
 NSBundle：APP 内部语言切换

 @param language 语言
 */
+ (void)ba_setLanguage:(NSString *)language;

@end
