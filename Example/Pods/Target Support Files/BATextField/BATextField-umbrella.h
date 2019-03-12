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

#import "BAKit_ConfigurationDefine.h"
#import "BAKit_UserDefaults.h"
#import "BATextField.h"
#import "BATextField_Version.h"
#import "UITextField+BAHistory.h"
#import "UITextField+BAKit.h"
#import "UIView+BAFrame.h"

FOUNDATION_EXPORT double BATextFieldVersionNumber;
FOUNDATION_EXPORT const unsigned char BATextFieldVersionString[];

