//
//  BAKit_ScaleLabel.m
//  BAKit
//
//  Created by boai on 2017/7/21.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKit_ScaleLabel.h"

@interface BAKit_ScaleLabel ()

@property (nonatomic, strong) UILabel  *backedLabel;
@property (nonatomic, strong) UILabel  *colorLabel;

@end

@implementation BAKit_ScaleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backedLabel.hidden = NO;
    self.colorLabel.hidden = NO;
    
}

- (void)ba_startAnimation
{
    if (_ba_scaleEnd == 0)
    {
        _ba_scaleEnd = 2.0f;
    }
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _backedLabel.alpha = 1.0f;
        _backedLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        
        _colorLabel.alpha = 1.0f;
        _colorLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2 delay:0.5 usingSpringWithDamping:7 initialSpringVelocity:4 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            _colorLabel.alpha = 0.0f;
            _colorLabel.transform = CGAffineTransformMake(_ba_scaleEnd, 0, 0, _ba_scaleEnd, 0, 0);
            
        } completion: nil];
    }];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backedLabel.frame = self.bounds;
    self.colorLabel.frame = self.bounds;
    
}

#pragma mark - setter getter
- (UILabel *)backedLabel
{
    if (!_backedLabel)
    {
        _backedLabel = [UILabel new];
        _backedLabel.alpha = 0.f;
        _backedLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_backedLabel];
    }
    return _backedLabel;
}

- (UILabel *)colorLabel
{
    if (!_colorLabel)
    {
        _colorLabel = [UILabel new];
        _colorLabel.alpha = 0.f;
        _colorLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_colorLabel];
    }
    return _colorLabel;
}

- (void)setBa_text:(NSString *)ba_text
{
    _ba_text = ba_text;
    
    _backedLabel.text = ba_text;
    _colorLabel.text = ba_text;
}

- (void)setBa_scaleStart:(CGFloat)ba_scaleStart
{
    _ba_scaleStart = ba_scaleStart;
    
    _backedLabel.transform = CGAffineTransformMake(ba_scaleStart, 0, 0, ba_scaleStart, 0, 0);
    _colorLabel.transform = CGAffineTransformMake(ba_scaleStart, 0, 0, ba_scaleStart, 0, 0);
}

- (void)setBa_font:(UIFont *)ba_font
{
    _ba_font = ba_font;
    _backedLabel.font = ba_font;
    _colorLabel.font = ba_font;
}

- (void)setBa_colorBackLabelColor:(UIColor *)ba_colorBackLabelColor
{
    _ba_colorBackLabelColor = ba_colorBackLabelColor;
    _backedLabel.textColor = ba_colorBackLabelColor;
}

- (void)setBa_colorLabelColor:(UIColor *)ba_colorLabelColor
{
    _ba_colorLabelColor = ba_colorLabelColor;
    _colorLabel.textColor = ba_colorLabelColor;
}

@end
