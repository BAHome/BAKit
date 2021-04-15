//
//  BAKitVC_OrgTree.m
//  BBB
//
//  Created by 孙博岩 on 2019/3/29.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAKitVC_OrgTree.h"
#import "BAOrgTreeModel.h"
#import "BAOrgTreeCell.h"

#import <Masonry.h>
#import <ReactiveObjC.h>

#define kCell @"cell"

// 十六进制创建颜色
#define kColorWithHex(hexValue) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define kColorWithHexAlpha(hexValue,a) [UIColor \
colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0xFF00) >> 8))/255.0 \
blue:((float)(hexValue & 0xFF))/255.0 alpha:(a)]


@interface BAKitVC_OrgTree ()
<
UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate
>

@property (nonatomic,strong) UITableView *orgTb;

@property (nonatomic,strong) BAOrgTreeModel *innerSelectOrg;

@property (nonatomic,strong) NSMutableArray<BAOrgTreeModel *> *searchList;

@property (nonatomic,assign) BOOL search;

@property (nonatomic,strong) NSMutableArray<BAOrgTreeModel *> *orgDataSource;

@end

@implementation BAKitVC_OrgTree

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
}

- (void)initData {
    NSDictionary *dict = BAKit_GetDictionaryWithContentsOfFile(@"Org", @"json");
    NSArray *arr = dict[@"data"];
    NSMutableArray *orgModels = @[].mutableCopy;
    if (arr.count > 0) {
        for (NSDictionary *dict in arr) {
            BAOrgTreeModel *model = [BAOrgTreeModel modelWithDic:dict level:0];
            [orgModels addObject:model];
        }
    }
    // 默认选中第一个组织获取五彩缤纷图
    if (orgModels != nil && orgModels.count > 0) {
        BAOrgTreeModel *orgModel = orgModels[0];
        self.selectOrg = orgModel;
    }
    self.orgList = orgModels;
}

- (void)initUI {
    
    //恢复原始状态
    for (BAOrgTreeModel *model in self.orgList) {
        [self initModel:model];
        // 获取所有的元素
        [self loopWithModel:model];
    }
    [self convertOrgTreeList:self.orgList];
    
    [self.view addSubview:self.orgTb];
    [self.orgTb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNaviNew];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Private

- (void)initModel:(BAOrgTreeModel *)model {
    model.selected = NO;
    model.zhankai = YES;
    [model initBelowCount];
    for (BAOrgTreeModel *subModel in model.referList) {
        [self initModel:subModel];
    }
}

#pragma mark - event

- (void)close:(UIButton *)sender {
//    [YZRouterManager openUrl:YZRouterMainServer_RemovePopVC params:nil sourceVc:self completion:^(id result) {
//
//    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sure:(UIButton *)sender {
    if (self.sureBlock) {
        self.sureBlock(self.innerSelectOrg);
    }
    [self close:nil];
}

#pragma mark - UI

- (void)setupNaviNew{
    //title
    UILabel *titleLb = [UILabel new];
    titleLb.text = @"选择组织";
    [titleLb sizeToFit];
    titleLb.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
    titleLb.textColor = UIColor.whiteColor;
    self.navigationItem.titleView = titleLb;
    self.navigationController.navigationBar.backgroundColor = UIColor.orangeColor;
    //导航栏背景
//    UIImage *navBackgroundImage = [[YZServerBundle imageNamed:@"main_pop_top_new3"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationController.navigationBar setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
//    [leftBtn sizeToFit];
//    [leftBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
//    leftBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
////    [leftBtn setBackgroundImage:[YZServerBundle imageNamed:@"main_close"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
//    [leftBtn sizeToFit];
//    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItem = barBtnItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 51, 26);
    [rightBtn addTarget:self action:@selector(sure:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    [rightBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = barBtnItem;
    
    //背景
    self.view.backgroundColor = [UIColor.cyanColor colorWithAlphaComponent:0.6];
//    self.bgImageView.image = [YZServerBundle imageNamed:@"main_pop_bg_new"];
}

#pragma mark - table

- (UITableView *)orgTb {
    if (_orgTb == nil) {
        _orgTb = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _orgTb.delegate = self;
        _orgTb.dataSource = self;
        _orgTb.separatorColor = UIColor.clearColor;
        _orgTb.backgroundColor = UIColor.clearColor;
        [_orgTb registerClass:[BAOrgTreeCell class] forCellReuseIdentifier:kCell];
    }
    return _orgTb;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 16 + 32 + 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 36;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.search) {
        return self.searchList.count;
    } else {
        return self.orgDataSource.count;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 16 + 32 + 8)];
//    [view yz_setGradientBackgroundWithColors:@[kColorWithHex(0x10AF4F), kColorWithHex(0x0F783B)] locations:nil startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1)];
    view.backgroundColor = UIColor.greenColor;
    UIView *inputView = [UIView new];
    inputView.layer.borderWidth = 1.0;
    inputView.layer.borderColor = kColorWithHex(0x10AF4F).CGColor;
    inputView.layer.masksToBounds = YES;
    inputView.clipsToBounds = YES;
    inputView.layer.cornerRadius = 4;
    inputView.backgroundColor = kColorWithHex(0x014E20);
    [view addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.right.offset(-16);
        make.top.offset(16);
        make.height.mas_equalTo(32);
    }];
    
    UIImageView *imgView = UIImageView.new;
    imgView.backgroundColor = UIColor.redColor;
    [inputView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(9);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    UITextField *tf = [[UITextField alloc] init];
    tf.borderStyle = UITextBorderStyleNone;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"搜索" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14 weight:UIFontWeightMedium], NSForegroundColorAttributeName : kColorWithHexAlpha(0x90FFBE, 0.35)}];
    tf.attributedPlaceholder = attrStr;
    tf.textColor = UIColor.whiteColor;
    tf.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.returnKeyType = UIReturnKeySearch;
    tf.delegate = self;
    [inputView addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.equalTo(imgView.mas_right).offset(2);
        make.right.offset(0);
    }];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BAOrgTreeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BAOrgTreeModel *org = nil;
    if (self.search) {
        org = self.searchList[indexPath.row];
    } else {
        org = self.orgDataSource[indexPath.row];
    }
    org.selected = ([org.fkId isEqualToString:self.innerSelectOrg.fkId]);
    cell.model = org;
    if (self.search) {
        [cell.shouqiBtn setHidden:YES];
    }
    @weakify(self)
    @weakify(tableView)
    cell.shouqiBlock = ^(UIButton * _Nonnull sender, BAOrgTreeModel * _Nonnull org) {
        @strongify(self)
        @strongify(tableView)
        if (self.search) {
            return;
        }
        [tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.orgDataSource indexOfObject:org] inSection:0];
        if (org.belowCount == 0) {
            org.zhankai = YES;
            //Data
            NSArray *submodels = [org open];
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:((NSRange){newIndexPath.row + 1,submodels.count})];
            [self.orgDataSource insertObjects:submodels atIndexes:indexes];
            
            //Rows
            NSMutableArray *indexPaths = [NSMutableArray new];
            for (int i = 0; i < submodels.count; i++) {
                NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(newIndexPath.row + 1 + i) inSection:newIndexPath.section];
                [indexPaths addObject:insertIndexPath];
            }
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            
        }else {
            org.zhankai = NO;
            //Data
            NSArray *submodels = [self.orgDataSource subarrayWithRange:((NSRange){newIndexPath.row + 1,org.belowCount})];
            [org closeWithSubmodels:submodels];
            [self.orgDataSource removeObjectsInArray:submodels];
            
            //Rows
            NSMutableArray *indexPaths = [NSMutableArray new];
            for (int i = 0; i < submodels.count; i++) {
                NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:(newIndexPath.row + 1 + i) inSection:newIndexPath.section];
                [indexPaths addObject:insertIndexPath];
            }
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
        [tableView endUpdates];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BAOrgTreeModel *org = nil;
    if (self.search) {
        org = self.searchList[indexPath.row];
    } else {
        org = self.orgDataSource[indexPath.row];
    }
    //    BAOrgTreeModel *org = self.orgList[indexPath.row];
    if (self.isOnlyFarm && ![org.type isEqualToString:@"1101"]) {
//        [self hud_toastStatus:@"只能选择猪场"];
        return;
    }
    if (!org.selected) {
        self.innerSelectOrg.selected = NO;
        org.selected = YES;
        self.innerSelectOrg = org;
        [tableView reloadData];
    }
}


