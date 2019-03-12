//
//  UILabel+BASize.h
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BAKit_LabelConfigBlock)(UILabel *label);

@interface UILabel (BASize)

/**
 label：NSString sizeToFit

 @param text text description
 @param configBlock configBlock description
 */
- (void)ba_labelSizeToFitWitText:(NSString *)text configBlock:(BAKit_LabelConfigBlock)configBlock;

/**
 label：NSAttributedString sizeToFit

 @param attributedText attributedText description
 @param configBlock configBlock description
 */
- (void)ba_labelSizeToFitWitAttributedText:(NSAttributedString *)attributedText configBlock:(BAKit_LabelConfigBlock)configBlock;

@end
