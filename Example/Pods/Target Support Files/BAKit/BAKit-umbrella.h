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

#import "BAKit.h"
#import "BABaseListViewController.h"
#import "BABaseViewController.h"
#import "BAKit_BaseVC.h"
#import "BANavigationController.h"
#import "BAWebViewController.h"
#import "BABadgeLabel.h"
#import "BABadgeValueView.h"
#import "BAKit_BadgeView.h"
#import "UIBarButtonItem+BABadgeView.h"
#import "UITabBarItem+BABadgeView.h"
#import "UIView+BABadgeView.h"
#import "BAKit_ClearCacheManager.h"
#import "BAKit_Color.h"
#import "BAKit_Const_Color.h"
#import "BAKit_Helper.h"
#import "BAKit_LocalizedIndexedCollation.h"
#import "pinyin.h"
#import "BAMobleCountryCodeManger.h"
#import "BAKit_Custom.h"
#import "BAKit_DeviceInfoManager.h"
#import "NSObject+BAHUD.h"
#import "UIImage+BAGif.h"
#import "BAKit_LanguageSwitchManager.h"
#import "BAKit_LoadingView.h"
#import "BAKit_LocationManager.h"
#import "BAKit_MGJRouterHerder.h"
#import "BAKit_MGJRouter_Manager.h"
#import "BAKit_MGJRouter_ModuleManager.h"
#import "BAKit_MGJRouter_Protocol.h"
#import "BAKit_MGJRouter_Url.h"
#import "BAKit_PhotoKitManager.h"
#import "BAKit_DatePicker.h"
#import "BAKit_PickerView.h"
#import "BAKit_PickerViewConfig.h"
#import "BAPickView_OC.h"
#import "BAGradualProgressView.h"
#import "BAKit_RegularExpression.h"
#import "UIScrollView+BARefresh.h"
#import "GCD.h"
#import "GCDGroup.h"
#import "GCDQueue.h"
#import "GCDSemaphore.h"
#import "GCDTimer.h"
#import "BAKit_Define.h"
#import "BAKit_DefineApp.h"
#import "BAKit_DefineAppKey.h"
#import "BAKit_DefineCommon.h"
#import "BAKit_DefineCurrent.h"
#import "BAKit_DefineFont.h"
#import "BAKit_DefineFormat.h"
#import "BAKit_DefineFrame.h"
#import "BAKit_DefineNoti.h"
#import "BAKit_DefineSystem.h"
#import "BAKit_DefineTip.h"
#import "BAKit_Singleton.h"
#import "BAKit_Foundation.h"
#import "NSArray+BAKit.h"
#import "NSMutableArray+BAKit.h"
#import "NSBundle+BALanguage.h"
#import "NSData+BAKit.h"
#import "NSDate+BAKit.h"
#import "NSDateFormatter+BAKit.h"
#import "NSDictionary+BAKit.h"
#import "NSFileManager+BAKit.h"
#import "NSString+BAFileManager.h"
#import "NSAttributedString+BASize.h"
#import "NSMutableAttributedString+BAKit.h"
#import "NSNumber+BARandom.h"
#import "NSObject+BAExchangeMethod.h"
#import "NSShadow+BAKit.h"
#import "BAKit_NSString.h"
#import "NSString+BAColor.h"
#import "NSString+BAEmoji.h"
#import "NSString+BAEncrypt.h"
#import "NSString+BAImageNameUrlString.h"
#import "NSString+BAKit.h"
#import "NSString+BANSNumber.h"
#import "NSString+BARange.h"
#import "NSString+BARegular.h"
#import "NSString+BASize.h"
#import "NSString+BATime.h"
#import "NSString+BATransform.h"
#import "NSString+BATrims.h"
#import "NSString+BAUIButton.h"
#import "NSTextAttachment+BAKit.h"
#import "NSURL+QueryDictionary.h"
#import "BAKit_UIKit.h"
#import "CABasicAnimation+BAKit.h"
#import "CALayer+BAAnimation.h"
#import "CALayer+BAFrame.h"
#import "CAShapeLayer+BACornerRadius.h"
#import "UIAlertAction+BAKit.h"
#import "BAKit_UIApplication.h"
#import "UIApplication+BAKeyboardFrame.h"
#import "UIApplication+BAPermissions.h"
#import "UIBarButtonItem+BABadge.h"
#import "UIBarButtonItem+BAKit.h"
#import "UIColor+BAKit.h"
#import "UIDevice+BAKit.h"
#import "UIFont+BAKit.h"
#import "UIGestureRecognizer+BAOpertation.h"
#import "UIView+BAGesture.h"
#import "UIImage+BAColor.h"
#import "UIImage+BAKit.h"
#import "UIImage+BARender.h"
#import "UIImage+ImageEffects.h"
#import "UIImageEffects.h"
#import "UIImageView+BAAnimation.h"
#import "BAKit_FPSLabel.h"
#import "BAKit_ScaleLabel.h"
#import "BAKit_UILabel.h"
#import "UILabel+BAAttributeTextTapAction.h"
#import "UILabel+BAKit.h"
#import "UILabel+BASize.h"
#import "UILabel+BATextAlignment.h"
#import "UINavigationBar+BAKit.h"
#import "UINavigationController+BAKit.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UIScrollView+BAFrame.h"
#import "UIScrollView+BAKit.h"
#import "UITabBar+BABadge.h"
#import "UITabBarController+BAKit.h"
#import "UITabBarItem+BAKit.h"
#import "BAKit_UITableView.h"
#import "UITableView+BAKit.h"
#import "UITableView+BASectionView.h"
#import "UITableViewCell+BAAccessoryType.h"
#import "UITableViewCell+BAKit.h"
#import "UITableViewCell+BAReuse.h"
#import "UITextField+intrinsicContentSize.h"
#import "BAKit_UIView.h"
#import "UIView+BAAnimationProperty.h"
#import "UIView+BAFind.h"
#import "UIView+BAFrame.h"
#import "UIView+BAGlowView.h"
#import "UIView+BAKit.h"
#import "UIView+BANib.h"
#import "UIView+BAScreenshot.h"
#import "UIView+BAShake.h"
#import "UIView+BATransition.h"
#import "UIView+BAUserInteraction.h"
#import "UIViewController+BABottomLine.h"
#import "UIViewController+BACustomBackButton.h"
#import "UIViewController+BAKit.h"
#import "BAKit_ConfigurationDefine.h"
#import "BAKit_WebView.h"
#import "WeakScriptMessageDelegate.h"
#import "WKWebView+BAJavaScriptAlert.h"
#import "WKWebView+BAKit.h"
#import "WKWebView+Post.h"
#import "BAKit_Version.h"

FOUNDATION_EXPORT double BAKitVersionNumber;
FOUNDATION_EXPORT const unsigned char BAKitVersionString[];

