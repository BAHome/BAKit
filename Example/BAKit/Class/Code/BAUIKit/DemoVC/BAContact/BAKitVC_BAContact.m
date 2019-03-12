//
//  BAKitVC_BAContact.m
//  BAKit
//
//  Created by boai on 2017/6/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BAContact.h"

#import "BAContactsModel.h"

#import "BAContactsIndexView.h"

#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

#import "BAKit_Color.h"
#import "BAKit_DefineFrame.h"
#import "BAKit_DefineFont.h"
#import "BAKit_DefineCommon.h"

#import "BAButton.h"
#import "BAKit_LocalizedIndexedCollation.h"

#import "UIImage+BARender.h"
#import "NSString+BAKit.h"
#import "NSMutableAttributedString+BAKit.h"
#import "BAAlertController.h"

static NSString * const cellID = @"BAContactViewCell";

#define cellHeight        50
#define cellImageViewSize cellHeight * 0.8

#define tableViewEdgeInsets UIEdgeInsetsMake(0, 15, 0, 0)

@interface BAKitVC_BAContact ()<UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property(nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <BAContactsModel *>*dataArray;
@property (nonatomic, strong) NSMutableArray <BAContactsModel *>*searchResultsKeywordsArray;

/*! 索引 */
@property (nonatomic, strong) NSMutableArray <NSString *>*indexArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray <NSString *>*searchResultIndexArray;


@property (nonatomic, strong) CNContactPickerViewController *contactPickerViewController;

@property(nonatomic, strong) BAContactsIndexView *indexView;

@property(nonatomic, strong) UIView *emptyView;

@end

@implementation BAKitVC_BAContact

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeSearch];
}

- (void)removeSearch
{
    if (self.searchController.active)
    {
        self.searchController.active = NO;
        [self.searchController.searchBar removeFromSuperview];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"博爱通讯录";
    self.view.backgroundColor = BAKit_Color_White_AliceBlue;
    self.tableView.hidden = NO;
    self.emptyView.hidden = YES;
    
    [self getSectionData];
    [self creatIndexView];
    [self setupNavi];
}

- (void)creatIndexView
{
    CGFloat min_h = self.indexArray.count * 20;
    CGFloat min_y = (BAKit_SCREEN_HEIGHT - min_h) / 2;
    CGFloat min_w = 40;
    CGFloat min_x = BAKit_SCREEN_WIDTH - 40;
    CGRect frame = CGRectMake(min_x, min_y, min_w, min_h);
    
//    NSMutableArray * arr = [NSMutableArray new];
//    for (int i = 0; i < 26; i ++)
//    {
//        unichar ch = 65 + i;
//        NSString * str = [NSString stringWithUTF8String:(char *)&ch];
//        [arr addObject:str];
//    }

    BAKit_WeakSelf
    self.indexView = [[BAContactsIndexView alloc] initWithFrame:frame indexArray:self.indexArray block:^(NSInteger index) {
        BAKit_StrongSelf
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                                    animated:NO
                              scrollPosition:UITableViewScrollPositionTop];
    } ];
    [self.view addSubview:self.indexView];
}

- (void)setupNavi
{
    CGRect frame = CGRectMake(0, 0, 80, 40);
    UIButton *navi_rightButton = [UIButton ba_creatButtonWithFrame:frame title:@"添加好友" selTitle:nil titleColor:BAKit_Color_Red titleFont:nil image:nil selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction)];
    navi_rightButton.backgroundColor = BAKit_Color_RandomRGBA();
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navi_rightButton];
}