#pragma mark  - UITextFieldDelegate

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self searchOrg:textField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.returnKeyType == UIReturnKeySearch) {
        [textField endEditing:YES];
    }
    return YES;
}

- (void)searchOrg:(NSString *)searchText {
    // 如果相等则列出层级关系，如果是包含则列出所有包含关键字，有层级就展开
    if (searchText.length <= 0) {
        self.search = NO;
        [self.orgTb reloadData];
    } else {
        self.search = YES;
        self.innerSelectOrg = nil;
        if (self.searchList.count > 0) {
            [self.searchList removeAllObjects];
        }
        [self.orgDataSource enumerateObjectsUsingBlock:^(BAOrgTreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.name containsString:searchText]) {
                [self.searchList enumerateObjectsUsingBlock:^(BAOrgTreeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([model.name isEqualToString:obj.name]) {
                        if (![self.searchList containsObject:model.supermodel]) {
                            [self.searchList insertObject:model.supermodel atIndex:idx];
                        }
                        [self.searchList addObject:obj.supermodel];
                        *stop = YES;
                    }
                }];
                [self.searchList addObject:obj];
            }
        }];
        
        [self.orgTb reloadData];
    }
}

- (void)loopWithModel:(BAOrgTreeModel *)model {
    if (model.referList.count > 0) {
        for (int idx = 0; idx < model.referList.count; idx++) {
            BAOrgTreeModel *tempModel = model.referList[idx];
            [self loopWithModel:tempModel];
        }
    }
}

// 如果父节点存在，且未添加到搜索列表则添加进去
- (void)supplementTree:(BAOrgTreeModel *)orgModel {
    if (orgModel.supermodel && ![self.searchList containsObject:orgModel.supermodel]) {
        [self.searchList addObject:orgModel.supermodel];
    }
}

#pragma mark - Getter Setter

- (NSMutableArray<BAOrgTreeModel *> *)searchList {
    if (_searchList == nil) {
        _searchList = [@[] mutableCopy];
    }
    return _searchList;
}

- (NSMutableArray<BAOrgTreeModel *> *)orgDataSource{
    if (_orgDataSource == nil) {
        _orgDataSource = [@[] mutableCopy];
    }
    return _orgDataSource;
}

- (void)setSelectOrg:(BAOrgTreeModel *)selectOrg {
    _selectOrg = selectOrg;
    _innerSelectOrg = selectOrg;
}

- (void)convertOrgTreeList:(NSArray<BAOrgTreeModel *> *) orgList{
    [orgList enumerateObjectsUsingBlock:^(BAOrgTreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.orgDataSource addObject:obj];
        [self convertOrgTreeList:obj.referList];
    }];
}


@end
