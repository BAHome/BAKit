//
//  BABaseListViewController.h
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABaseViewController.h"

@class BABaseListViewSectionModel, BABaseListViewCellModel;

/**
 列表基类：cell 的点击事件 block

 @param tableView tableView description
 @param indexPath indexPath description
 @param model model description
 */
typedef void (^BABaseListViewController_didSelectBlock)(UITableView *tableView, NSIndexPath *indexPath, BABaseListViewSectionModel *model);

/**
 列表基类：cell 的自定义配置 block，例如：字体、颜色等可以在外部单独配置

 @param tableView tableView description
 @param indexPath indexPath description
 @param cell cell description
 */
typedef void (^BABaseListViewControllerCellConfig_block)(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell);

/**
 列表基类：cell 的 WillDisplay 配置 block，例如：cell 的动画等，注意：用此 block 后，self.ba_tableViewIsNeedDefaultAnimation = NO; 默认 cell 动画就默认为 NO 了1
 
 @param tableView tableView description
 @param indexPath indexPath description
 @param cell cell description
 */
typedef void (^BABaseListViewControllerWillDisplayCell_block)(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell);


@interface BABaseListViewController : BABaseViewController

/**
 列表基类：供外部调用的 tableView，注意：此封装用的是系统原生的控件（cell.textLabel、cell.imageView、cell.detailTextLabel），只适用于简单文字列表，如果复杂的 cell 就需要单独自定义了，所以要注意文字长度等相关信息，以免出现异常不适配
 */
@property(nonatomic, strong) UITableView *tableView;

/**
 列表基类：数据源，注意：里面必须传 BABaseListViewSectionModel，注意：此封装用的是系统原生的控件（cell.textLabel、cell.imageView、cell.detailTextLabel），只适用于简单文字列表，如果复杂的 cell 就需要单独自定义了，所以要注意文字长度等相关信息，以免出现异常不适配
 */
@property(nonatomic, strong) NSArray <BABaseListViewSectionModel *>*dataArray;

/**
 列表基类：设置 tableView 的背景图片，只需传 image 类型就可以，其他无需配置
 */
@property(nonatomic, strong) UIImage *ba_tableViewBackgroundImageView;

/**
 列表基类：设置 cell.imageView size，默认：40
 */
@property(nonatomic, assign) CGFloat ba_tableViewImageViewSize;

/**
 列表基类：设置 cell.imageView 是否是圆形，默认：NO
 */
@property(nonatomic, assign) BOOL ba_tableViewImageViewIsRound;

/**
 列表基类：设置 cell 是否需要默认动画，默认：YES
 */
@property(nonatomic, assign) BOOL ba_tableViewIsNeedDefaultAnimation;


@property(nonatomic, copy) BABaseListViewController_didSelectBlock ba_tabelViewDidSelectBlock;
@property(nonatomic, copy) BABaseListViewControllerCellConfig_block ba_tabelViewCellConfig_block;
@property(nonatomic, copy) BABaseListViewControllerWillDisplayCell_block ba_tabelViewWillDisplayCell_block;


@end

@interface BABaseListViewSectionModel : NSObject

/**
 列表基类：分区头
 */
@property(nonatomic, copy) NSString *sectionTitle;

/**
 列表基类：每个分区的数据，BABaseListViewCellModel
 */
@property(nonatomic, strong) NSArray <BABaseListViewCellModel *>*sectionDataArray;

@end

@interface BABaseListViewCellModel : NSObject

/**
 列表基类：cell.textLabel.text 数据，注意：此封装用的是系统原生的控件（cell.textLabel、cell.imageView、cell.detailTextLabel），只适用于简单文字列表，如果复杂的 cell 就需要单独自定义了，所以要注意文字长度等相关信息，以免出现异常不适配
 */
@property(nonatomic, copy) NSString *title;

/**
 列表基类：cell.imageView.image 数据，注意：此封装用的是系统原生的控件（cell.textLabel、cell.imageView、cell.detailTextLabel），只适用于简单文字列表，如果复杂的 cell 就需要单独自定义了，所以要注意文字长度等相关信息，以免出现异常不适配，
 此处可以自动识别 本地图像名字 和 URLstring 名字，只需将名字或者 URLstring 赋值即可！
 */
@property(nonatomic, copy) NSString *imageName;

/**
 列表基类：cell.detailTextLabel.text 数据，注意：此封装用的是系统原生的控件（cell.textLabel、cell.imageView、cell.detailTextLabel），只适用于简单文字列表，如果复杂的 cell 就需要单独自定义了，所以要注意文字长度等相关信息，以免出现异常不适配
 */
@property(nonatomic, copy) NSString *detailString;

@end
