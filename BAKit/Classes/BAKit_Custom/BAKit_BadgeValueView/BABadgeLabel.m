//
//  BABadgeLabel.m
//  BAKit
//
//  Created by boai on 2017/7/29.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABadgeLabel.h"
#import "UIView+BAFrame.h"

#import "BAKit_DefineFrame.h"

@implementation BABadgeLabel

+ (instancetype)ba_badgeLabelDefaultBadgeLabel
{
    // 默认为系统 tabBarItem 的 badge 大小
    return [[BABadgeLabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont systemFontOfSize:10];
    self.textAlignment = NSTextAlignmentCenter;
    self.layer.cornerRadius = self.height * 0.5;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor colorWithRed:1.00 green:0.17 blue:0.15 alpha:1.00];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    // 根据内容调整label的宽度
    CGFloat stringWidth = BAKit_LabelWidthWithTextAndFont(text, self.height, self.font);
    if (self.height > stringWidth + self.height * 10 / 18)
    {
        self.width = self.height;
        return;
    }
    self.width = self.height * 5 / 18 + stringWidth + self.height * 5 / 18;
}

@end
