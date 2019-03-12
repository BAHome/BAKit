//
//  UILabel+BASize.m
//  BAKit
//
//  Created by boai on 2017/7/19.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "UILabel+BASize.h"

@implementation UILabel (BASize)

/**
 label：NSString sizeToFit
 
 @param text text description
 @param configBlock configBlock description
 */
- (void)ba_labelSizeToFitWitText:(NSString *)text configBlock:(BAKit_LabelConfigBlock)configBlock
{
    self.text = text;
    [self sizeToFit];
    
    if (configBlock)
    {
        configBlock(self);
    }
}

/**
 label：NSAttributedString sizeToFit
 
 @param attributedText attributedText description
 @param configBlock configBlock description
 */
- (void)ba_labelSizeToFitWitAttributedText:(NSAttributedString *)attributedText configBlock:(BAKit_LabelConfigBlock)configBlock
{
    self.attributedText = attributedText;
    [self sizeToFit];
    
    if (configBlock)
    {
        configBlock(self);
    }
}


@end
