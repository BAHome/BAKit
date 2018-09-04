//
//  UIWindow+YZTTFLEXSetting.m
//  yingzi_ios_farmmgr
//
//  Created by 孙博岩 on 2018/6/1.
//  Copyright © 2018年 Yingzi. All rights reserved.
//

#import "UIWindow+YZTTFLEXSetting.h"

#if 1//DEBUG
    #import "FLEXManager.h"
#endif

@implementation UIWindow (YZTTFLEXSetting)

#if 1//DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];
        
    }
}
#endif

@end
