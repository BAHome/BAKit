//
//  UITableView+BAKit.m
//  BAKit
//
//  Created by boai on 2017/7/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UITableView+BAKit.h"
#import "BAKit_Color.h"
#import "BAKit_DefineCommon.h"

@implementation UITableView (BAKit)


- (void)ba_changeBackgroundImageWithImageName:(UIImage *)image
{
    self.backgroundColor = BAKit_Color_Clear;
    self.backgroundView = nil;
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = self.bounds;
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundView = imageView;
}

#pragma mark - setter getter

- (void)setBa_tableViewBackgroundImage:(UIImage *)ba_tableViewBackgroundImage
{
    BAKit_Objc_setObj(@selector(ba_tableViewBackgroundImage), ba_tableViewBackgroundImage);
    
    [self ba_changeBackgroundImageWithImageName:ba_tableViewBackgroundImage];
}

- (UIImage *)ba_tableViewBackgroundImage
{
    return BAKit_Objc_getObj;
}

- (void)setBa_tableViewCellStyle:(UITableViewCellStyle)ba_tableViewCellStyle
{
    BAKit_Objc_setObj(@selector(ba_tableViewCellStyle), @(ba_tableViewCellStyle));
}

- (UITableViewCellStyle)ba_tableViewCellStyle
{
    return [BAKit_Objc_getObj integerValue];
}

@end
