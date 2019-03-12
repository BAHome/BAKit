#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BAAlertController.h"
#import "BAKit_ConfigurationDefine.h"
#import "NSMutableAttributedString+BAKit.h"
#import "NSObject+BARunTime.h"
#import "UIAlertController+BAKit.h"

FOUNDATION_EXPORT double BAAlertControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char BAAlertControllerVersionString[];

