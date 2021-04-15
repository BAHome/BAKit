//
//  BAKitVC_UnderlineLabel.m
//  BAKit
//
//  Created by boai on 2017/7/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_UnderlineLabel.h"


static NSString *const kString1 = @"1、UILabel 实现可点击的带下划线文字效果：\n \n这台 iMac 是 18 核的。对，你没看错。 配备 8 个核心的 iMac 已然足够不同凡响。而配备最多达 18 个核心的 iMac，全然是一种不同的存在。再加上最高可达 4.5 GHz 的 Turbo Boost 速度，让 iMac Pro 拥有充分的能力和灵活性，很好地兼顾超凡的多核处理能力和出色的单线程性能。因此，无论是渲染文件、剪辑 4K 视频、制作实时音频特效，还是编写下一款五星好评的 app，所有操作都快如闪电。一个个数字背后蕴藏的力量，在 iMac 上再一次得到印证。";

static NSString *const kString2 = @"2、UIButton 实现可点击的带下划线文字效果：\n欢迎来到 BAHome，";
static NSString *const kString3 = @"详情点击查看";

@interface BAKitVC_UnderlineLabel ()

@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;

@property(nonatomic, strong) UIButton *button;

@end

@implementation BAKitVC_UnderlineLabel

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI {
    self.title = @"可点击的下划线文字";
    self.label1.hidden = NO;
    self.label2.hidden = NO;
    self.button.hidden = NO;
    
}

//- (void)handleButtonAction:(UIButton *)sender
//{
//    BAKit_ShowAlertWithMsg_ios8(@"你点击了详情按钮！");
//}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    min_x = 20;
    min_y = 20;
    min_w = BAKit_SCREEN_WIDTH - min_x * 2;
    min_h = BAKit_LabelSizeWithMutableAttributedStringAndWidthAndFont(self.label1.attributedText, min_w, self.label1.font).height;
    self.label1.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_y = self.label1.bottom + 20;
    min_h = BAKit_LabelSizeWithTextAndWidthAndFont(self.label2.text, min_w, self.label2.font).height;
    self.label2.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_y = self.label2.bottom;
    min_h = 40;
    self.button.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
}

#pragma mark - setter / getter

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [UILabel new];
        _label1.backgroundColor = BAKit_Color_Gray_11;
        _label1.font = BAKit_Font_systemFontOfSize_15;
        _label1.numberOfLines = 0;
        
        NSString *changeTitle1 = @"1、UILabel 实现可点击的带下划线文字效果：";
        NSArray *tapArray = @[@"iMac", @"iMac Pro"];
        
        NSRange titleRange1 = [kString1 rangeOfString:changeTitle1];
        
        NSRange heightLightRange1 = [kString1 rangeOfString:tapArray[0]];
        NSRange heightLightRange2 = [kString1 rangeOfString:tapArray[1]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:kString1];
        [attributedString ba_changeSystemFont:BAKit_Font_systemFontOfSize_15 range:NSMakeRange(0, kString1.length)];
        [attributedString ba_changeSystemFont:BAKit_Font_boldSystemFontOfSize_18 range:titleRange1];
        
        /*! 要在这里改位置哈！ */
        [attributedString ba_changeColor:BAKit_Color_Red range:heightLightRange1];
        [attributedString ba_changeColor:BAKit_Color_Blue range:heightLightRange2];
        
        [attributedString ba_changeUnderlineStyle:NSUnderlineStyleSingle color:BAKit_Color_Red Range:heightLightRange1];
        [attributedString ba_changeUnderlineStyle:NSUnderlineStyleSingle color:BAKit_Color_Blue Range:heightLightRange2];
        _label1.attributedText = attributedString;
        
        BAKit_WeakSelf
        [_label1 ba_labelAddAttributeTapActionWithStrings:tapArray tapClicked:^(NSString *string, NSRange range, NSInteger index) {
            
            BAKit_StrongSelf
            NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),index];
            BAKit_ShowAlertWithMsg_ios8(message);
            
        }];
        
        [self.view addSubview:_label1];
    }
    return _label1;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [UILabel new];
        _label2.backgroundColor = BAKit_Color_Gray_11;
        _label2.font = BAKit_Font_systemFontOfSize_15;
        _label2.numberOfLines = 0;
        
        _label2.text = kString2;
        
        [self.view addSubview:_label2];
    }
    return _label2;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton ba_buttonWithFrame:CGRectZero title:kString3 titleColor:BAKit_Color_Blue_LightBLue titleFont:BAKit_Font_systemFontOfSize_15 backgroundColor:BAKit_Color_Gray_11];
        
        NSRange titleRange = NSMakeRange(0, kString3.length);
        
        [NSString ba_stringToBeUnderlineWithButton:_button range:titleRange lineColor:BAKit_Color_Blue_LightBLue];
        
//        [_button ba_viewAddTarget:self action:@selector(handleButtonAction:)];
        _button.ba_viewActionBlock = ^(UIView *view) {
            BAKit_ShowAlertWithMsg_ios8(@"你点击了详情按钮！");
        };
        
        [self.view addSubview:_button];
    }
    return _button;
}

@end
