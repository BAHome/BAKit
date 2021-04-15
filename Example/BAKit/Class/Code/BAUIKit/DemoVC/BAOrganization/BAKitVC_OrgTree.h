//
//  BAKitVC_OrgTree.h
//  BBB
//
//  Created by 孙博岩 on 2019/3/29.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BABaseViewController.h"

typedef NS_ENUM(NSInteger, BAOrgTreeSearchType) {
    BAOrgTreeSearchTypeEqual = 0,
    BAOrgTreeSearchTypeContain
};

@class BAOrgTreeModel;

NS_ASSUME_NONNULL_BEGIN

@interface BAKitVC_OrgTree : BABaseViewController

typedef void(^treeSureBlock)(BAOrgTreeModel *org);

@property (nonatomic,strong) NSMutableArray<BAOrgTreeModel*> *orgList;

@property (nonatomic,strong) BAOrgTreeModel *selectOrg;

@property (nonatomic,copy) treeSureBlock sureBlock;

@property (nonatomic,assign) BOOL isOnlyFarm;

// 搜索类别
@property (nonatomic) BAOrgTreeSearchType treeSearchType;


@end

NS_ASSUME_NONNULL_END
