//
//  ImageViewAnimationVC.m
//  BAKit
//
//  Created by boai on 2017/8/14.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "ImageViewAnimationVC.h"
#import "BAKit_Color.h"

#import "UIImageView+BAAnimation.h"
#import "BAKit_DefineCommon.h"
#import "UIView+BAFrame.h"
#import <BAButton/BAButton.h>

@interface ImageViewAnimationVC ()

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) NSMutableArray *imageNameArray1;
@property(nonatomic, strong) UIButton *button;

@end

@implementation ImageViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)ba_base_setupUI
{
    self.imageView.hidden = NO;

    _button = [UIButton new];
    _button.backgroundColor = BAKit_Color_Blue_DarkBlue;
    [_button ba_buttonAddTarget:self tag:0 action:@selector(click)];
    
//    _button
    [self.view addSubview:_button];
        
    [self addImageArray];
}

- (void)addImageArray
{
//    self.imageNameArray1 = [self ba_getImageArrayWithName:@"test" count:2];
    self.imageNameArray1 = [self ba_getImageArrayWithName:@"knockout" count:81];

}

- (void)click
{
    [_imageView ba_imageViewAnimationWithImageArray:[self.imageNameArray1 mutableCopy]];
}

- (NSMutableArray *)ba_getImageArrayWithName:(NSString *)imageName
                                       count:(NSInteger)count
{
    NSMutableArray *imageArray = @[].mutableCopy;
    for (NSInteger i = 0; i < count; i ++)
    {
        NSString *imageName1 = [NSString stringWithFormat:@"%@_%02ld", imageName, (long)(i)];
        [imageArray addObject:imageName1];
    }
    return imageArray;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    _imageView.frame = CGRectMake(50, 100, 200, 200);
    _button.frame = CGRectMake(_imageView.x, _imageView.bottom + 20, 100, 40);

}

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = BAKit_Color_Yellow;
        _imageView.image = BAKit_ImageName(@"test_01");
//        _imageView.image = BAKit_ImageName(@"knockout_00");

        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (NSMutableArray *)imageNameArray1
{
    if (!_imageNameArray1)
    {
        _imageNameArray1 = @[].mutableCopy;
    }
    return _imageNameArray1;
}

- (void)dealloc
{
    _imageView.animationImages = nil;
}

@end
