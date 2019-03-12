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
#import "BATextView.h"
#import "BATextView_Version.h"
#import "UITextView+BAKit.h"

FOUNDATION_EXPORT double BATextViewVersionNumber;
FOUNDATION_EXPORT const unsigned char BATextViewVersionString[];

