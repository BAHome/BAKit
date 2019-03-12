//
//  AppDelegate+BABugly.h
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/1/31.
//  Copyright © 2019 boai. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugly/Bugly.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (BABugly)<BuglyDelegate>

- (void)initBugly;

@end

NS_ASSUME_NONNULL_END