- (void)handleRightNaviButtonAction
{
    self.contactPickerViewController = [[CNContactPickerViewController alloc] init];
    self.contactPickerViewController.delegate = (id<CNContactPickerDelegate>)self;
    if (self.contactPickerViewController) {
        [self presentViewController:self.contactPickerViewController animated:YES completion:nil];
    }
    else
    {
        
    }
    [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}

- (void)getSectionData
{
    NSDictionary *dict = [BAKit_LocalizedIndexedCollation ba_localizedWithDataArray:self.dataArray localizedNameSEL:@selector(user_Name)];
    self.indexArray   = dict[kBALocalizedIndexArrayKey];
    self.sectionArray = dict[kBALocalizedGroupArrayKey];
    
    NSMutableArray *tempModel = [[NSMutableArray alloc] init];
    NSArray *dicts = @[@{@"user_Name" : @"新的朋友",
                         @"user_Image_url" : @"plugins_FriendNotify"},
                       @{@"user_Name" : @"群聊",
                         @"user_Image_url" : @"add_friend_icon_addgroup"},
                       @{@"user_Name" : @"标签",
                         @"user_Image_url" : @"Contact_icon_ContactTag"},
                       @{@"user_Name" : @"公众号",
                         @"user_Image_url" : @"add_friend_icon_offical"}];
    for (NSDictionary *dict in dicts)
    {
        BAContactsModel *model = [BAContactsModel new];
        model.user_Name = dict[@"user_Name"];
        model.user_Image_url = dict[@"user_Image_url"];
        [tempModel addObject:model];
    }
    
    [self.sectionArray insertObject:tempModel atIndex:0];
    [self.indexArray insertObject:@"🔍" atIndex:0];
    
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.searchController.active)
    {
        return self.indexArray.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.searchController.active)
    {
        return [self.sectionArray[section] count];
    }
    return self.searchResultsKeywordsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    BAContactsModel *model = nil;
    
    if (!self.searchController.active)
    {
            model = self.sectionArray[section][row];
            cell.textLabel.text = model.user_Name;
    }
    else
    {
        model = self.searchResultsKeywordsArray[row];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.user_Name attributes:@{NSForegroundColorAttributeName:BAKit_Color_Black}];
        
        NSRange range = [model.user_Name rangeOfString:self.searchController.searchBar.text];
        if (range.location != NSNotFound)
        {
            [attributedString addAttributes:@{NSForegroundColorAttributeName:BAKit_Color_Blue} range:range];
        }
        cell.textLabel.attributedText = attributedString;
    }
    
    if (model.user_Image_url)
    {
        cell.imageView.image = [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:BAKit_ImageName(model.user_Image_url) imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    }
    else if (model.user_Image)
    {
        cell.imageView.image = [UIImage ba_imageToChangeCellRoundImageViewSizeWithCell:cell image:model.user_Image imageSize:CGSizeMake(cellImageViewSize, cellImageViewSize)];
    }
    if (model.user_PhoneNumber)
    {
        cell.detailTextLabel.text = model.user_PhoneNumber;
        cell.detailTextLabel.font = BAKit_Font_systemFontOfSize_12;
//        cell.detailTextLabelEdgeInsets = UIEdgeInsetsMake(2, -3, 0, 0);
    }
    else
    {
        cell.detailTextLabel.text = nil;
    }
    
//    cell.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
//    cell.textLabelEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    cell.backgroundColor = BAKit_Color_Clear;
//    [cell updateCellAppearanceWithIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSUInteger section = indexPath.section;
    NSUInteger row = indexPath.row;
    
    BAContactsModel *model = nil;
    if (!self.searchController.active)
    {
        model = self.sectionArray[section][row];
    }
    else
    {
        model = self.searchResultsKeywordsArray[row];
    }
    [self ba_showAlertWithModel:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!self.searchController.active)
    {
        return self.indexArray[section];
    }
    else
    {
        if (self.searchResultsKeywordsArray.count > 0)
        {
    //        return @"最佳匹配";
            return self.searchResultIndexArray[section];
        }
    }
    return nil;
}

//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    if (!self.searchController.active)
//    {
//        return self.indexArray;
//    }
//    return nil;
//}

#pragma mark - UISearchControllerDelegate
// 谓词搜索过滤
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = [self.searchController.searchBar text];
    [self.searchResultsKeywordsArray removeAllObjects];

    for (BAContactsModel *model in self.dataArray)
    {
        if ([model.user_Name ba_stringIncludesString:searchString])
        {
            [self.searchResultsKeywordsArray addObject:model];
            
            NSDictionary *dict = [BAKit_LocalizedIndexedCollation ba_localizedWithDataArray:self.searchResultsKeywordsArray localizedNameSEL:@selector(user_Name)];
            self.searchResultIndexArray = dict[kBALocalizedIndexArrayKey];
        }
    }

    if (self.searchResultsKeywordsArray.count == 0 && [self.searchController.searchBar isFirstResponder])
    {
        self.emptyView.hidden = NO;
    }
    else
    {
        self.emptyView.hidden = YES;
    }
    [self.tableView reloadData];
}

#pragma mark - UISearchControllerDelegate代理,可以省略,主要是为了验证打印的顺序
- (void)willPresentSearchController:(UISearchController *)searchController
{
    self.indexView.hidden = YES;
    [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:YES];
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    // 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
    //    [self.view addSubview:self.searchController.searchBar];
//    if (![searchController.searchBar.text ba_stringIsBlank])
//    {
//        self.searchController.dimsBackgroundDuringPresentation = NO;
//    }
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
//    [self ba_removeEmptyView];
    self.indexView.hidden = NO;
    [BAKit_Helper ba_helperIsSetStatusBarStyleUIStatusBarStyleDefault:NO];
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
//    [self ba_removeEmptyView];
}

