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

#import "QQLeakDataUploadCenter.h"
#import "OOMDetector.h"
#import "QQLeakChecker.h"
#import "OOMStatisticsInfoCenter.h"
#import "QQLeakFileUploadCenter.h"
#import "libOOMDetector.h"

FOUNDATION_EXPORT double OOMDetectorVersionNumber;
FOUNDATION_EXPORT const unsigned char OOMDetectorVersionString[];

