//
//  BABaseViewController.m
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABaseViewController.h"

#import "BAKit_Color.h"

#import "BAKit_DefineTip.h"
#import "BAAlertController.h"

@interface BABaseViewController ()

@end

@implementation BABaseViewController

#pragma mark - life
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self ba_base_viewWillAppear];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self ba_base_viewDidDAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self ba_base_viewWillDisappear];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.view endEditing:YES];
    [self ba_base_viewDidDisappear];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BAKit_Color_White;

    [self ba_base_setupUI];
    [self ba_base_setupNavi];
}

#pragma mark - custome method

- (void)ba_base_viewWillAppear
{
    
}

- (void)ba_base_viewDidDAppear
{
    
}

- (void)ba_base_viewWillDisappear
{

}

- (void)ba_base_viewDidDisappear
{

}

- (void)ba_base_setupUI
{
    
}

- (void)ba_base_setupNavi
{
    
}

#pragma mark - 自定义转场动画
/*！
 自定义动画样式
 
 @param type 动画样式
 @param animationView 需要动画的 View
 */
- (void)ba_animationWithBATransitionType:(BAKit_ViewTransitionType)type
                           animationView:(UIView *)animationView
{
    switch (type) {
        case 0:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeFade view:animationView];
            break;
            
        case 1:
            [self ba_transitonWithType:BAKit_ViewTransitionTypePush view:animationView];
            break;
            
        case 2:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeReveal view:animationView];
            break;
            
        case 3:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeMoveIn view:animationView];
            break;
            
        case 4:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeCube view:animationView];
            break;
            
        case 5:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeSuckEffect view:animationView];
            break;
            
        case 6:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeOglFlip view:animationView];
            break;
            
        case 7:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeRippleEffect view:animationView];
            break;
            
        case 8:
            [self ba_transitonWithType:BAKit_ViewTransitionTypePageCurl view:animationView];
            break;
            
        case 9:
            [self ba_transitonWithType:BAKit_ViewTransitionTypePageUnCurl view:animationView];
            break;
            
        case 10:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeCameraIrisHollowOpen view:animationView];
            break;
            
        case 11:
            [self ba_transitonWithType:BAKit_ViewTransitionTypeCameraIrisHollowClose view:animationView];
            break;
            
        case 12:
            [animationView ba_transitionViewWithDuration:0.8f
                                          animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionCurlDown
                                                 forView:animationView];
            break;
            
        case 13:
            [animationView ba_transitionViewWithDuration:0.8f
                                          animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionCurlUp
                                                 forView:animationView];
            break;
            
        case 14:
            [animationView ba_transitionViewWithDuration:0.8f
                                          animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionFlipFromLeft
                                                 forView:animationView];
            break;
            
        case 15:
            [animationView ba_transitionViewWithDuration:0.8f
                                          animationCurve:UIViewAnimationCurveEaseInOut transition:UIViewAnimationTransitionFlipFromRight
                                                 forView:animationView];
            break;
            
        default:
            break;
    }
    
}

- (void)ba_transitonWithType:(BAKit_ViewTransitionType)type view:(UIView *)animationView
{
    [animationView ba_transitionWithType:type
                                 subType:BAKit_ViewTransitionSubtypeFromLeft
                                duration:1.0f
                          timingFunction:BAKit_ViewTransitionTimingFunctionTypeEaseInEaseOut
                     removedOnCompletion:YES
                                 forView:animationView];
}
    
#pragma mark - 清理缓存
- (void)ba_clearCacheWithBlock:(void (^)(NSInteger buttonIndex, BAKit_ClearCacheManager *clearCacheManager, CGFloat cacheSize))block
{
    BAKit_ClearCacheManager *clearCacheManager = [BAKit_ClearCacheManager ba_sharedCache];
    CGFloat cacheSize = [clearCacheManager ba_loadCacheSize];
    
    NSString *clearMessage = [NSString stringWithFormat:@"缓存大小为：%.2fM，确定要清理吗?", cacheSize];
    
    NSArray *buttonTitleArray = @[BAKit_DefineTip_Cancle, BAKit_DefineTip_Sure];
    NSArray *buttonTitleColorArray = @[BAKit_Color_Green, BAKit_Color_Red];
    [UIAlertController ba_alertShowInViewController:self title:BAKit_DefineTip_AlertTitle message:clearMessage buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
        if (block)
        {
            block(buttonIndex, clearCacheManager, cacheSize);
        }
    }];
}

- (void)dealloc
{
    [self ba_base_viewDidDisappear];
}

@end