- (void)presentSearchController:(UISearchController *)searchController
{

}

#pragma mark - UISearchBarDelegate
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.emptyView.hidden = YES;
//    [self ba_removeEmptyView];
}

#pragma mark - CNContactPickerDelegate
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts
{
    for (CNContact *cont in contacts)
    {
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
        // 名字
        NSString *name = @"";
        if (cont.familyName)
        {
            name = [NSString stringWithFormat:@"%@",cont.familyName];
        }
        if (cont.givenName)
        {
            name = [NSString stringWithFormat:@"%@%@",name,cont.givenName];
        }
        [userDic setObject:name forKey:@"name"];
        if (cont.organizationName)
        {
            
            [userDic setObject:cont.organizationName forKey:@"organizationName"];
        }
        if (cont.imageData)
        {
            [userDic setObject:[UIImage imageWithData:cont.imageData] forKey:@"image"];
        }
        if (cont.phoneNumbers)
        {
            for (CNLabeledValue *labeValue in cont.phoneNumbers)
            {
                CNPhoneNumber *phoneNumber = labeValue.value;
                NSString *phone = [[phoneNumber.stringValue componentsSeparatedByString:@"-"] componentsJoinedByString:@""];
                if (phone.length == 11)
                {
                    [userDic setObject:phone forKey:@"phone"];
                }
            }
        }
        
        BAContactsModel *model = [[BAContactsModel alloc] init];
        model.user_Name = userDic[@"name"];
        model.user_Image = userDic[@"image"];
        model.user_PhoneNumber = userDic[@"phone"];
        
        if (![BAKit_Helper ba_helperIsNSStringNULL:model.user_Name])
        {
            if ([self ba_isArray:self.dataArray containsObject:model])
            {
                BAKit_ShowAlertWithMsg(@"此联系人已添加，请勿重复添加！");
            }
            else
            {
                [self.dataArray addObject:model];
            }
        }
    }
    
    [self getSectionData];
}

#pragma mark - custom Method
- (BOOL)ba_isArray:(NSArray <BAContactsModel *>*)array containsObject:(BAContactsModel *)object
{
    __block BOOL isExist = NO;
    [array enumerateObjectsUsingBlock:^(BAContactsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if ([obj.user_Name isEqualToString:object.user_Name])
         {
             // 数组中已经存在该对象
             *stop = YES;
             isExist = YES;
         }
     }];
    if (!isExist)
    {
        // 如果不存在就添加进去
        isExist = NO;
    }
    return isExist;
}

- (void)handleAboutItemEvent
{
    self.contactPickerViewController = [[CNContactPickerViewController alloc] init];
    self.contactPickerViewController.delegate = (id<CNContactPickerDelegate>)self;
    [self presentViewController:self.contactPickerViewController animated:YES completion:nil];
    
    [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}

- (void)ba_showAlertWithModel:(BAContactsModel *)model
{
    NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:@"博爱温馨提示" attributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    
    NSString *message = [NSString stringWithFormat:@"你点击了 %@ ！", model.user_Name];
    NSString *keyWord = model.user_Name;
    
    /*! 关键字添加效果 */
    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc]initWithString:message];
    
    /*! 获取关键字位置 */
    NSRange range = [message rangeOfString:keyWord];
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@2.0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor blueColor],NSStrokeWidthAttributeName:@2.0,NSVerticalGlyphFormAttributeName:@(0)};
    
    /*! 设置关键字属性 */
    [attributedMessage ba_changeAttributeDict:dic range:range];
    
    [UIAlertController ba_alertAttributedShowInViewController:self attributedTitle:attributedTitle attributedMessage:attributedMessage buttonTitleArray:@[@"取 消", @"确 定"] buttonTitleColorArray:@[BAKit_Color_Green, BAKit_Color_Red] block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                            
        if (buttonIndex == 0)
        {
            NSLog(@"你点击了取消按钮！");
        }
        else if (buttonIndex == 1)
        {
            NSLog(@"你点击了确定按钮！");
        }
        return;
    }];
}

