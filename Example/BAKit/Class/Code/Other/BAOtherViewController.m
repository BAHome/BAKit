//
//  BAOtherViewController.m
//  BAKit
//
//  Created by boai on 2017/6/7.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAOtherViewController.h"


@interface BAOtherViewController ()

@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *classNamesArray;
@property (nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)ba_base_setupUI {
    [self ba_creatData];
    
    NSString *nilStr = nil;
//    NSArray *array = @[@"chenfanfang", nilStr];
    NSArray *array = @[@"chenfanfang"];
//    NSString *a = array[2];
    
    self.tableView.backgroundColor = BAKit_Color_Clear;
    self.tableView.tableFooterView = [UIView new];
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    BAKit_WeakSelf
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        
        cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:15.0f];
        cell.backgroundColor = BAKit_Color_Clear;
    };
    
    self.ba_tabelViewDidSelectBlock = ^(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model) {
        BAKit_StrongSelf
//
//        BOOL isId = [BAKit_RegularExpression ba_regularIsIdCardNumberQualified:@"330226200107170016"];
//        NSString *msg = @"";
//        if (isId)
//        {
//            msg = @"正确";
//        }
//        else
//        {
//            msg = @"错误";
//        }
//        BAKit_ShowAlertWithMsg_ios8(msg)
        
        NSString *className = self.classNamesArray[indexPath.row];
        Class class = NSClassFromString(className);
        if (class) {
            UIViewController *vc = class.new;
            vc.title = self.titlesArray[indexPath.row];

            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}

- (void)ba_creatData {
    
    [self ba_addCellWithTitle:@"DeviceInfoManager" className:@"BAKitVC_DeviceInfoManager"];
    
    [self ba_addCellWithTitle:@"test" className:@""];

}

- (void)ba_addCellWithTitle:(NSString *)title className:(NSString *)className {
    [self.titlesArray addObject:title];
    [self.classNamesArray addObject:className];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
        
    BAKit_UITableViewSetSeparator(self.tableView, BAKit_Color_Orange, UIEdgeInsetsMake(0, 0, 0, 0));
    [self.view ba_animation_createGradientWithColorArray:@[BAKit_Color_Blue_SkyBlue, BAKit_Color_White] frame:self.view.bounds direction:UIViewLinearGradientDirectionVertical];
}

#pragma mark - setter / getter
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
