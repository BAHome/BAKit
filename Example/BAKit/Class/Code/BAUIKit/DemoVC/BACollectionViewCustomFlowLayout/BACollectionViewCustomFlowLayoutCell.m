//
//  BACollectionViewCustomFlowLayoutCell.m
//  BAKit_Example
//
//  Created by 博爱 on 2021/1/19.
//  Copyright © 2021 boai. All rights reserved.
//

#import "BACollectionViewCustomFlowLayoutCell.h"

@interface BACollectionViewCustomFlowLayoutCell ()

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation BACollectionViewCustomFlowLayoutCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    [self.titleLabel ba_viewSetSystemCornerRadius:4];
}

- (void)initData {
    
}

#pragma mark - setter, getter

- (void)setModel:(BACollectionViewCustomFlowLayoutModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    self.titleLabel.font = model.titleFont;
    
    if (model.leftAndRightMargin > 0) {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.offset(model.leftAndRightMargin);
            make.right.offset(-model.leftAndRightMargin);
        }];
    }
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.backgroundColor = UIColor.yellowColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


@end
