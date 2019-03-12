//
//  UITableView+BAKit.h
//  BAKit
//
//  Created by boai on 2017/7/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BAKit)

/**
 UITableView 背景图片
 */
@property(nonatomic, strong) UIImage *ba_tableViewBackgroundImage;

/**
 UITableViewCell：样式
 */
@property(nonatomic, assign) UITableViewCellStyle ba_tableViewCellStyle;


@end

/**
 UITableView：分割线：color、separatorInset
 
 @param tableView tableView description
 @param color color description
 @param separatorInset separatorInset description
 */
CG_INLINE void
BAKit_UITableViewSetSeparator(UITableView *tableView, UIColor *color, UIEdgeInsets separatorInset)
{
    [tableView setSeparatorColor:color];
    [tableView setSeparatorInset:separatorInset];
}

/**
 UITableView：背景图片
 
 @param tableView tableView description
 @param image 背景图片
 */
CG_INLINE void
BAKit_UITableViewSetBackgroundImage(UITableView *tableView, UIImage *image)
{
    tableView.ba_tableViewBackgroundImage = image;
}

/**
 UITableView：默认纯文字自适应高度
 
 @param tableView tableView description
 @param estimatedRowHeight 估计行高
 */
CG_INLINE void
BAKit_UITableViewSetEstimatedRowHeight(UITableView *tableView, CGFloat estimatedRowHeight)
{
    tableView.estimatedRowHeight = estimatedRowHeight;
    
    tableView.rowHeight = UITableViewAutomaticDimension;
}

/**
 UITableView：适配 iOS 11
 
 @param tableView tableView description
 */
CG_INLINE void
BAKit_UITableViewAdaptatIOS11(UITableView *tableView)
{
    if (@available(iOS 11.0, *))
    {
        tableView.estimatedRowHeight = 0.f;
        tableView.estimatedSectionHeaderHeight = 0.f;
        tableView.estimatedSectionFooterHeight = 0.f;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
    }
}

/**
 UITableView：注册 cell
 
 @param tableView tableView description
 @param isNib isNib description
 @param cellClass cellClass description
 @param reuseIdentifier reuseIdentifier description
 */
CG_INLINE void
BAKit_UITableViewRegisterCell(UITableView *tableView, BOOL isNib, Class cellClass, NSString *reuseIdentifier)
{
    if (isNib)
    {
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    }
    else
    {
        [tableView registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
    }
}

