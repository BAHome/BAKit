//
//  BAKitVC_HUD.m
//  BAKit_Example
//
//  Created by 孙博岩 on 2019/2/26.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAKitVC_HUD.h"


static NSString * const kTitle = @"加载中...";

@interface BAKitVC_HUD ()

@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *classNamesArray;
@property (nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAKitVC_HUD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI {
    [self ba_creatData];
    
    
    self.tableView.backgroundColor = BAKit_Color_Clear;
//    self.tableView.sectionImage = BAKit_ImageName(@"table_section");
    
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15.0f];
        cell.backgroundColor = BAKit_Color_Clear;
    };
    
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
        
        switch (indexPath.row) {
            case 0:
            {
                [self hud_showLoadingView];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self hud_dismiss];
                });
            }
                break;
            case 1:
            {
//                [self hud_showLoadingViewOnView:self.view1];
                
            }
                break;
            case 2:
            {
                [self hud_showLoadingViewWithStatus:kTitle onView:self.view];
                [self dismiss];
            }
                break;
            case 3:
            {
                [self hud_showInfoWithStatus:kTitle];
                
            }
                break;
            case 4:
            {
                [self hud_showSuccessWithStatus:kTitle];
                
            }
                break;
            case 5:
            {
                [self hud_showErrorWithStatus:kTitle];
                
            }
                break;
            case 6:
            {
                [self hud_showImage:[UIImage imageNamed:@"weather_snow"] status:nil];
                
            }
                break;
            case 7:
            {
                [self hud_showGifImage:@"chick" status:kTitle];
            }
                break;
            case 8:
            {
                [self hud_showToastStatus:kTitle];
            }
                break;
                
            default:
                break;
        }
    };
    
}

- (void)dismiss {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hud_dismiss];
    });
}

- (void)ba_creatData {
    
    [self ba_addCellWithTitle:@"hud_showLoadingView"];
    [self ba_addCellWithTitle:@"hud_showLoadingViewOnView"];
    [self ba_addCellWithTitle:@"hud_showLoadingViewWithStatus"];
    [self ba_addCellWithTitle:@"hud_showInfoWithStatus"];
    [self ba_addCellWithTitle:@"hud_showSuccessWithStatus"];
    [self ba_addCellWithTitle:@"hud_showErrorWithStatus"];
    [self ba_addCellWithTitle:@"hud_showImage"];
    [self ba_addCellWithTitle:@"hud_showGifImage"];
    [self ba_addCellWithTitle:@"hud_showToastStatus"];
    
}

- (void)ba_addCellWithTitle:(NSString *)title {
    [self.titlesArray addObject:title];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    BAKit_UITableViewSetSeparator(self.tableView, BAKit_Color_Cyan, UIEdgeInsetsMake(0, 0, 0, 0));
    [self.view ba_animation_createGradientWithColorArray:@[BAKit_Color_Green_LightGreen, BAKit_Color_White] frame:self.view.bounds direction:UIViewLinearGradientDirectionVertical];
}

#pragma mark - setter, getter
- (NSMutableArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = @[].mutableCopy;
    }
    return _titlesArray;
}

- (NSMutableArray *)classNamesArray {
    if (!_classNamesArray) {
        _classNamesArray = @[].mutableCopy;
    }
    return _classNamesArray;
}

- (NSMutableArray *)mutableDataArray {
    if (!_mutableDataArray) {
        _mutableDataArray = @[].mutableCopy;
        
        NSArray *sectionTitleArray = @[@""];
        
        //        NSArray *detailArray = @[@"图上文下1", @"两行文字2"];
        //        NSArray *imageArray = @[@"tabbar_contactsHL", @"tabbar_contactsHL"];
        
        for (NSInteger i = 0; i < sectionTitleArray.count; i ++) {
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
