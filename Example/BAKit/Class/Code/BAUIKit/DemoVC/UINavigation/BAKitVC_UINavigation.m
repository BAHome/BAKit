//
//  BAKitVC_UINavigation.m
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UINavigation.h"
#import "BAKitVC_UINavigation2.h"

#import "BAKit_Color.h"
#import "BAKit_DefineFont.h"
#import "BAKit_DefineCommon.h"

@interface BAKitVC_UINavigation ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property(nonatomic, strong) NSArray *titleArray;

@end

@implementation BAKitVC_UINavigation

- (void)ba_base_viewWillAppear
{
    [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:NO];
    [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_Black tintColor:BAKit_Color_White font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_White isNeedBottomLine:YES navigationController:self.navigationController];
}

- (void)ba_base_viewWillDisappear
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSString *)ba_setupNaviTitle
{
    return @"返回";
}

- (void)ba_base_setupUI
{
    self.title = @"自定义 navi ";
    self.view.backgroundColor = BAKit_Color_White;
    self.dataArray = [self.mutableDataArray mutableCopy];

    BAKit_WeakSelf
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        BAKitVC_UINavigation2 *vc = [[BAKitVC_UINavigation2 alloc] init];
        vc.title = model.sectionDataArray[indexPath.row].title;
        vc.previousBarStyle = indexPath.row;
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"自定义 navi 黑色背景", @"自定义 navi 白色背景", @"自定义 返回按钮文字", @"原生 navi"];;
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
