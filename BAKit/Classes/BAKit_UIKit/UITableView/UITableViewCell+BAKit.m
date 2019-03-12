//
//  UITableViewCell+BAKit.m
//  BAKit
//
//  Created by boai on 2017/7/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITableViewCell+BAKit.h"

@implementation UITableViewCell (BAKit)

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    CGFloat min_x = 0;
//    CGFloat min_y = 0;
//    CGFloat min_w = 0;
//    CGFloat min_h = 0;
//    
//    min_x = 15;
//    min_w = 30;
//    min_y = 7;
//    min_h = min_w;
//    self.imageView.frame = CGRectMake(min_x, min_y, min_w, min_h);
//    
//    min_w = CGRectGetWidth(self.frame) - CGRectGetMaxX(self.imageView.frame) - 15 * 2;
//    if (self.imageView.image.size.width > 0)
//    {
//        min_x = CGRectGetMaxX(self.imageView.frame) + 10;
//    }
//    min_y = 0;
//    min_h = CGRectGetHeight(self.frame);
//    if (self.detailTextLabel.text.length > 0)
//    {
//        min_y = 5;
//        min_h = CGRectGetHeight(self.frame)/2 - 5;
//    }
//    self.textLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
//    
//    min_y = self.centerY;
//    self.detailTextLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
//    
//    self.imageView.backgroundColor = BAKit_Color_Red;
//    self.textLabel.backgroundColor = BAKit_Color_Yellow;
//    self.detailTextLabel.backgroundColor = BAKit_Color_Green;
//    
//    [super layoutIfNeeded];
//}

#pragma mark - setter getter



@end
