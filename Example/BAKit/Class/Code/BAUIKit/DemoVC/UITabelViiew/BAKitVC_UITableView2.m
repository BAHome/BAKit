//
//  BAKitVC_UITableView2.m
//  BAKit
//
//  Created by boai on 2017/7/25.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UITableView2.h"

#import "BAKit_Color.h"
#import "BAKit_DefineFont.h"

@interface BAKitVC_UITableView2 ()

@property(nonatomic, strong) NSArray <NSArray *>*titleArray;
@property(nonatomic, strong) NSArray *sectionTitleArray;
@property(nonatomic, strong) NSMutableArray *mutableDataArray;

@end

@implementation BAKitVC_UITableView2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    
    self.dataArray = [self.mutableDataArray mutableCopy];
    
    self.tableView.backgroundColor = BAKit_Color_Yellow_LemonChiffon;
    
    self.ba_tabelViewCellConfig_block = ^(UITableView *tableView, NSIndexPath *indexPath, UITableViewCell *cell) {
        
        cell.textLabel.font = BAKit_Font_systemFontOfSize_13;
        cell.detailTextLabel.font = BAKit_Font_systemFontOfSize_13;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    };
}

- (NSArray <NSArray *>*)titleArray
{
    if (!_titleArray)
    {
//        @"专业人士对 iMac 情有独钟。因此，当他们要我们打造一款性能顶尖的 iMac 时，我们自然全力以赴。在设计上，我们不断突破极限，为这款 iMac 集成了 Mac 自诞生以来最强大的工作站级图形处理器、中央处理器、存储设备、内存和 I/O 端口，而机身仍能保持标志性的一体式设计，分毫未增。所以，无论是视频剪辑师、3D 动画师、音乐人、软件开发者还是科研人员，每个人都能以从未想象的方式，各展所长。这就是为你们打造的 iMac Pro，一台精简、凝练、梦想中的强大利器。",
        _titleArray = @[
                        @[
                            @"专业人士对 iMac 情有独钟。因此，当他们要我们打造一款性能顶尖的 iMac 时，我们自然全力以赴。在设计上，我们不断突破极限，为这款 iMac 集成了 Mac 自诞生以来最强大的工作站级图形处理器、中央处理器、存储设备、内存和 I/O 端口，而机身仍能保持标志性的一体式设计，分毫未增。所以，无论是视频剪辑师、3D 动画师、音乐人、软件开发者还是科研人员，每个人都能以从未想象的方式，各展所长。这就是为你们打造的 iMac Pro，一台精简、凝练、梦想中的强大利器。",
                            @"测试数据1-2",
                            @"配备 8 个核心的 iMac 。"
                        ],
                        @[
                            @"测试数据2-1"
                        ],
                        @[
                            @"测试数据3-1",
                            @"测试数据3-2"
                        ]

                        ];
    }
    return _titleArray;
}

- (NSArray *)sectionTitleArray
{
    if (!_sectionTitleArray)
    {
        _sectionTitleArray = @[
                        @"测试数据section-title-1",
                        @"测试数据section-title-2",
                        @"测试数据section-title-3",
                        ];
    }
    return _sectionTitleArray;
}

- (NSMutableArray *)mutableDataArray
{
    if (!_mutableDataArray)
    {
        _mutableDataArray = @[].mutableCopy;
        
        NSArray <NSArray *>*imageNameArray = @[
                                    @[
                                        @"0.jpg",
                                        @"tabbar_contactsHL",
                                        @"tabbar_contactsHL"
                                        ],
                                    @[
                                        @"tabbar_contactsHL"
                                        ],
                                    @[
                                        @"tabbar_contactsHL",
                                        @"tabbar_contactsHL"
                                        ]
                                    
                                    ];
        NSArray <NSArray *>*descTitleArray = @[
                                               @[
                                                   @"icon0.jpg",
                                                   @"icon1.jpg",
                                                   @"icon2.jpg"
                                                   ],
                                               @[
                                                   @"配备 8 个核心的 iMac"
                                                   ],
                                               @[
                                                   @"icon4.jpg",
                                                   @"icon2.jpg"
                                                   ]
                                               ];
        
        for (NSInteger i = 0; i < self.sectionTitleArray.count; i ++)
        {
            BABaseListViewSectionModel *sectionModel = [BABaseListViewSectionModel new];
            sectionModel.sectionTitle = self.sectionTitleArray[i];
            NSMutableArray *cellModelArray = @[].mutableCopy;
            
            for (NSInteger j = 0; j < self.titleArray[i].count; j ++)
            {
                BABaseListViewCellModel *cellModel = [BABaseListViewCellModel new];
                
                cellModel.title = self.titleArray[i][j];
                cellModel.imageName = imageNameArray[i][j];
                cellModel.detailString = descTitleArray[i][j];
                
                [cellModelArray addObject:cellModel];
            }
            sectionModel.sectionDataArray = cellModelArray;
            [_mutableDataArray addObject:sectionModel];
            
        }

    }
    return _mutableDataArray;
}

@end
