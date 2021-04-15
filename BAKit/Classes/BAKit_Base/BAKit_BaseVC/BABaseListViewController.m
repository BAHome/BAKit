//
//  BABaseListViewController.m
//  BAKit
//
//  Created by boai on 2017/7/3.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BABaseListViewController.h"
#import "BAKit_Color.h"

#import "BAKit_UITableView.h"
#import "BAKit_RegularExpression.h"
#import "BAKit_DefineCommon.h"
#import "BAKit_DefineFrame.h"

#import "UIImage+BARender.h"
#import "UIView+BAFrame.h"
//#import "UIView+BAAnimation.h"

#import "UIImageView+WebCache.h"

static NSString * const kCellID = @"BABaseListViewControllerCell";

@interface BABaseListViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation BABaseListViewController

- (void)ba_base_viewWillAppear {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)ba_base_setupUI {
    self.view.backgroundColor = BAKit_Color_White;
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataArray) {
        return self.dataArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BABaseListViewSectionModel *sectionModel = self.dataArray[section];
    if (sectionModel) {
        return sectionModel.sectionDataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.tableView.ba_tableViewCellStyle) {
        self.tableView.ba_tableViewCellStyle = UITableViewCellStyleValue1;
    }
    UITableViewCell *cell = [UITableViewCell ba_cellDequeueFromIdentify:kCellID cellStyle:self.tableView.ba_tableViewCellStyle tableView:tableView];
    
    cell.backgroundColor = BAKit_Color_Clear;

    if (self.ba_tabelViewCellConfig_block) {
        self.ba_tabelViewCellConfig_block(tableView, indexPath, cell);
    }
    BABaseListViewSectionModel *sectionModel = self.dataArray[indexPath.section];
    BABaseListViewCellModel *model = sectionModel.sectionDataArray[indexPath.row];
    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    
    cell.textLabel.text = [msg stringByAppendingString:model.title];
    if (!model.detailString) {
        cell.textLabel.numberOfLines = 0;
    }
    if (self.ba_tableViewImageViewSize == 0) {
        self.ba_tableViewImageViewSize = 40;
    }
    if (model.imageName) {
        if ([BAKit_RegularExpression ba_regularIsUrl:model.imageName]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:BAKit_ImageName(@"publicNumber")];
        } else {
            cell.imageView.image = BAKit_ImageName(model.imageName);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGSize imageSize = CGSizeMake(self.ba_tableViewImageViewSize, self.ba_tableViewImageViewSize);
            
            if (self.ba_tableViewImageViewIsRound) {
                [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:cell.imageView.image imageSize:imageSize];
            } else {
                [UIImage ba_imageToChangeCellNormalImageViewSizeWithCell:cell image:cell.imageView.image imageSize:imageSize];
            }
        });
    }
    
    CGSize labelSize = BAKit_LabelSizeWithTextAndWidthAndFont(cell.textLabel.text, BAKit_SCREEN_WIDTH - cell.imageView.size.width, cell.textLabel.font);

    if (labelSize.height > BAKit_Margin_44) {
        cell.detailTextLabel.text = nil;
    } else {
        if ([model.detailString isKindOfClass:[NSString class]]) {
            cell.detailTextLabel.text = model.detailString;
        } else if (!BAKit_ObjectIsEmpty(model.detailString)) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", model.detailString];
        }
    }
    
//    cell.detailTextLabel.preferredMaxLayoutWidth = cell.width - cell.detailTextLabel.width - cell.imageView.width;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BABaseListViewSectionModel *model = self.dataArray[indexPath.section];

    if (self.ba_tabelViewDidSelectBlock) {
        self.ba_tabelViewDidSelectBlock(tableView, indexPath, model);
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.ba_tabelViewWillDisplayCell_block) {
        self.ba_tableViewIsNeedDefaultAnimation = NO;
        self.ba_tabelViewWillDisplayCell_block(tableView, indexPath, cell);
    }
    
    if (self.ba_tableViewIsNeedDefaultAnimation) {
        // 博爱专属动画 1
        cell.contentView.transform =  CGAffineTransformScale(cell.contentView.transform, 0.3f, 0.3f);
        [cell ba_animation_springWithDuration:0.8f delay:0.f damping:0.8f initialSpringVelocity:2 startOptions:UIViewAnimationOptionCurveEaseInOut finishOptions:UIViewAnimationOptionCurveEaseInOut startBlock:^{
            cell.contentView.transform = CGAffineTransformIdentity;
        } finishBlock:nil];
        
        // FB 动画
        //    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        //    scaleAnimation.toValue             = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        //    scaleAnimation.velocity            = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
        //    scaleAnimation.springBounciness    = 20.f;
        //    [cell pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
        
        /*! 博爱专属动画 2：卡片式动画 */
        //    static CGFloat initialDelay = 0.2f;
        //    static CGFloat stutter = 0.06f;
        //
        //    cell.contentView.transform =  CGAffineTransformMakeTranslation(BAKit_SCREEN_WIDTH, 0);
        //
        //    [cell ba_animation_springWithDuration:0.8f delay:(initialDelay + indexPath.row * stutter) damping:0.8f initialSpringVelocity:0 startOptions:UIViewAnimationOptionCurveEaseInOut finishOptions:UIViewAnimationOptionCurveEaseInOut startBlock:^{
        //        cell.contentView.transform = CGAffineTransformIdentity;
        //    } finishBlock:nil];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    BABaseListViewSectionModel *model = self.dataArray[section];
    if (!BAKit_stringIsBlank(model.sectionTitle)) {
        return BAKit_Margin_44;
    }
    return 0;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BABaseListViewSectionModel *model = self.dataArray[section];
    if (!BAKit_stringIsBlank(model.sectionTitle)) {
        UIView *headerView = [UIView new];
        [headerView ba_animation_createGradientWithColorArray:@[BAKit_Color_White, BAKit_Color_Green_LightGreen, BAKit_Color_Green, BAKit_Color_Green_LightGreen, BAKit_Color_White] frame:CGRectMake(0, 0, BAKit_SCREEN_WIDTH, BAKit_Margin_44) direction:UIViewLinearGradientDirectionHorizontal];
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = model.sectionTitle;
        titleLabel.frame = CGRectMake(20, 5, BAKit_SCREEN_WIDTH - 20 * 2, 30);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [headerView addSubview:titleLabel];
        return headerView;
    }
    return [UIView new];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - setter / getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Clear;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.tableFooterView = [UIView new];
        
        // table 的 默认配置
        BAKit_UITableViewSetEstimatedRowHeight(self.tableView, 44);
        self.ba_tableViewIsNeedDefaultAnimation = YES;

        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (void)setBa_tableViewIsNeedDefaultAnimation:(BOOL)ba_tableViewIsNeedDefaultAnimation {
    _ba_tableViewIsNeedDefaultAnimation = ba_tableViewIsNeedDefaultAnimation;
}



@end

@implementation BABaseListViewSectionModel

@end

@implementation BABaseListViewCellModel

@end

