//
//  UIView+BAScreenshot.m
//  BAQMUIDemo
//
//  Created by boai on 2017/5/27.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "UIView+BAScreenshot.h"

@implementation UIView (BAScreenshot)

- (UIImage *)ba_viewGetImageShot
{
    if (self && self.frame.size.height && self.frame.size.width)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
    else
    {
        return nil;
    }
}

- (UIImage *)ba_viewSaveScreenshot
{
    UIImage *image = [self ba_viewGetImageShot];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    return image;
}

@end
