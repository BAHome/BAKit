//
//  BABaseViewController.h
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+BATransition.h"
#import "BAKit_ClearCacheManager.h"

@interface BABaseViewController : UIViewController

#pragma mark - custome method

- (void)ba_base_viewWillAppear;
- (void)ba_base_viewDidDAppear;
- (void)ba_base_viewWillDisappear;
- (void)ba_base_viewDidDisappear;

- (void)ba_base_setupUI;
- (void)ba_base_setupNavi;

#pragma mark - 自定义转场动画
/*！
 自定义动画样式
 
 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BAKit_ViewTransitionType)type
                           animationView:(UIView *)animationView;

#pragma mark - 清理缓存
- (void)ba_clearCacheWithBlock:(void (^)(NSInteger buttonIndex, BAKit_ClearCacheManager *clearCacheManager, CGFloat cacheSize))block;

@end
