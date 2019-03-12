//
//  BAKitVC_ShimmerLabel.m
//  BAKit
//
//  Created by boai on 2017/7/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_ShimmerLabel.h"

#import "BAKit_Color.h"
#import "BAKit_DefineFrame.h"
#import "BAKit_DefineFont.h"

@interface BAKitVC_ShimmerLabel ()

@end

@implementation BAKitVC_ShimmerLabel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    [self test];
}

- (void)test
{
    CGRect frame = CGRectMake(40, 100, BAKit_SCREEN_WIDTH - 40 * 2, 80);
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc] initWithFrame:frame];
    [self.view addSubview:shimmeringView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.backgroundColor = BAKit_Color_Blue_SkyBlue;
    loadingLabel.textColor = BAKit_Color_Cyan_Aquamarine;
    loadingLabel.text = NSLocalizedString(@"Loading...", nil);
    loadingLabel.font = [UIFont fontWithName:@"AppleSDGothicNeo-Bold" size:30];
    
    shimmeringView.contentView = loadingLabel;
    
    // Start shimmering.
    shimmeringView.shimmering = YES;
    
}

- (void)ba_base_setupNavi
{
    // Title label.
    UILabel *headlinelabel      = [UILabel new];
    headlinelabel.font          = BAKit_Font_systemFontOfSize_18;
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor     = [UIColor whiteColor];
    headlinelabel.text          = self.title;
    [headlinelabel sizeToFit];
    
    headlinelabel.frame = CGRectMake(50, 0, BAKit_SCREEN_WIDTH - 50 * 2, 44);
    
    FBShimmeringView *shimmeringView           = [[FBShimmeringView alloc] initWithFrame:headlinelabel.bounds];
    shimmeringView.shimmering                  = YES;
    shimmeringView.shimmeringBeginFadeDuration = 0.3;
    shimmeringView.shimmeringOpacity           = 0.1f;
    shimmeringView.shimmeringAnimationOpacity  = 1.f;
    
    shimmeringView.contentView = headlinelabel;
    self.navigationItem.titleView = headlinelabel;
}

@end
