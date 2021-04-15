//
//  BAContactCell.h
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/3/13.
//  Copyright © 2019 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define cellHeight        50
#define cellImageViewSize cellHeight * 0.8

@class BAContactsModel;
@interface BAContactCell : UITableViewCell

@property(nonatomic, strong) BAContactsModel *model;

@end

NS_ASSUME_NONNULL_END
