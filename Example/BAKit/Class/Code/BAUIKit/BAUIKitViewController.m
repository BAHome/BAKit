//
//  BAUIKitViewController.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAUIKitViewController.h"

@interface BAUIKitViewController ()

@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *classNamesArray;
@property (nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAUIKitViewController

- (void)ba_base_viewWillAppear
{
    NSLog(@"BAUIKitViewController：%s", __func__);
}

- (void)ba_base_viewDidDAppear
{
    NSLog(@"BAUIKitViewController：%s", __func__);
}

- (void)ba_base_viewWillDisappear
{
    NSLog(@"BAUIKitViewController：%s", __func__);
}

- (void)ba_base_viewDidDisappear
{
    NSLog(@"BAUIKitViewController：%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ba_base_setupUI
{
    [self ba_creatData];

    
    self.tableView.backgroundColor = BAKit_Color_Clear;
    self.tableView.sectionImage = BAKit_ImageName(@"table_section");
    
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15.0f];
        cell.backgroundColor = BAKit_Color_Clear;
    };
    
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        
        [self hud_showInfoWithStatus:@"加载中..."];
        NSString *className = self.classNamesArray[indexPath.row];
        Class class = NSClassFromString(className);
        if (class)
        {
            UIViewController *vc = class.new;
            vc.title = self.titlesArray[indexPath.row];
    
            [self.navigationController pushViewController:vc animated:YES];
            [self hud_dismissWithDelay:2];
        }
    };
    
}

- (void)ba_creatData
{
    
    [self ba_addCellWithTitle:@"HUD" className:@"BAKitVC_HUD"];
    [self ba_addCellWithTitle:@"LOTAnimationView" className:@"BAKitVC_LOTAnimationView"];
    [self ba_addCellWithTitle:@"UIWindow" className:@"BAKitVC_UIWindow"];
    [self ba_addCellWithTitle:@"UIImageView" className:@"BAKitVC_UIImageView"];
    [self ba_addCellWithTitle:@"TestVC1" className:@"TestVC1"];
    [self ba_addCellWithTitle:@"BABadgeValueView" className:@"BAKitVC_BadgeValueView"];
    [self ba_addCellWithTitle:@"UITableView" className:@"BAKitVC_UITableView"];
    [self ba_addCellWithTitle:@"UILabel" className:@"BAKitVC_UILabel"];
    [self ba_addCellWithTitle:@"UIFont" className:@"BAKitVC_UIFont"];
    [self ba_addCellWithTitle:@"BAAnimation" className:@"BAKitVC_BAAnimation"];
    [self ba_addCellWithTitle:@"UITextView" className:@"BAKitVC_UITextView"];
    [self ba_addCellWithTitle:@"UITextField" className:@"BAKitVC_UITextField"];
    [self ba_addCellWithTitle:@"BAGridView" className:@"BAKitVC_BAGridView"];
    [self ba_addCellWithTitle:@"BAWKWebView" className:@"BAKitVC_WKWebView"];
    [self ba_addCellWithTitle:@"BAAlertController" className:@"BAKitVC_UIAlertController"];
    [self ba_addCellWithTitle:@"BAButton" className:@"BAKitVC_BAButton"];
    [self ba_addCellWithTitle:@"BAAlert" className:@"BAKitVC_BAAlert"];
    [self ba_addCellWithTitle:@"BAPickView" className:@"BAKitVC_BAPickView"];
    [self ba_addCellWithTitle:@"BAColor" className:@"BAKitVC_BAColor"];
    [self ba_addCellWithTitle:@"BAContact" className:@"BAKitVC_BAContact"];
    [self ba_addCellWithTitle:@"PhotoKitManager" className:@"BAKitVC_PhotoKitManager"];
    [self ba_addCellWithTitle:@"UINavigation" className:@"BAKitVC_UINavigation"];
    
}

- (void)ba_addCellWithTitle:(NSString *)title className:(NSString *)className
{
    [self.titlesArray addObject:title];
    [self.classNamesArray addObject:className];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
        
    BAKit_UITableViewSetSeparator(self.tableView, BAKit_Color_Cyan, UIEdgeInsetsMake(0, 0, 0, 0));
    [self.view ba_animation_createGradientWithColorArray:@[BAKit_Color_Green_LightGreen, BAKit_Color_White] frame:self.view.bounds direction:UIViewLinearGradientDirectionVertical];
}

#pragma mark - setter / getter
- (NSMutableArray *)titlesArray
{
    if (!_titlesArray)
    {
        _titlesArray = @[].mutableCopy;
    }
    return _titlesArray;
}

- (NSMutableArray *)classNamesArray
{
    if (!_classNamesArray)
    {
        _classNamesArray = @[].mutableCopy;
    }
    return _classNamesArray;
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
                for (NSInteger j = 0; j < self.titlesArray.count; j ++)
                {
                    BABaseListViewCellModel *cellModel = [BABaseListViewCellModel new];
                    cellModel.title = self.titlesArray[j];
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
