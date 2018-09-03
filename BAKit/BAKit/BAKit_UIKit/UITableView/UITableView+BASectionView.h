//
//  UITableView+BASectionView.h
//  BAKit
//
//  Created by 孙博岩 on 2018/7/18.
//  Copyright © 2018 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 为 UITableView section 统一设置 阴影图片
 */
@interface UITableView (BASectionView)

/**
 UITableView：section 统一设置 阴影图片
 */
@property(nonatomic, strong) UIImage *sectionImage;

@end

NS_ASSUME_NONNULL_END
