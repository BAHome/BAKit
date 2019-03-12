//
//  BAKitVC_UIFontDetailViewController.m
//  BAKit
//
//  Created by boai on 2017/7/20.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UIFontDetailViewController.h"
#import "BAKit_DefineFrame.h"

@interface BAKitVC_UIFontDetailViewController ()

@end

@implementation BAKitVC_UIFontDetailViewController
{
    NSArray *_titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = [UIColor colorWithRed:1.00 green:0.99 blue:0.92 alpha:1.00];

    self.navigationItem.title = self.font;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, BAKit_SCREEN_WIDTH * 2/3, 44)];
    label.text = self.font;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.font = [UIFont fontWithName:self.font size:18.0f];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    [self createLabel];
}

- (void)createLabel
{
    _titleArray = [NSArray array];
    _titleArray = @[
                    @"0 1 2 3 4 5 6 7 8 9\n",
                    @"a b c d e f g h i j k l m n o p q r s t u v w x y z\nA B C D E F G H I J K L M N O P Q R S T U V W X Y Z",
                    @"佛曰:\n写字楼里写字间，写字间里程序员；\n程序人员写程序，又拿程序换酒钱。\n酒醒只在网上坐，酒醉还来网下眠；\n酒醉酒醒日复日，网上网下年复年。\n但愿老死电脑间，不愿鞠躬老板前；\n奔驰宝马贵者趣，公交自行程序员。\n别人笑我忒疯癫，我笑自己命太贱；\n不见满街漂亮妹，哪个归得程序员？\n"
                    ];
    
    CGFloat min_x = 20;
    CGFloat min_y = 80;
    CGFloat min_w = CGRectGetWidth(self.view.frame) - min_x * 2;
    CGFloat min_space = 20;
    
    CGFloat min_h = 0;

    for (int i = 0; i < _titleArray.count; i++)
    {
        UIFont *font = [UIFont fontWithName:self.font size:15.0f];

        min_h = BAKit_LabelSizeWithTextAndWidthAndFont(_titleArray[i], min_w, font).height;
        
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:self.font size:15.0f];
        [label setText:_titleArray[i]];
        label.numberOfLines = 0;
        label.frame = CGRectMake(min_x, min_y, min_w, min_h);

        min_y = CGRectGetMaxY(label.frame) + min_space;
        
        [self.view addSubview:label];
    }
}


@end
