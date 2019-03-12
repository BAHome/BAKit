//
//  BAKitVC_BAColor.m
//  BAKit
//
//  Created by boai on 2017/6/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_BAColor.h"
#import "BAColor.h"


static NSString * const kCellID = @"BAKitVC_BAColorCell";

@interface BAKitVC_BAColor ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSArray *titleArray;

@property(nonatomic, assign) BOOL isRandom;

@end

@implementation BAKitVC_BAColor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"BAColor";
    self.view.backgroundColor = BAKit_Color_White;
 
    [self setupNavi];
}

- (void)setupNavi
{
    CGRect frame = CGRectMake(0, 0, 80, 30);
    UIButton *navi_rightButton = [UIButton ba_creatButtonWithFrame:frame title:@"random" selTitle:nil titleColor:BAKit_Color_Red titleFont:nil image:nil selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:15 target:self selector:@selector(handleRightNaviButtonAction:)];
    navi_rightButton.backgroundColor = BAKit_Color_RandomRGBA();
    
    [navi_rightButton ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:15 borderWidth:2.0f borderColor:BAKit_Color_Red];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navi_rightButton];
}

- (void)handleRightNaviButtonAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    self.isRandom = sender.selected;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *colorArray = self.dataArray[section];
    return colorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }
    
    BAColor *color = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = color.ba_colorDesc;
    cell.detailTextLabel.text = color.ba_colorMethodName;
    cell.backgroundColor = BAKit_HexWithInt16(color.ba_colorValue);
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    
    UILabel *titleLable = [UILabel new];
    titleLable.frame = CGRectMake(20, 5, BAKit_SCREEN_WIDTH - 20 * 2, 30);
    titleLable.text = self.titleArray[section];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.backgroundColor = BAKit_Color_Clear;
    [headerView addSubview:titleLable];
    
    UIColor *color = BAKit_Color_RandomRGB();
    CGRect frame = CGRectMake(0, 0, BAKit_SCREEN_WIDTH, 40);
    [headerView ba_animation_createGradientWithColorArray:@[BAKit_Color_White, color, BAKit_Color_White] frame:frame direction:UIViewLinearGradientDirectionHorizontal];

    return headerView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Gray_11;
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[].mutableCopy;
        
        BAColor *a1 = [BAColor ba_colorWithColorValue:0xFFE4E1 colorDesc:@"薄雾玫瑰" colorMethodName:@"mistyRose"];
        BAColor *a2 = [BAColor ba_colorWithColorValue:0xFFA07A colorDesc:@"浅鲑鱼色" colorMethodName:@"lightSalmon"];
        BAColor *a3 = [BAColor ba_colorWithColorValue:0xF08080 colorDesc:@"淡珊瑚色" colorMethodName:@"lightCoral"];
        BAColor *a4 = [BAColor ba_colorWithColorValue:0xFA8072 colorDesc:@"鲑鱼色" colorMethodName:@"salmonColor"];
        BAColor *a5 = [BAColor ba_colorWithColorValue:0xFF7F50 colorDesc:@"珊瑚色" colorMethodName:@"coralColor"];
        BAColor *a6 = [BAColor ba_colorWithColorValue:0xFF6347 colorDesc:@"番茄" colorMethodName:@"tomatoColor"];
        BAColor *a7 = [BAColor ba_colorWithColorValue:0xFF4500 colorDesc:@"橙红色" colorMethodName:@"orangeRed"];
        BAColor *a8 = [BAColor ba_colorWithColorValue:0xCD5C5C colorDesc:@"印度红" colorMethodName:@"indianRed"];
        BAColor *a9 = [BAColor ba_colorWithColorValue:0xDC143C colorDesc:@"猩红" colorMethodName:@"crimsonColor"];
        BAColor *a10 = [BAColor ba_colorWithColorValue:0xB22222 colorDesc:@"耐火砖" colorMethodName:@"fireBrick"];
        NSArray *array0 = @[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10];
        
        
        BAColor *b1 = [BAColor ba_colorWithColorValue:0xFFF8DC colorDesc:@"玉米色" colorMethodName:@"cornColor"];
        BAColor *b2 = [BAColor ba_colorWithColorValue:0xFFFACD colorDesc:@"柠檬薄纱" colorMethodName:@"LemonChiffon"];
        BAColor *b3 = [BAColor ba_colorWithColorValue:0xEEE8AA colorDesc:@"苍金麒麟" colorMethodName:@"paleGodenrod"];
        BAColor *b4 = [BAColor ba_colorWithColorValue:0xF0E68C colorDesc:@"卡其色" colorMethodName:@"khakiColor"];
        BAColor *b5 = [BAColor ba_colorWithColorValue:0xFFD700 colorDesc:@"金色" colorMethodName:@"goldColor"];
        BAColor *b6 = [BAColor ba_colorWithColorValue:0xFFC64B colorDesc:@"雌黄" colorMethodName:@"orpimentColor"];
        BAColor *b7 = [BAColor ba_colorWithColorValue:0xFFB61E colorDesc:@"藤黄" colorMethodName:@"gambogeColor"];
        BAColor *b8 = [BAColor ba_colorWithColorValue:0xE9BB1D colorDesc:@"雄黄" colorMethodName:@"realgarColor"];
        BAColor *b9 = [BAColor ba_colorWithColorValue:0xDAA520 colorDesc:@"金麒麟色" colorMethodName:@"goldenrod"];
        BAColor *b10 = [BAColor ba_colorWithColorValue:0xA78E44 colorDesc:@"乌金" colorMethodName:@"darkGold"];
        NSArray *array1 = @[b1,b2,b3,b4,b5,b6,b7,b8,b9,b10];
        
        BAColor *c1 = [BAColor ba_colorWithColorValue:0x98FB98 colorDesc:@"苍绿" colorMethodName:@"paleGreen"];
        BAColor *c2 = [BAColor ba_colorWithColorValue:0x90EE90 colorDesc:@"淡绿色" colorMethodName:@"lightGreen"];
        BAColor *c3 = [BAColor ba_colorWithColorValue:0x2AFD84 colorDesc:@"春绿" colorMethodName:@"springGreen"];
        BAColor *c4 = [BAColor ba_colorWithColorValue:0xADFF2F colorDesc:@"绿黄色" colorMethodName:@"greenYellow"];
        BAColor *c5 = [BAColor ba_colorWithColorValue:0x7CFC00 colorDesc:@"草坪绿" colorMethodName:@"lawnGreen"];
        BAColor *c6 = [BAColor ba_colorWithColorValue:0x32CD32 colorDesc:@"酸橙绿" colorMethodName:@"limeGreen"];
        BAColor *c7 = [BAColor ba_colorWithColorValue:0x228B22 colorDesc:@"森林绿" colorMethodName:@"forestGreen"];
        BAColor *c8 = [BAColor ba_colorWithColorValue:0x2E8B57 colorDesc:@"海洋绿" colorMethodName:@"seaGreen"];
        BAColor *c9 = [BAColor ba_colorWithColorValue:0x006400 colorDesc:@"深绿" colorMethodName:@"darkGreen"];
        BAColor *c10 = [BAColor ba_colorWithColorValue:0x556B2F colorDesc:@"橄榄(墨绿)" colorMethodName:@"olive"];
        
        NSArray *array2 = @[c1,c2,c3,c4,c5,c6,c7,c8,c9,c10];
        
        BAColor *d1 = [BAColor ba_colorWithColorValue:0xE1FFFF colorDesc:@"淡青色" colorMethodName:@"lightCyan"];
        BAColor *d2 = [BAColor ba_colorWithColorValue:0xAFEEEE colorDesc:@"苍白绿松石" colorMethodName:@"paleTurquoise"];
        BAColor *d3 = [BAColor ba_colorWithColorValue:0x7FFFD4 colorDesc:@"绿碧" colorMethodName:@"aquamarine"];
        BAColor *d4 = [BAColor ba_colorWithColorValue:0x40E0D0 colorDesc:@"绿松石" colorMethodName:@"turquoise"];
        BAColor *d5 = [BAColor ba_colorWithColorValue:0x48D1CC colorDesc:@"适中绿松石" colorMethodName:@"mediumTurquoise"];
        BAColor *d6 = [BAColor ba_colorWithColorValue:0x2BB8AA colorDesc:@"美团色" colorMethodName:@"meituanColor"];
        BAColor *d7 = [BAColor ba_colorWithColorValue:0x20B2AA colorDesc:@"浅海洋绿" colorMethodName:@"lightSeaGreen"];
        BAColor *d8 = [BAColor ba_colorWithColorValue:0x008B8B colorDesc:@"深青色" colorMethodName:@"darkCyan"];
        BAColor *d9 = [BAColor ba_colorWithColorValue:0x008080 colorDesc:@"水鸭色" colorMethodName:@"tealColor"];
        BAColor *d10 = [BAColor ba_colorWithColorValue:0x2F4F4F colorDesc:@"深石板灰" colorMethodName:@"darkSlateGray"];
        NSArray *array3 = @[d1,d2,d3,d4,d5,d6,d7,d8,d9,d10];
        
        BAColor *e1 = [BAColor ba_colorWithColorValue:0x8ACEE9 colorDesc:@"天蓝色" colorMethodName:@"skyBlue"];
        BAColor *e2 = [BAColor ba_colorWithColorValue:0x8ACFF8 colorDesc:@"淡蓝" colorMethodName:@"lightBLue"];
        BAColor *e3 = [BAColor ba_colorWithColorValue:0x00BFFF colorDesc:@"深天蓝" colorMethodName:@"deepSkyBlue"];
        BAColor *e4 = [BAColor ba_colorWithColorValue:0x1E90FF colorDesc:@"道奇蓝" colorMethodName:@"doderBlue"];
        BAColor *e5 = [BAColor ba_colorWithColorValue:0x6495ED colorDesc:@"矢车菊" colorMethodName:@"cornflowerBlue"];
        BAColor *e6 = [BAColor ba_colorWithColorValue:0x4169E1 colorDesc:@"皇家蓝" colorMethodName:@"royalBlue"];
        BAColor *e7 = [BAColor ba_colorWithColorValue:0x0000CD colorDesc:@"适中的蓝色" colorMethodName:@"mediumBlue"];
        BAColor *e8 = [BAColor ba_colorWithColorValue:0x00008B colorDesc:@"深蓝" colorMethodName:@"darkBlue"];
        BAColor *e9 = [BAColor ba_colorWithColorValue:0x000080 colorDesc:@"海军蓝" colorMethodName:@"navyColor"];
        BAColor *e10 = [BAColor ba_colorWithColorValue:0x191970 colorDesc:@"午夜蓝" colorMethodName:@"midnightBlue"];
        NSArray *array4 = @[e1,e2,e3,e4,e5,e6,e7,e8,e9,e10];
        
        BAColor *f0 = [BAColor ba_colorWithColorValue:0xE6E6FA colorDesc:@"薰衣草" colorMethodName:@"lavender"];
        BAColor *f1 = [BAColor ba_colorWithColorValue:0xD8BFD8 colorDesc:@"蓟" colorMethodName:@"thistleColor"];
        BAColor *f2 = [BAColor ba_colorWithColorValue:0xDDA0DD colorDesc:@"李子" colorMethodName:@"plumColor"];
        BAColor *f3 = [BAColor ba_colorWithColorValue:0xEE82EE colorDesc:@"紫罗兰" colorMethodName:@"violetColor"];
        BAColor *f4 = [BAColor ba_colorWithColorValue:0xBA55D3 colorDesc:@"适中的兰花紫" colorMethodName:@"mediumOrchid"];
        BAColor *f5 = [BAColor ba_colorWithColorValue:0x9932CC colorDesc:@"深兰花紫" colorMethodName:@"darkOrchid"];
        BAColor *f6 = [BAColor ba_colorWithColorValue:0x9400D3 colorDesc:@"深紫罗兰色" colorMethodName:@"darkVoilet"];
        BAColor *f7 = [BAColor ba_colorWithColorValue:0x8A2BE2 colorDesc:@"泛蓝紫罗兰" colorMethodName:@"blueViolet"];
        BAColor *f8 = [BAColor ba_colorWithColorValue:0x8B008B colorDesc:@"深洋红色" colorMethodName:@"darkMagenta"];
        BAColor *f9 = [BAColor ba_colorWithColorValue:0x4B0082 colorDesc:@"靛青" colorMethodName:@"indigoColor"];
        NSArray *array5 = @[f0,f1,f2,f3,f4,f5,f6,f7,f8,f9];
        
        
        BAColor *g1 = [BAColor ba_colorWithColorValue:0xF5F5F5 colorDesc:@"白烟" colorMethodName:@"whiteSmoke"];
        BAColor *g2 = [BAColor ba_colorWithColorValue:0xE0EEE8 colorDesc:@"鸭蛋" colorMethodName:@"duckEgg"];
        BAColor *g3 = [BAColor ba_colorWithColorValue:0xDCDCDC colorDesc:@"亮灰" colorMethodName:@"gainsboroColor"];
        BAColor *g4 = [BAColor ba_colorWithColorValue:0xBBCDC5 colorDesc:@"蟹壳青" colorMethodName:@"carapaceColor"];
        BAColor *g5 = [BAColor ba_colorWithColorValue:0xC0C0C0 colorDesc:@"银白色" colorMethodName:@"silverColor"];
        BAColor *g6 = [BAColor ba_colorWithColorValue:0x696969 colorDesc:@"暗淡的灰色" colorMethodName:@"dimGray"];
        NSArray *array6 = @[g1,g2,g3,g4,g5,g6];
        
        
        BAColor *h1 = [BAColor ba_colorWithColorValue:0xFFF5EE colorDesc:@"海贝壳" colorMethodName:@"seaShell"];
        BAColor *h2 = [BAColor ba_colorWithColorValue:0xFFFAFA colorDesc:@"雪" colorMethodName:@"snowColor"];
        BAColor *h3 = [BAColor ba_colorWithColorValue:0xFAF0E6 colorDesc:@"亚麻色" colorMethodName:@"linenColor"];
        BAColor *h4 = [BAColor ba_colorWithColorValue:0xFFFAF0 colorDesc:@"花之白" colorMethodName:@"floralWhite"];
        BAColor *h5 = [BAColor ba_colorWithColorValue:0xFDF5E6 colorDesc:@"老饰带" colorMethodName:@"oldLace"];
        BAColor *h6 = [BAColor ba_colorWithColorValue:0xFFFFF0 colorDesc:@"象牙白" colorMethodName:@"ivoryColor"];
        BAColor *h7 = [BAColor ba_colorWithColorValue:0xF0FFF0 colorDesc:@"蜂蜜露" colorMethodName:@"honeydew"];
        BAColor *h8 = [BAColor ba_colorWithColorValue:0xF5FFFA colorDesc:@"薄荷奶油" colorMethodName:@"mintCream"];
        BAColor *h9 = [BAColor ba_colorWithColorValue:0xF0FFFF colorDesc:@"蔚蓝色" colorMethodName:@"azureColor"];
        BAColor *h10 = [BAColor ba_colorWithColorValue:0xF0F8FF colorDesc:@"爱丽丝蓝" colorMethodName:@"aliceBlue"];
        BAColor *h11 = [BAColor ba_colorWithColorValue:0xF8F8FF colorDesc:@"幽灵白" colorMethodName:@"ghostWhite"];
        BAColor *h12 = [BAColor ba_colorWithColorValue:0xFFF0F5 colorDesc:@"淡紫红" colorMethodName:@"lavenderBlush"];
        BAColor *h13 = [BAColor ba_colorWithColorValue:0xF5F5DD colorDesc:@"米色" colorMethodName:@"beigeColor"];
        NSArray *array7 = @[h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13];
        
        BAColor *i1 = [BAColor ba_colorWithColorValue:0xD2B48C colorDesc:@"黄褐色" colorMethodName:@"tanColor"];
        BAColor *i2 = [BAColor ba_colorWithColorValue:0xBC8F8F colorDesc:@"玫瑰棕色" colorMethodName:@"rosyBrown"];
        BAColor *i3 = [BAColor ba_colorWithColorValue:0xCD853F colorDesc:@"秘鲁" colorMethodName:@"peruColor"];
        BAColor *i4 = [BAColor ba_colorWithColorValue:0xD2691E colorDesc:@"巧克力" colorMethodName:@"chocolateColor"];
        BAColor *i5 = [BAColor ba_colorWithColorValue:0xB87333 colorDesc:@"古铜色" colorMethodName:@"bronzeColor"];
        BAColor *i6 = [BAColor ba_colorWithColorValue:0xA0522D colorDesc:@"黄土赭色" colorMethodName:@"siennaColor"];
        BAColor *i7 = [BAColor ba_colorWithColorValue:0x8B4513 colorDesc:@"马鞍棕色" colorMethodName:@"saddleBrown"];
        BAColor *i8 = [BAColor ba_colorWithColorValue:0x734A12 colorDesc:@"土棕" colorMethodName:@"soilColor"];
        BAColor *i9 = [BAColor ba_colorWithColorValue:0x800000 colorDesc:@"栗色" colorMethodName:@"maroonColor"];
        BAColor *i10 = [BAColor ba_colorWithColorValue:0x5E2612 colorDesc:@"乌贼墨棕" colorMethodName:@"inkfishBrown"];
        NSArray *array8 = @[i1,i2,i3,i4,i5,i6,i7,i8,i9,i10];
        
        BAColor *j1 = [BAColor ba_colorWithColorValue:0xF3D3E7 colorDesc:@"水粉" colorMethodName:@"waterPink"];
        BAColor *j2 = [BAColor ba_colorWithColorValue:0xEDD1D8 colorDesc:@"藕色" colorMethodName:@"lotusRoot"];
        BAColor *j3 = [BAColor ba_colorWithColorValue:0xFFC0CB colorDesc:@"浅粉红" colorMethodName:@"lightPink"];
        BAColor *j4 = [BAColor ba_colorWithColorValue:0xFFB6C1 colorDesc:@"适中的粉红" colorMethodName:@"mediumPink"];
        BAColor *j5 = [BAColor ba_colorWithColorValue:0xF47983 colorDesc:@"桃红" colorMethodName:@"peachRed"];
        BAColor *j6 = [BAColor ba_colorWithColorValue:0xDB7093 colorDesc:@"苍白的紫罗兰红色" colorMethodName:@"paleVioletRed"];
        BAColor *j7 = [BAColor ba_colorWithColorValue:0xFF1493 colorDesc:@"深粉色" colorMethodName:@"deepPink"];
        NSArray *array9 = @[j1,j2,j3,j4,j5,j6,j7];

        [self.dataArray addObject:array0];
        [self.dataArray addObject:array1];
        [self.dataArray addObject:array2];
        [self.dataArray addObject:array3];
        [self.dataArray addObject:array4];
        [self.dataArray addObject:array5];
        [self.dataArray addObject:array6];
        [self.dataArray addObject:array7];
        [self.dataArray addObject:array8];
        [self.dataArray addObject:array9];
    }
    return _dataArray;
}

- (NSArray *)titleArray
{
    if (!_titleArray)
    {
        _titleArray = @[@"红",@"黄",@"绿",@"青",@"蓝",@"紫",@"灰",@"白",@"棕",@"粉"];
    }
    return _titleArray;
}


@end
