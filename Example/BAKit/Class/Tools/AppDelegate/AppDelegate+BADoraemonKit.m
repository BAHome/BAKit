//
//  AppDelegate+BADoraemonKit.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/2/13.
//  Copyright © 2019 boai. All rights reserved.
//

#import "AppDelegate+BADoraemonKit.h"
#import "DoraemonKit.h"
#import "Doraemoni18NUtil.h"

@implementation AppDelegate (BADoraemonKit)

- (void)initDoraemonKit {
#ifdef DEBUG
    [[DoraemonManager shareInstance] install];
//    [[DoraemonManager shareInstance] removePluginWithPluginName:@"DoraemonGPSPlugin" atModule:DoraemonLocalizedString(@"常用工具")];
#endif
}

@end
