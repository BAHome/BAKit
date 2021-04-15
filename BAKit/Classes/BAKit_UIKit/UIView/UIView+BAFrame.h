//
//  UIView+BAFrame.h
//  BAKit
//
//  Created by boai on 2017/6/10.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BAFrame)

/*----------------------
 * Absolute coordinate *
 ----------------------*/

//@property (nonatomic, assign) CGFloat x;
//@property (nonatomic, assign) CGFloat y;
//@property (nonatomic, assign) CGFloat width;
//@property (nonatomic, assign) CGFloat height;
//
//@property (nonatomic, assign) CGFloat top;
//@property (nonatomic, assign) CGFloat bottom;
//@property (nonatomic, assign) CGFloat left;
//@property (nonatomic, assign) CGFloat right;
//
//@property (nonatomic, assign) CGFloat centerX;
//@property (nonatomic, assign) CGFloat centerY;
//
//@property (nonatomic, assign) CGPoint origin;
//@property (nonatomic, assign) CGSize  size;

/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;


@end
