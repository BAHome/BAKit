//
//  BAContactsIndexView.m
//  BAKit
//
//  Created by boai on 2017/6/22.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAContactsIndexView.h"

#import "BAKit_Color.h"
#import "BAKit_DefineCommon.h"
#import "BAKit_DefineFont.h"
#import "BAKit_DefineFrame.h"

// 字体变化率
#define FONT_RATE 1/8.000
// 透明度变化率
#define ALPHA_RATE 1/80.0000
// 初始状态索引颜色
#define STR_COLOR [UIColor orangeColor]
// 选中状态索引颜色
#define MARK_COLOR [UIColor blackColor]
// 初始状态索引大小
#define FONT_SIZE [UIFont systemFontOfSize:10]
// 索引label的tag值(防止冲突)
#define TAG 233333
// 圆的半径
#define ANIMATION_HEIGHT 80

@interface BAContactsIndexView ()

// 动画视图(可自定义)
@property (nonatomic,strong) UILabel *animationLabel;

// 初始数值(计算用到)
@property (nonatomic,unsafe_unretained) CGFloat number;

// 索引数组
@property (nonatomic,strong) NSArray *indexArray;


@end

@implementation BAContactsIndexView

- (instancetype)initWithFrame:(CGRect)frame indexArray:(NSArray *)array block:(BAContactsIndexView_Block)block
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.indexArray = [NSArray arrayWithArray:array];
        self.ba_ContactsIndexViewBlock = block;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    CGFloat min_h = self.frame.size.height/self.indexArray.count;
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i * min_h, self.frame.size.width, min_h)];
        label.text = self.indexArray[i];
        label.tag = TAG + i;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = STR_COLOR;
        label.font = FONT_SIZE;
        [self addSubview:label];
        
        _number = label.font.pointSize;
    }
    
    [self addSubview:self.animationLabel];
}

#pragma mark - AnimationWithSection

- (void)animationWithSection:(NSInteger)section
{
    self.ba_ContactsIndexViewBlock(section);
    
    _animationLabel.text = self.indexArray[section];
    _animationLabel.alpha = 1.0;
}

#pragma mark - PanAnimationFinish

- (void)panAnimationFinish
{
    CGFloat hh = self.frame.size.height/self.indexArray.count;
    
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel * label = (UILabel *)[self viewWithTag:TAG + i];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
            label.font = FONT_SIZE;
            label.alpha = 1.0;
            label.textColor = STR_COLOR;
        }];
    }
    
    [UIView animateWithDuration:1 animations:^{
        self.animationLabel.alpha = 0;
    }];
}

#pragma mark - PanAnimationBegin

- (void)panAnimationBeginWithToucher:(NSSet<UITouch *> *)touches
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGFloat hh = self.frame.size.height/self.indexArray.count;
    
    for (int i = 0; i < self.indexArray.count; i ++)
    {
        UILabel * label = (UILabel *)[self viewWithTag:TAG + i];
        if (fabs(label.center.y - point.y) <= ANIMATION_HEIGHT)
        {
            [UIView animateWithDuration:0.2 animations:^{
                
                label.center = CGPointMake(label.bounds.size.width/2 - sqrt(fabs(ANIMATION_HEIGHT * ANIMATION_HEIGHT - fabs(label.center.y - point.y) * fabs(label.center.y - point.y))), label.center.y);
                
                label.font = [UIFont systemFontOfSize:_number + (ANIMATION_HEIGHT - fabs(label.center.y - point.y)) * FONT_RATE];
                
                if (fabs(label.center.y - point.y) * ALPHA_RATE <= 0.08)
                {
                    label.textColor = MARK_COLOR;
                    label.alpha = 1.0;
                    
                    [self animationWithSection:i];
                    
                    for (int j = 0; j < self.indexArray.count; j ++)
                    {
                        UILabel * label = (UILabel *)[self viewWithTag:TAG + j];
                        if (i != j)
                        {
                            label.textColor = STR_COLOR;
                            label.alpha = fabs(label.center.y - point.y) * ALPHA_RATE;
                        }
                    }
                }
            }];
            
        }else
        {
            [UIView animateWithDuration:0.2 animations:^
             {
                 label.center = CGPointMake(self.frame.size.width/2, i * hh + hh/2);
                 label.font = FONT_SIZE;
                 label.alpha = 1.0;
             }];
        }
    }
}


#pragma mark - UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationBeginWithToucher:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationBeginWithToucher:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationFinish];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self panAnimationFinish];
}

#pragma mark - reloadVoice

#pragma mark - setter / getter

- (UILabel *)animationLabel
{
    if (!_animationLabel)
    {
        _animationLabel = [[UILabel alloc]initWithFrame:CGRectMake(-BAKit_SCREEN_WIDTH / 2 + self.frame.size.width/2, 100, 60, 60)];
        _animationLabel.layer.masksToBounds = YES;
        _animationLabel.layer.cornerRadius = 5.0f;
        _animationLabel.backgroundColor = [UIColor orangeColor];
        _animationLabel.textColor = [UIColor whiteColor];
        _animationLabel.alpha = 0;
        _animationLabel.textAlignment = NSTextAlignmentCenter;
        _animationLabel.font = [UIFont systemFontOfSize:18];
    }
    
    return _animationLabel;
}

- (void)dealloc
{
    self.animationLabel = nil;
    self.indexArray = nil;
    self.ba_ContactsIndexViewBlock = nil;
}

@end
