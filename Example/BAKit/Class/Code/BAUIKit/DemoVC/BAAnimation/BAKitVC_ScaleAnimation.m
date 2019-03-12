//
//  BAKitVC_ScaleAnimation.m
//  BAKit
//
//  Created by boai on 2017/7/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_ScaleAnimation.h"
#import "BAScaleAnimationView.h"

#import "BAKit_DefineFrame.h"

@interface BAKitVC_ScaleAnimation ()

@property(nonatomic, strong) NSMutableArray *mutableDataArray;
@property(nonatomic, strong) NSArray *titleArray;

@property(nonatomic, strong) BAScaleAnimationView *animationView;

@end

@implementation BAKitVC_ScaleAnimation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.title = @"下拉动画";
    
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    _animationView = [[BAScaleAnimationView alloc] initWithFrame:CGRectMake(0, -200, BAKit_SCREEN_WIDTH, 200)];
    [self.tableView addSubview:_animationView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"offset is %f", self.tableView.contentOffset.y);
    
    CGFloat delta = 8./-150;
    
    if (self.tableView.contentOffset.y > -150)
    {
        _animationView.progress = self.tableView.contentOffset.y * delta;
    }
    else
    {
        _animationView.progress = 8.0f;
    }
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"111111111", @"222222", @"33333"];;
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
