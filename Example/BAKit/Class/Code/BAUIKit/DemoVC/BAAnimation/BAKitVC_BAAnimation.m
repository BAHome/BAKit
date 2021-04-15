//
//  BAKitVC_BAAnimation.m
//  BAKit
//
//  Created by boai on 2017/7/8.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BAAnimation.h"
#import "BAKitVC_BasicAnimation.h"
#import "BAKitVC_CABasicAnimation.h"
#import "BAKitVC_CABasicAnimation2.h"
#import "BAKitVC_CATransition.h"
#import "BAKitVC_ScaleAnimation.h"

@interface BAKitVC_BAAnimation ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAKitVC_BAAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ba_base_setupUI {
    self.title = @"BAAnimation";
    self.view.backgroundColor = BAKit_Color_White;
    self.tableView.sectionImage = BAKit_ImageName(@"tabHengxian");

    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        
        if (indexPath.section == 0) {
            BAKitVC_BasicAnimation *vc = [BAKitVC_BasicAnimation new];
            vc.animationType = indexPath.row;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0)
            {
                [self.navigationController pushViewController:[BAKitVC_CABasicAnimation new] animated:YES];
            }
            else if (indexPath.row == model.sectionDataArray.count - 1)
            {
                BAKitVC_ScaleAnimation *vc = [BAKitVC_ScaleAnimation new];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                BAKitVC_CABasicAnimation2 *vc = [BAKitVC_CABasicAnimation2 new];
                vc.title = model.sectionDataArray[indexPath.row].title;
                vc.animationType = indexPath.row;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
        else if (indexPath.section == 2) {
            BAKitVC_CATransition *vc = [BAKitVC_CATransition new];
            vc.title = model.sectionDataArray[indexPath.row].title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    };
}

- (NSMutableArray *)mutableDataArray {
    if (!_mutableDataArray) {
        _mutableDataArray = @[].mutableCopy;
        
        NSArray *sectionTitleArray = @[
                                       @"UIView 基本动画",
                                       @"CABasicAnimation 核心动画",
                                       @"CATransition 转场动画",
                                       @"CAKeyframeAnimation 关键帧动画",
                                       @"其他动画"
                                       ];
        NSArray <NSArray *>*titleArray = @[
                                 @[
                                     @"大小变化【改变 frame】",
                                     @"拉伸变化【改变 bounds】",
                                     @"中心位置【改变 center】",
                                     @"透明度  【改变 alpha】",
                                     @"弹簧 Spring 动画",
                                     @"背景颜色【改变 backgroundColor】",
                                     @"缩放动画"
                                 ],
                                 @[
                                     @"CABasicAnimation",
                                     @"无限次闪烁动画",
                                     @"有限次闪烁动画",
                                     @"缩放动画",
                                     @"缩放动画 X",
                                     @"缩放动画 Y",
                                     @"横向移动动画 X",
                                     @"纵向移动动画 Y",
                                     @"旋转动画 ",
                                     @"旋转动画 X",
                                     @"旋转动画 Y",
                                     @"旋转动画 Z",
                                     @"缩放动画示例"
                                   ],
                                 @[@"CATransition 转场动画合集"],
                                 @[],
                                 @[]
                                 ];

        //        NSArray *detailArray = @[@"图上文下1", @"两行文字2"];
        //        NSArray *imageArray = @[@"tabbar_contactsHL", @"tabbar_contactsHL"];
        
        for (NSInteger i = 0; i < sectionTitleArray.count; i ++) {
            BABaseListViewSectionModel *sectionModel = [BABaseListViewSectionModel new];
            sectionModel.sectionTitle = sectionTitleArray[i];
            NSMutableArray *cellModelArray = @[].mutableCopy;

            for (NSInteger j = 0; j < titleArray[i].count; j ++)
            {
                BABaseListViewCellModel *cellModel = [BABaseListViewCellModel new];

                cellModel.title = titleArray[i][j];
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