- (void)ba_removeEmptyView
{
    [self.emptyView removeFromSuperview];
    self.emptyView = nil;
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Clear;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.tableFooterView = [UIView new];
        // 更改索引的背景颜色
        self.tableView.sectionIndexBackgroundColor = BAKit_Color_Clear;
        // 更改索引的文字颜色
//        self.tableView.sectionIndexColor = BAKit_Color_Orange;
//        self.tableView.sectionIndexTrackingBackgroundColor = BAKit_Color_Red;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (UISearchController *)searchController
{
    if (!_searchController)
    {
        // 创建UISearchController
        self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //设置代理
        self.searchController.delegate = self;
        self.searchController.searchResultsUpdater = self;
        self.searchController.searchBar.delegate = self;

        //包着搜索框外层的颜色
//        self.searchController.searchBar.barTintColor = [UIColor yellowColor];
        
        // placeholder
        self.searchController.searchBar.placeholder = @"搜索";
        self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;

        //  是否显示灰色透明的蒙版，默认 YES，点击事件无效
        self.searchController.dimsBackgroundDuringPresentation = NO;
        // 是否隐藏导航条，这个一般不需要管，都是隐藏的
//        self.searchController.hidesNavigationBarDuringPresentation = YES;
        // 搜索时，背景变模糊
//        self.searchController.obscuresBackgroundDuringPresentation = NO;
        
        //点击搜索的时候,是否隐藏导航栏
        //    self.searchController.hidesNavigationBarDuringPresentation = NO;
        
        // 位置
        self.searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);

        // 改变系统自带的“cancel”为“取消”
        [self.searchController.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
        self.searchController.searchBar.tintColor = BAKit_Color_Red_FireBrick;
        
        // 如果进入预编辑状态,searchBar消失(UISearchController套到TabBarController可能会出现这个情况),请添加下边这句话
        self.definesPresentationContext = YES;
        // 添加 searchbar 到 headerview
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
    return _searchController;
}

- (NSMutableArray <BAContactsModel *> *)searchResultsKeywordsArray
{
    if(_searchResultsKeywordsArray == nil)
    {
        _searchResultsKeywordsArray = [[NSMutableArray <BAContactsModel *> alloc] init];
    }
    return _searchResultsKeywordsArray;
}

- (NSMutableArray <BAContactsModel *> *)dataArray
{
    if(_dataArray == nil)
    {
        _dataArray = [[NSMutableArray <BAContactsModel *> alloc] init];
        
        NSArray *iconImageNamesArray = @[@"0.jpg",
                                         @"1.jpg",
                                         @"2.jpg",
                                         @"icon3.jpg",
                                         @"icon4.jpg",
                                         @"5.jpg",
                                         @"6.jpg",
                                         @"7.jpg",
                                         ];
        NSArray *namesArray = @[@"博爱",
                                @"boai",
                                @"小明",
                                @"陆晓峰",
                                @"石少庸是小明的老师",
                                @"石少庸",
                                @"Alix",
                                @"Tom",
                                @"Lucy",
                                @"123",
                                @"cydn",
                                @"mami",
                                @"888",
                                @"zhangSan",
                                @"王二",
                                @"微信",
                                @"张小龙"];
        
        NSMutableArray *iconArray = [NSMutableArray array];
        for (NSInteger i = 0; i < namesArray.count; i ++)
        {
            if (iconImageNamesArray.count < namesArray.count)
            {
                for (NSInteger j = 0; j < iconImageNamesArray.count; j ++)
                {
                    [iconArray addObject:iconImageNamesArray[BAKit_RandomNumber(iconImageNamesArray.count)]];
                }
            }
            BAContactsModel *model = [[BAContactsModel alloc] init];
            model.user_Image_url = iconArray[i];
            model.user_Name = namesArray[i];
            
            [self.dataArray addObject:model];
        }
    }
    return _dataArray;
}

- (NSMutableArray <NSString *> *)indexArray
{
    if(_indexArray == nil)
    {
        _indexArray = [[NSMutableArray <NSString *> alloc] init];
    }
    return _indexArray;
}

- (NSMutableArray *)sectionArray
{
    if(_sectionArray == nil)
    {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}

- (NSMutableArray <NSString *> *)searchResultIndexArray
{
    if(_searchResultIndexArray == nil)
    {
        _searchResultIndexArray = [[NSMutableArray <NSString *> alloc] init];
    }
    return _searchResultIndexArray;
}

- (UIView *)emptyView
{
    if (!_emptyView)
    {
        _emptyView = [UIView new];
        _emptyView.backgroundColor = BAKit_Color_Clear;
        self.emptyView.frame = CGRectMake(100, 100, 150, 150);
        
        UILabel *label = [UILabel new];
        label.frame = _emptyView.bounds;
        label.font = BAKit_Font_systemFontOfSize_14;
        label.text = @"没有搜索到相关数据！";
        
        [_emptyView addSubview:label];
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}

- (void)dealloc
{

}

@end
