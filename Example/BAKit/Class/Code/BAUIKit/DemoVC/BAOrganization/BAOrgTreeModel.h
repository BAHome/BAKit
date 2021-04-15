//
//  BAOrgTreeModel.h
//  BBB
//
//  Created by 孙博岩 on 2019/3/29.
//  Copyright © 2019 boai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAOrgTreeModel : NSObject

@property (nonatomic, copy) NSString *fkId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *shortName;
@property (nonatomic, copy) NSString *theDescription;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSMutableArray<BAOrgTreeModel *> *referList;

#pragma mark - 增加字段

/* 选中 */
@property (nonatomic,assign) BOOL selected;
/* 展开 */
@property (nonatomic,assign) BOOL zhankai;

@property (nonatomic,assign) NSInteger level;

@property(nonatomic,assign) NSUInteger belowCount;

@property(nullable,nonatomic) BAOrgTreeModel *supermodel;

@property (nonatomic,assign) BOOL search;


+ (instancetype)modelWithDic:(NSDictionary *)dic level:(NSInteger)level;

- (NSArray *)open;

- (void)closeWithSubmodels:(NSArray *)submodels;

- (void)initBelowCount;


@end

NS_ASSUME_NONNULL_END
