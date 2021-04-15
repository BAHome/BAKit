//
//  BAOrgTreeModel.m
//  BBB
//
//  Created by 孙博岩 on 2019/3/29.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAOrgTreeModel.h"

@interface BAOrgTreeModel ()

@property (nonatomic,strong) NSArray *closeSubModels;

@end

@implementation BAOrgTreeModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{
             @"fkId" : @"id"
             };
}

+ (NSArray *)mj_ignoredPropertyNames {
    return @[@"referList", @"supermodel"];
}

+ (instancetype)modelWithDic:(NSDictionary *)dic level:(NSInteger)level {
    BAOrgTreeModel *orgModel = [BAOrgTreeModel mj_objectWithKeyValues:dic];
    orgModel.belowCount = 0;
    orgModel.level = level;
    orgModel.referList = [NSMutableArray new];
    NSArray *submodels = dic[@"referList"];
    for (int i = 0; i < submodels.count; i++) {
        NSInteger subLevel = level + 1;
        BAOrgTreeModel *submodel = [BAOrgTreeModel modelWithDic:(NSDictionary *)submodels[i] level:subLevel];
        submodel.supermodel = orgModel;
        [orgModel.referList addObject:submodel];
    }
    return orgModel;
}

- (NSArray *)open {
    if (self.closeSubModels == nil) {
        self.closeSubModels = self.referList;
    }
    self.belowCount = self.closeSubModels.count;
    return self.closeSubModels;
}

- (void)closeWithSubmodels:(NSArray *)submodels {
    self.closeSubModels = submodels;
    self.belowCount = 0;
}

- (void)initBelowCount {
    _belowCount = 0;
    self.belowCount = self.referList.count;
}

- (void)setBelowCount:(NSUInteger)belowCount {
    self.supermodel.belowCount += (belowCount - _belowCount);
    _belowCount = belowCount;
}

@end
