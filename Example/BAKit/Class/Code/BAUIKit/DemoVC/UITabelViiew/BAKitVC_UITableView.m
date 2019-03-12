//
//  BAKitVC_UITableView.m
//  BAKit
//
//  Created by boai on 2017/7/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UITableView.h"
#import "BAKitVC_UITableCell.h"
#import "BAKitVC_UITableView2.h"

#import <NetworkExtension/NetworkExtension.h>

#import "BAKit_Color.h"
#import "BAKit_DefineCommon.h"

@interface BAKitVC_UITableView ()

@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property (nonatomic, copy) NSString *infoString;

@end

@implementation BAKitVC_UITableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    self.tableView.backgroundColor = BAKit_Color_Gray_11;
    
    BAKit_WeakSelf
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        UIViewController *vc;
        if (indexPath.row == 0)
        {
            vc = [BAKitVC_UITableCell new];
        }
        else if (indexPath.row == 1)
        {
            vc = [BAKitVC_UITableView2 new];
        }
        vc.title = model.sectionDataArray[indexPath.row].title;
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[
                        @"cell 的 accessoryView 自定义样式",
                        @"BABaseListViewController 封装"
                        ];
    }
    return _titleArray;
}

- (NSMutableArray *)mutableDataArray
{
    if (!_mutableDataArray)
    {
        _mutableDataArray = @[].mutableCopy;
        
        NSArray *sectionTitleArray = @[@""];
        for (NSInteger i = 0; i < sectionTitleArray.count; i++)
        {
            BABaseListViewSectionModel *sectionModel = [BABaseListViewSectionModel new];
            sectionModel.sectionTitle = sectionTitleArray[i];
            
            NSMutableArray *cellModelArray = @[].mutableCopy;
            for (NSInteger j = 0; j < self.titleArray.count; j ++)
            {
                BABaseListViewCellModel *cellModel = [BABaseListViewCellModel new];
                cellModel.title = self.titleArray[j];
                //            model.imageName = imageArray[i];
                //            model.detailString = detailArray[i];
                [cellModelArray addObject:cellModel];
            }
            sectionModel.sectionDataArray = cellModelArray;
            [_mutableDataArray addObject:sectionModel];
        }
    }
    return _mutableDataArray;
}


@end
