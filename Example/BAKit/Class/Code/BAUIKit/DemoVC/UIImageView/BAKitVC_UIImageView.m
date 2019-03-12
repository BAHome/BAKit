//
//  BAKitVC_UIImageView.m
//  BAKit
//
//  Created by boai on 2017/8/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UIImageView.h"
#import "ImageViewAnimationVC.h"

@interface BAKitVC_UIImageView ()

@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAKitVC_UIImageView

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
            vc = [ImageViewAnimationVC new];
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
                        @"汤姆猫动画"
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
