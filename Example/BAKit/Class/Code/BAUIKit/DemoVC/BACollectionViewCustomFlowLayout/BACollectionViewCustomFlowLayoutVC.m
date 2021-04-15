//
//  BACollectionViewCustomFlowLayoutVC.m
//  BAKit_Example
//
//  Created by 博爱 on 2021/1/18.
//  Copyright © 2021 boai. All rights reserved.
//

#import "BACollectionViewCustomFlowLayoutVC.h"
#import "BACollectionViewCustomFlowLayout.h"
#import "BACollectionViewCustomFlowLayoutModel.h"
#import "BACollectionViewCustomFlowLayoutCell.h"

@interface BACollectionViewCustomFlowLayoutVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) BACollectionViewCustomFlowLayout *layout;

@property(nonatomic, strong) NSArray *dataArray;

@property(nonatomic, strong) UIView *tabView;

@end

@implementation BACollectionViewCustomFlowLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self initData];
}

- (void)initView {
    
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.top.mas_equalTo(self.tabView.mas_bottom).offset(0);
    }];
    
}

- (void)initData {
    
    NSArray *titleArray = @[@"sakfs看时间爱福家",
                            @"阿可使肌肤",
                            @"啊啊",
                            @"大福晶科技",
                            @"多斯拉克街坊邻居",
                            @"飒飒",
                            @"艾师傅",
                            @"阿斯蒂芬",
                            @"嗄",
                            @"的解放军",
                            @"ie若破位人i",
                            @"啥附加按键精灵",
                            @"z.mv.zm;s;afk",
                            @"飒飒",
                            @"了我iO我人气颇IE容器我",
                            @"阿斯蒂芬",
                            @"嗄",
                            @"的解放军",
                            @"；看；来看；i",
                            @"啥附加精灵",
                            @"担惊受恐",];
    
    NSMutableArray *tempArray = @[].mutableCopy;
    for (NSInteger i = 0; i < titleArray.count; ++i) {
        BACollectionViewCustomFlowLayoutModel *model = BACollectionViewCustomFlowLayoutModel.new;
        NSString *title = titleArray[i];
        model.title = title;
        model.titleFont = [UIFont systemFontOfSize:14];
        model.itemHeight = 40;
        model.leftAndRightMargin = 6;
        
        [tempArray addObject:model];
    }
    self.dataArray = tempArray.mutableCopy;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.dataArray.count;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BACollectionViewCustomFlowLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BACollectionViewCustomFlowLayoutCell.description forIndexPath:indexPath];
    
    BACollectionViewCustomFlowLayoutModel *model = self.dataArray[indexPath.item];
    cell.model = model;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BACollectionViewCustomFlowLayoutModel *model = self.dataArray[indexPath.item];
    return model.itemSize;
}

#pragma mark - setter, getter

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        BACollectionViewCustomFlowLayout *layout = BACollectionViewCustomFlowLayout.new;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.layout = layout;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = UIColor.whiteColor;
        
        [_collectionView registerClass:BACollectionViewCustomFlowLayoutCell.class forCellWithReuseIdentifier:BACollectionViewCustomFlowLayoutCell.description];
    }
    return _collectionView;
}

- (UIView *)tabView {
    if (!_tabView) {
        _tabView = UIView.new;
        _tabView.backgroundColor = UIColor.yellowColor;
        
        NSArray *array = @[@"居左",
                           @"居中",
                           @"居右"];
        NSMutableArray <UIButton *>*buttonArray = @[].mutableCopy;
        for (NSInteger i = 0; i < array.count; ++i) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
            button.backgroundColor = UIColor.greenColor;
            button.tag = i;
            [_tabView addSubview:button];
            [buttonArray addObject:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.left.offset(10);
                } else {
                    make.left.mas_equalTo(buttonArray[i-1].mas_right).offset(10);
                }
                make.width.mas_equalTo(BAKit_SCREEN_WIDTH/3.0);
                make.height.mas_equalTo(40);
            }];
            
            BAKit_WeakSelf
            button.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
                BAKit_StrongSelf
                if (button.tag == 0) {
                    self.layout.flowLayoutType = kBACollectionViewCustomFlowLayoutType_Left;
                } else if (button.tag == 1) {
                    self.layout.flowLayoutType = kBACollectionViewCustomFlowLayoutType_Center;
                } else if (button.tag == 2) {
                    self.layout.flowLayoutType = kBACollectionViewCustomFlowLayoutType_Right;
                }
                self.collectionView.collectionViewLayout = self.layout;
                [self.collectionView reloadData];
            };
        }
    }
    return _tabView;
}


@end
