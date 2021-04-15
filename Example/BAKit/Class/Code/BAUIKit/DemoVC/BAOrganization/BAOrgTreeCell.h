//
//  BAOrgTreeCell.h
//  BBB
//
//  Created by 孙博岩 on 2019/5/5.
//  Copyright © 2019 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BAOrgTreeModel;

typedef void(^shouqiBlock)(UIButton *sender, BAOrgTreeModel *org);

@interface BAOrgTreeCell : UITableViewCell


@property (nonatomic,strong) BAOrgTreeModel *model;

@property (nonatomic,copy) shouqiBlock shouqiBlock;

@property (nonatomic,strong) UIButton *shouqiBtn;

@end

NS_ASSUME_NONNULL_END
