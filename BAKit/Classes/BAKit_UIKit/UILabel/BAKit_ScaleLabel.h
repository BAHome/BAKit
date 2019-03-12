//
//  BAKit_ScaleLabel.h
//  BAKit
//
//  Created by boai on 2017/7/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BAKit_ScaleLabel : UIView

@property(nonatomic, strong) NSString *ba_text;
@property(nonatomic, strong) UIFont *ba_font;
@property(nonatomic, assign) CGFloat ba_scaleStart;
@property(nonatomic, assign) CGFloat ba_scaleEnd;
@property(nonatomic, strong) UIColor *ba_colorBackLabelColor;
@property(nonatomic, strong) UIColor *ba_colorLabelColor;

- (void)ba_startAnimation;

@end
