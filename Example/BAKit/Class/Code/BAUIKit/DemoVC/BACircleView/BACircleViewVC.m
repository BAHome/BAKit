//
//  BACircleViewVC.m
//  BAKit_Example
//
//  Created by boai on 2020/7/3.
//  Copyright © 2020 boai. All rights reserved.
//

#import "BACircleViewVC.h"
#import "BACircleView.h"

@interface BACircleViewVC ()

@property(nonatomic, strong) BACircleView *cycleView;

@end

@implementation BACircleViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
}

- (void)initUI {
    
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"转圈圈";
    
    [self.view addSubview:self.cycleView];
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.mas_equalTo(self.cycleView.mas_width).multipliedBy(1);
    }];
    
    _cycleView.layer.cornerRadius = (self.view.bounds.size.width - 40)/2.0;
}

#pragma mark - setter, getter

- (BACircleView *)cycleView {
    if (!_cycleView) {
        _cycleView = BACircleView.new;
        _cycleView.backgroundColor = UIColor.yellowColor;
        _cycleView.layer.masksToBounds = YES;
    }
    return _cycleView;
}

@end
