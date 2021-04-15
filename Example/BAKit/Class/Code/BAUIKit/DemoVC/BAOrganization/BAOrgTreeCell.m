//
//  BAOrgTreeCell.m
//  BBB
//
//  Created by 孙博岩 on 2019/5/5.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAOrgTreeCell.h"
#import "BAOrgTreeModel.h"


#import "BAButton.h"
#import <Masonry.h>
#import <ReactiveObjC.h>

#define kLeftMargin 18
#define kCheckBtnWH 24

// 十六进制创建颜色
#define kColorWithHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kColorWithHexAlpha(hexValue,a) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:(a)]



@interface BAOrgTreeCell ()

@property (nonatomic,strong) NSMutableArray<UILabel *> *topShuLblList;

@property (nonatomic,strong) UILabel *hengLbl;

@property (nonatomic,strong) UILabel *bottomShuLbl;

@property (nonatomic,strong) UILabel *textLbl;

@property (nonatomic,strong) UIButton *checkBtn;

@property (nonatomic,strong) UILabel *seperateLineLbl;

//@property (nonatomic,strong) UIButton *shouqiBtn;

@end

@implementation BAOrgTreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = UIColor.clearColor;
    
    [self.contentView addSubview:self.checkBtn];
    //    self.checkBtn.backgroundColor = UIColor.redColor;
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kLeftMargin);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(kCheckBtnWH, kCheckBtnWH));
    }];
    
    [self.contentView addSubview:self.textLbl];
    [self.textLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.checkBtn.mas_right).offset(8);
        make.centerY.offset(0);
        make.width.mas_equalTo(200);
    }];
    
    [self.contentView addSubview:self.hengLbl];
    self.hengLbl.hidden = YES;
    [self.hengLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        //先占位
    }];
    
    
    [self.contentView addSubview:self.bottomShuLbl];
    [self.bottomShuLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkBtn.mas_bottom);
        make.centerX.equalTo(self.checkBtn.mas_centerX);
        make.width.mas_equalTo(1);
        make.bottom.offset(0.2);
    }];
    
    [self.contentView addSubview:self.seperateLineLbl];
    [self.seperateLineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLbl.mas_left);
        make.bottom.offset(0);
        make.height.mas_equalTo(1);
        make.right.offset(-16);
    }];
    
    
    [self.contentView addSubview:self.shouqiBtn];
//    self.shouqiBtn.backgroundColor = UIColor.redColor;
    [self.shouqiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.top.bottom.offset(0);
        make.width.mas_equalTo(40 + 8 + 8 + 8 + 8);
    }];
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bottomShuLbl.hidden = _model.belowCount == 0;
    self.shouqiBtn.selected = _model.zhankai;
    
}
#pragma mark - Setter Getter

