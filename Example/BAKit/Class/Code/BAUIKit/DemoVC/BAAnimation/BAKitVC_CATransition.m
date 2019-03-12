//
//  BAKitVC_CATransition.m
//  BAKit
//
//  Created by boai on 2017/7/13.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_CATransition.h"

@interface BAKitVC_CATransition ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property(nonatomic, strong) NSArray *titleArray;

@end

@implementation BAKitVC_CATransition

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.dataArray = [self.mutableDataArray mutableCopy];
    [self ba_changeBackgroundImageWithImageName:@"test6"];

    BAKit_WeakSelf
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        
        BAKitVC_CATransition *vc = [BAKitVC_CATransition new];
        vc.title = self.titleArray[indexPath.row];
        /*! 转场动画 */
        [self ba_animationWithBATransitionType:indexPath.row animationView:self.navigationController.view];
        [self.navigationController pushViewController:vc animated:YES];
    };
}

- (void)ba_changeBackgroundImageWithImageName:(NSString *)imageName
{
    BAKit_UITableViewSetBackgroundImage(self.tableView, BAKit_ImageName(imageName));
}

#pragma mark - setter getter
- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"淡化效果",
                         @"Push效果",
                         @"揭开效果",
                         @"覆盖效果",
                         @"3D立方效果",
                         @"吮吸效果",
                         @"翻转效果",
                         @"波纹效果",
                         @"翻页效果",
                         @"反翻页效果",
                         @"开镜头效果",
                         @"关镜头效果",
                         @"下翻页效果",
                         @"上翻页效果",
                         @"左翻转效果",
                         @"右翻转效果"];
    }
    return _titleArray;
}

- (NSMutableArray *)mutableDataArray
{
    if (!_mutableDataArray)
    {
        _mutableDataArray = @[].mutableCopy;
        
        NSArray *sectionTitleArray = @[@""];
        
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
