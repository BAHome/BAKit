//
//  BAKitVC_UITableCell.m
//  BAKit
//
//  Created by boai on 2017/7/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UITableCell.h"

@interface BAKitVC_UITableCell ()

@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAKitVC_UITableCell

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    self.tableView.backgroundColor = BAKit_Color_Gray_11;
    
    BAKit_WeakSelf
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        BAKit_StrongSelf
        
        if (indexPath.row == 0)
        {
            [cell ba_cellSetAccessoryImage:BAKit_ImageName(@"1.jpg") frame:CGRectMake(BAKit_SCREEN_WIDTH - 30 - 20, 0, 25, 20)];
        }
        else
        {
            [cell ba_cellSetAccessorySwitchWithIndexPath:indexPath frame:CGRectMake(BAKit_SCREEN_WIDTH - 30 - 50, 0, 51, 31) actionBlock:^(UISwitch *switcher) {
                [switcher addTarget:self action:@selector(handleSwichAction:) forControlEvents:UIControlEventValueChanged];
            }];
        }
    };
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        UIViewController *vc;
        if (indexPath.row == 0)
        {
//            vc = [BAKitVC_UITableCell new];
        }
        vc.title = model.sectionDataArray[indexPath.row].title;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
}


#pragma mark - custom method
- (void)handleSwichAction:(UISwitch *)sender
{
    NSString *kai = sender.on ? @"打开":@"关闭";
    
    NSString *msg = [NSString stringWithFormat:@"你 %@ 了 开关%ld", kai, sender.tag];
    
    BAKit_ShowAlertWithMsg_ios8(msg);
}

#pragma mark - setter / getter

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[
                        @"accessoryView 自定义样式：image",
                        @"accessoryView 自定义样式：switch1",
                        @"accessoryView 自定义样式：switch2"
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
