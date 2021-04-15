//
//  BACollectionViewCustomFlowLayoutModel.h
//  BAKit_Example
//
//  Created by 博爱 on 2021/1/19.
//  Copyright © 2021 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BACollectionViewCustomFlowLayoutModel : NSObject

@property(nonatomic, copy) NSString *title;


@property(nonatomic, strong) UIFont *titleFont;

@property(nonatomic, assign) CGFloat leftAndRightMargin;
@property(nonatomic, assign) CGFloat itemHeight;
@property(nonatomic, assign) CGSize itemSize;

@end

NS_ASSUME_NONNULL_END
