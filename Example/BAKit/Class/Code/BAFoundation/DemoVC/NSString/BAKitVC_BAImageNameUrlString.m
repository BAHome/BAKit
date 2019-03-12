//
//  BAKitVC_BAImageNameUrlString.m
//  BAKit
//
//  Created by boai on 2017/8/24.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BAImageNameUrlString.h"


#define kImageViewSize 40

@interface BAKitVC_BAImageNameUrlString ()

@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *userImageNamesArray;

@property (nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAKitVC_BAImageNameUrlString

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)ba_base_setupUI
{
    
    self.tableView.backgroundColor = BAKit_Color_Clear;
    self.dataArray = [self.mutableDataArray mutableCopy];
    
//    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
//        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15.0f];
//        cell.backgroundColor = BAKit_Color_Clear;
//    };
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.ba_tableViewImageViewSize = kImageViewSize;
    
    BAKit_UITableViewSetSeparator(self.tableView, BAKit_Color_Cyan, UIEdgeInsetsMake(0, 0, 0, 0));
    [self.view ba_animation_createGradientWithColorArray:@[BAKit_Color_Pink_WaterPink, BAKit_Color_White] frame:self.view.bounds direction:UIViewLinearGradientDirectionVertical];
}

#pragma mark - setter / getter
- (NSArray *)titlesArray
{
    if (!_titlesArray)
    {
        _titlesArray = @[@"boai", @"博爱", @"tom", @"子丰"];
    }
    return _titlesArray;
}

- (NSMutableArray *)userImageNamesArray
{
    if (!_userImageNamesArray)
    {
        _userImageNamesArray = @[].mutableCopy;
        
        [self.titlesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *userImageName = [NSString ba_stringDefaultUserPortraitWithUserName:obj userId:@(idx + 100).stringValue imageSize:kImageViewSize backgroundColor:nil];
            [self.userImageNamesArray addObject:userImageName];
        }];
    }
    return _userImageNamesArray;
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
                    cellModel.imageName = self.userImageNamesArray[j];
                    //            cellModel.detailString = detailArray[j];
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
