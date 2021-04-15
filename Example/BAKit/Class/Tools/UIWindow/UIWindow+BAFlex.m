//
//  UIWindow+BAFlex.m
//  BAKit
//
//  Created by 孙博岩 on 2018/9/4.
//  Copyright © 2018 boai. All rights reserved.
//

#import "UIWindow+BAFlex.h"

#if 1//DEBUG
    #import "FLEXManager.h"
#endif

@implementation UIWindow (BAFlex)

#if 1//DEBUG
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [super motionBegan:motion withEvent:event];
    
    if (motion == UIEventSubtypeMotionShake) {
        [[FLEXManager sharedManager] showExplorer];
        
    }
}
#endif

@end
