//
//  BAKitVC_UILabel.m
//  BAKit
//
//  Created by boai on 2017/7/4.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UILabel.h"

#import "BAKitVC_UnderlineLabel.h"
#import "BAKitVC_ScaleLabel.h"
#import "BAKitVC_ShimmerLabel.h"
#import "BAKitVC_InterestingLabel.h"

#import "BAKit_Color.h"
#import "BAKit_DefineCommon.h"

@interface BAKitVC_UILabel ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property(nonatomic, strong) NSArray *titleArray;

@end

@implementation BAKitVC_UILabel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = BAKit_Color_White;
    
    self.tableView.backgroundColor = BAKit_Color_Gray_11;
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        
        UIViewController *vc;
        if (indexPath.row == 0)
        {
            vc = [BAKitVC_UnderlineLabel new];
        }
        else if(indexPath.row == 1)
        {
            vc = [BAKitVC_ScaleLabel new];
        }
        else if(indexPath.row == 2)
        {
            vc = [BAKitVC_ShimmerLabel new];
        }
        else if(indexPath.row == 3)
        {
            vc = [BAKitVC_InterestingLabel new];
        }
        
        
        vc.title = model.sectionDataArray[indexPath.row].title;
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"可点击的下划线文字", @"UILabel 缩放动画", @"Facebook 辉光动画", @"带阴影文字的 Label"];
    }
    return _titleArray;
}

- (NSMutableArray *)mutableDataArray
{
    if (!_mutableDataArray)
    {
        _mutableDataArray = @[].mutableCopy;
        
        NSArray *sectionTitleArray = @[@""];
        
        //        NSArray *detailArray = @[@"图上文下1", @"两行文字2"];
        //        NSArray *imageArray = @[@"tabbar_contactsHL", @"tabbar_contactsHL"];
        
        for (NSInteger i = 0; i < sectionTitleArray.count; i ++)
        {
            BABaseListViewSectionModel *sectionModel = [BABaseListViewSectionModel new];
            sectionModel.sectionTitle = sectionTitleArray[i];
            
            if (i == 0)
            {
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
            }
            
            [_mutableDataArray addObject:sectionModel];
        }
    }
    return _mutableDataArray;
}


@end
