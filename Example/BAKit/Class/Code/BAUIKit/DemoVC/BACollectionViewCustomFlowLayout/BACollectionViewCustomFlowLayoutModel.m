//
//  BACollectionViewCustomFlowLayoutModel.m
//  BAKit_Example
//
//  Created by 博爱 on 2021/1/19.
//  Copyright © 2021 boai. All rights reserved.
//

#import "BACollectionViewCustomFlowLayoutModel.h"

@implementation BACollectionViewCustomFlowLayoutModel

- (CGSize)itemSize {
    CGSize size = CGSizeZero;
    if (self.itemHeight <= 0 || self.titleFont == nil || BAKit_ObjectIsEmpty(self.title)) {
        NSLog(@"itemHeight 可能为0，title、titleFont 可能为空");
        return size;
    }
    CGFloat min_w = BAKit_LabelWidthWithTextAndFont(self.title, self.itemHeight, self.titleFont) + 6;
    min_w += self.leftAndRightMargin*2;
    size = CGSizeMake(min_w, self.itemHeight);
    return size;
}

@end