- (void)setModel:(BAOrgTreeModel *)model {
    _model = model;
    
    self.textLbl.text = model.name;
    self.checkBtn.selected = _model.selected;
    self.bottomShuLbl.hidden = _model.belowCount == 0;
    
    if (model.level == 0) {
        [self.shouqiBtn setTitle:@"全部展开" forState:UIControlStateNormal];
        [self.shouqiBtn setTitle:@"全部收起" forState:UIControlStateSelected];
        self.shouqiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 12);
        self.shouqiBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, -45);
    } else {
        [self.shouqiBtn setTitle:@"" forState:UIControlStateNormal];
        [self.shouqiBtn setTitle:@"" forState:UIControlStateSelected];
        self.shouqiBtn.titleEdgeInsets = UIEdgeInsetsZero;
        self.shouqiBtn.imageEdgeInsets = UIEdgeInsetsZero;
    }
    self.shouqiBtn.hidden = !(model.referList.count > 0);
    self.shouqiBtn.selected = model.zhankai;
    
    for (UILabel *line in self.topShuLblList) {
        [line removeFromSuperview];
    }
    [self.topShuLblList removeAllObjects];
    for (NSInteger i = 0; i < _model.level; i++) {
        UILabel *line = [UILabel new];
        line.backgroundColor = kColorWithHexAlpha(0x90FFBE, 0.35);
        [self addSubview:line];
        [self.topShuLblList addObject:line];
    }
    
    //重新设置layout
    if (_model.level == 0) {
        self.hengLbl.hidden = YES;
        [self.checkBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(kLeftMargin);
            make.centerY.offset(0);
            make.size.mas_equalTo(CGSizeMake(kCheckBtnWH, kCheckBtnWH));
        }];
    } else {
        self.hengLbl.hidden = NO;
        if (self.topShuLblList.count > 0) {
            for (NSInteger i = 0; i < self.topShuLblList.count; i++) {
                UILabel *line = self.topShuLblList[i];
                [line mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(kLeftMargin + (kCheckBtnWH - 1) * 0.5 + i * (12 + (kCheckBtnWH - 1) * 0.5) + i * 1);
                    make.top.offset(0);
                    make.width.mas_equalTo(1);
                    make.bottom.offset(0);
                }];
            }
            
            UILabel * lastTopLine = self.topShuLblList.lastObject;
            if (_model.supermodel.referList.lastObject == _model) {
                [lastTopLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(kLeftMargin + (kCheckBtnWH - 1) * 0.5 + (self.topShuLblList.count - 1) * (12 + (kCheckBtnWH - 1) * 0.5) + (self.topShuLblList.count - 1) * 1);
                    //                make.centerX.offset(kLeftMargin + (kCheckBtnWH - 0) * 0.5 + (self.topShuLblList.count - 1) * (12 + (kCheckBtnWH - 0) * 0.5));
                    make.top.offset(0);
                    make.width.mas_equalTo(1);
                    make.height.equalTo(self.mas_height).multipliedBy(0.5);
                }];
            }
            
            [self.hengLbl mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastTopLine.mas_right);
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(12, 1));
            }];
            
            [self.checkBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.hengLbl.mas_right);
                make.centerY.offset(0);
                make.size.mas_equalTo(CGSizeMake(kCheckBtnWH, kCheckBtnWH));
            }];
        }
        
    }
    
    if (_model.level > 1) {
        BAOrgTreeModel *copyModel = _model;
        for (NSInteger i = 0; i < _model.level - 1; i++) {
            BAOrgTreeModel *superModel = copyModel.supermodel;
            if (superModel.supermodel.referList.lastObject == superModel) {
                self.topShuLblList[copyModel.level - 2].hidden = YES;
            }
            copyModel = superModel;
        }
    }
    
}

- (NSMutableArray<UILabel *> *)topShuLblList{
    if(_topShuLblList == nil){
        _topShuLblList = [@[] mutableCopy];
    }
    return _topShuLblList;
}

- (UILabel *)textLbl {
    if (_textLbl == nil) {
        _textLbl = [UILabel new];
        _textLbl.textColor = UIColor.whiteColor;
        _textLbl.font = [UIFont systemFontOfSize:14 weight:UIFontWeightSemibold];
    }
    return _textLbl;
}

- (UIButton *)checkBtn {
    if (_checkBtn == nil) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"org_unselect"] forState:UIControlStateNormal];
        [_checkBtn setImage:[UIImage imageNamed:@"org_select"] forState:UIControlStateSelected];
        _checkBtn.userInteractionEnabled = NO;
    }
    return _checkBtn;
}

- (UILabel *)hengLbl {
    if (_hengLbl == nil) {
        _hengLbl = [UILabel new];
        _hengLbl.backgroundColor = kColorWithHexAlpha(0x90FFBE, 0.35);
    }
    return _hengLbl;
}

- (UILabel *)bottomShuLbl {
    if (_bottomShuLbl == nil) {
        _bottomShuLbl = [UILabel new];
        _bottomShuLbl.backgroundColor = kColorWithHexAlpha(0x90FFBE, 0.35);
    }
    return _bottomShuLbl;
}

- (UILabel *)seperateLineLbl {
    if (_seperateLineLbl == nil) {
        _seperateLineLbl = [UILabel new];
        _seperateLineLbl.backgroundColor = kColorWithHexAlpha(0x90FFBE, 0.35);
    }
    return _seperateLineLbl;
}

- (UIButton *)shouqiBtn {
    if (_shouqiBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"全部展开" forState:UIControlStateNormal];
        [btn setTitle:@"全部收起" forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"org_arrow_down"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"org_arrow_up"] forState:UIControlStateSelected];
        [btn setTitleColor:kColorWithHexAlpha(0x90FFBE,0.8) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightSemibold];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.shouqiBlock(self.shouqiBtn, self.model);
        }];
        _shouqiBtn = btn;
    }
    return _shouqiBtn;
}

@end


