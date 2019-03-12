//
//  BAKitVC_UINavigation2.m
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UINavigation2.h"

#import "BAKit_Color.h"
#import "BAKit_DefineFont.h"
#import "BAKit_DefineCommon.h"

@interface BAKitVC_UINavigation2 ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) BAKitVC_UINavigation2 *viewController;
@property(nonatomic, assign) BOOL customNavBarTransition;
@property(nonatomic, assign) BAKit_NavigationBarStyle navigationBarStyle;

@end

@implementation BAKitVC_UINavigation2

- (void)ba_base_viewWillAppear
{
    self.customNavBarTransition = self.customNavBarTransition && (self.navigationBarStyle != self.viewController.navigationBarStyle);


    if ([self.title isEqualToString:self.titleArray[0]])
    {
        [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:NO];
        [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_Black tintColor:BAKit_Color_White font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_White isNeedBottomLine:YES navigationController:self.navigationController];
    }
    else if ([self.title isEqualToString:self.titleArray[1]])
    {
        [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:YES];
        [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_White tintColor:BAKit_Color_Black font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_Black isNeedBottomLine:YES navigationController:self.navigationController];
        
//        BAKit_ImageName(@"navi_shadow")
    }
    else if ([self.title isEqualToString:self.titleArray[2]])
    {
        [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:YES];
        [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_Red tintColor:BAKit_Color_Green font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_White isNeedBottomLine:YES navigationController:self.navigationController];
    }
    else if ([self.title isEqualToString:self.titleArray[3]])
    {
        [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:YES];
        [BAKit_Helper ba_helperSetNaviBarBarTintColor:nil tintColor:nil font:BAKit_Font_systemFontOfSize_18 fontColor:nil isNeedBottomLine:YES navigationController:self.navigationController];
    }
}

- (void)ba_base_viewWillDisappear
{
    self.customNavBarTransition = self.customNavBarTransition && (self.navigationBarStyle != self.previousBarStyle);

    if (!self.customNavBarTransition)
    {
        [BAKit_Helper ba_helperSetNaviBarBarTintColor:BAKit_Color_Black tintColor:BAKit_Color_White font:BAKit_Font_systemFontOfSize_18 fontColor:BAKit_Color_White  isNeedBottomLine:YES navigationController:self.navigationController];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)initWithBarStyle:(BAKit_NavigationBarStyle)navigationBarStyle
{
    if (self = [super init]) {
        self.navigationBarStyle = navigationBarStyle;
    }
    return self;
}

- (NSString *)ba_setupNaviTitle
{
    return @"返回2";
}

- (void)ba_base_setupUI
{

    self.view.backgroundColor = BAKit_Color_White;
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        self.navigationBarStyle = indexPath.row;
        self.viewController = [[BAKitVC_UINavigation2 alloc] initWithBarStyle:self.navigationBarStyle];
        self.viewController.title = model.sectionDataArray[indexPath.row].title;
        if (self.customNavBarTransition)
        {
            self.viewController.previousBarStyle = self.navigationBarStyle;
            self.viewController.customNavBarTransition = YES;
        }
        [self.navigationController pushViewController:self.viewController animated:YES];
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
