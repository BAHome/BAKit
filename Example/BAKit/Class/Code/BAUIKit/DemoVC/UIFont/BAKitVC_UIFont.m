//
//  BAKitVC_UIFont.m
//  BAKit
//
//  Created by boai on 2017/7/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UIFont.h"
#import "BAKitVC_UIFontDetailViewController.h"

#import "BAKit_UITableView.h"
#import "BAKit_DefineCommon.h"
#import "UIFont+BAKit.h"

@interface BAKitVC_UIFont ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property(nonatomic, strong) NSArray *titleArray;

@end

@implementation BAKitVC_UIFont

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.title = @"iOS 系统字体大全";
//    self.view.backgroundColor = BAKit_Color_White;

//    self.tableView.ba_tableViewBackgroundImage = BAKit_ImageName(@"test6");
    BAKit_UITableViewSetBackgroundImage(self.tableView, BAKit_ImageName(@"test6"));
    
    NSString *msg = @"注意：如果需要哪种字体，直接点击即可，然后查看 Xcode 控制台输出的字体名字，复制粘贴即可！";
    NSLog(@"%@", msg);
    
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        BAKit_StrongSelf
        
//        [GCDQueue executeInGlobalQueue:^{
//            [GCDQueue executeInMainQueue:^{
                UIFont *cellFont = [UIFont fontWithName:self.titleArray[indexPath.row] size:15.0f];
                cell.textLabel.font = cellFont;
//            }];
//        }];
    };
    
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        NSLog(@"当前点击的字体是：\n%@", self.titleArray[indexPath.row]);

        BAKitVC_UIFontDetailViewController *vc = [[BAKitVC_UIFontDetailViewController alloc] init];
        vc.font = self.titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = [UIFont ba_fontGetAllFamilyFontNames];
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
