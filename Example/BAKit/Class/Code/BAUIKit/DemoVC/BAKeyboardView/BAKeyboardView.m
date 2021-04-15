//
//  BAKeyboardView.m
//  BBB
//
//  Created by 孙博岩 on 2019/5/24.
//  Copyright © 2019 boai. All rights reserved.
//

#import "BAKeyboardView.h"
#import "BAKeyboardNaviView.h"
#import "BAKeyboardButton.h"

#define kDuration 0.5
#define kKeyboard_H 270

#define kAllKeyCount 13
#define kRowKeyCount 3

@interface BAKeyboardView ()


@property (nonatomic, strong, readonly) UIView *sView;
@property (nonatomic, assign) BAKeyboardViewShowDirectionType showDirectionType;

@property (nonatomic, strong) BAKeyboardNaviView *naviView;
@property (nonatomic, strong) UIView *keyboardBgView;

@property (nonatomic, strong) NSMutableArray <BAKeyboardButton *>*keyBoardButtonsArray;
@property (nonatomic, strong) NSArray <NSString *>*numbersArray;

@end

@implementation BAKeyboardView

+ (instancetype)shared {
    static BAKeyboardView *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [self new];
    });
    
    return _shared;
}

#pragma mark - init

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.naviView];
    [self addSubview:self.keyboardBgView];
    
    [self.naviView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.keyboardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.mas_equalTo(self.naviView.mas_bottom).offset(0);
    }];
    
    [self initData];
}

- (void)initData {
    
    self.backgroundColor = BAKit_Color_Hex(@"#E7ECE7");

    for (NSInteger i = 0; i < kAllKeyCount; ++i) {
        
        BAKeyboardButton *keyboardButton = nil;
        if (i < 11) {
            keyboardButton = [BAKeyboardButton initWithKeyboardButtonType:BAKeyboardButtonType_Number title:self.numbersArray[i]];
        } else if (i == 11) {
            keyboardButton = [BAKeyboardButton initWithKeyboardButtonType:BAKeyboardButtonType_Delete title:nil];
        } else if (i == 12) {
            keyboardButton = [BAKeyboardButton initWithKeyboardButtonType:BAKeyboardButtonType_Return title:nil];
        }
        
        [self.keyboardBgView addSubview:keyboardButton];
        [self.keyBoardButtonsArray addObject:keyboardButton];
        
        CGFloat min_w = 0;
        CGFloat min_h = 0;
        
        if (i < 12) {
            
            min_w =  ((247.0 - 2)/kRowKeyCount)/247.0;
            min_h = (((375.0 - 44 - 65) - 5)/4)/(375.0 - 44);
            
            [keyboardButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                NSInteger row = i / kRowKeyCount;
                
                make.width.mas_equalTo(self.keyboardBgView.mas_width).multipliedBy(min_w);
                make.height.mas_equalTo(self.keyboardBgView.mas_height).multipliedBy(min_h);

                if (i % kRowKeyCount == 0) {
                    make.left.offset(0);
                    
                    if (row == 0) {
                        make.top.offset(0);
                    } else {
                        make.top.mas_equalTo(self.keyBoardButtonsArray[(row-1) * kRowKeyCount].mas_bottom).offset(1);
                    }
                } else {
                    make.centerY.mas_equalTo(self.keyBoardButtonsArray[row * kRowKeyCount]);
                    make.left.mas_equalTo(self.keyBoardButtonsArray[i-1].mas_right).offset(1);
                }
            }];
        } else if (i == 12) {
//            min_w = ((247.0 - 2)/kRowKeyCount)/247.0;
            min_h = (65.0/(375.0 - 44));

            [keyboardButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(self.keyboardBgView);
                make.height.mas_equalTo(self.keyboardBgView.mas_height).multipliedBy(min_h);
                make.bottom.offset(0);
                make.left.offset(0);
            }];
        }
        
        [keyboardButton addTarget:self action:@selector(handleActionsWithButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - button actions

- (void)handleActionsWithButton:(BAKeyboardButton *)button {
    
    switch (button.keyboardButtonType) {
        case BAKeyboardButtonType_Decimal:
        case BAKeyboardButtonType_Number: {
            self.onTapNumberButtonBlock ? self.onTapNumberButtonBlock(button.currentTitle):nil;
        }
            break;
        case BAKeyboardButtonType_Delete: {
            self.onTapDeleteButtonBlock ? self.onTapDeleteButtonBlock():nil;
        }
            break;
        case BAKeyboardButtonType_Return: {
            self.onTapReturnButtonBlock ? self.onTapReturnButtonBlock():nil;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - custome method

- (void)show {
//    [self showWithDirectionType:BAKeyboardViewShowDirectionType_Left];
//    [self showWithDirectionType:BAKeyboardViewShowDirectionType_Right];
    [self showWithDirectionType:BAKeyboardViewShowDirectionType_Bottom];
}

- (void)showWithDirectionType:(BAKeyboardViewShowDirectionType)directionType{
    
    UIView *topView = BAKit_APP_WINDOW;

    _sView = topView;
    [_sView addSubview:self];
    
    if (!_isShowed) {
        self.showDirectionType = directionType;
        self.isShowed = YES;
        switch (directionType) {
            case BAKeyboardViewShowDirectionType_Left: {
                
                [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.offset(0);
                    make.width.mas_equalTo(self.sView.mas_width).multipliedBy(self.keyboardWidthScale);
                    make.right.mas_equalTo(self.sView.mas_left).offset(0);
                }];
                [self.sView layoutIfNeeded];
                
                [UIView animateWithDuration:kDuration animations:^{
                    [self mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(self.sView.mas_left).offset(self.width);
                    }];
                    [self.sView layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                }];
            }
                break;
            case BAKeyboardViewShowDirectionType_Right: {
                [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.offset(0);
                    make.width.mas_equalTo(self.sView.mas_width).multipliedBy(self.keyboardWidthScale);
                    make.left.mas_equalTo(self.sView.mas_right).offset(0);
                }];
                [self.sView layoutIfNeeded];
                
                [UIView animateWithDuration:kDuration animations:^{
                    [self mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.sView.mas_right).offset(-self.width);
                    }];
                    [self.sView layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                }];
            }
                break;
            case BAKeyboardViewShowDirectionType_Bottom: {
                [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset(0);
                    make.height.mas_equalTo(kKeyboard_H);
                    make.top.mas_equalTo(self.sView.mas_bottom).offset(0);
                }];
                [self.sView layoutIfNeeded];
                
                [UIView animateWithDuration:kDuration animations:^{
                    [self mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(self.sView.mas_bottom).offset(-kKeyboard_H);
                    }];
                    [self.sView layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [self.sView layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
    }

}

- (void)dismiss {
    if (_isShowed) {
        [self dismissWithDirectionType:self.showDirectionType];
        [self.keyBoardButtonsArray removeAllObjects];
    }
}

- (void)dismissWithDirectionType:(BAKeyboardViewShowDirectionType)directionType{
    switch (directionType) {
        case BAKeyboardViewShowDirectionType_Left: {
            
            [UIView animateWithDuration:kDuration animations:^{
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(self.sView.mas_left).offset(0);
                }];
                [self.sView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.isShowed = NO;
            }];
        }
            break;
        case BAKeyboardViewShowDirectionType_Right: {
            [UIView animateWithDuration:kDuration animations:^{
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.sView.mas_right).offset(0);
                }];
                [self.sView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.isShowed = NO;
            }];
        }
            break;
        case BAKeyboardViewShowDirectionType_Bottom: {
            [UIView animateWithDuration:kDuration animations:^{
                [self mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.sView.mas_bottom).offset(0);
                }];
                [self.sView layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                self.isShowed = NO;
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - setter, getter

- (BAKeyboardNaviView *)naviView {
    if (_naviView == nil) {
        _naviView = BAKeyboardNaviView.new;
    }
    return _naviView;
}

- (UIView *)keyboardBgView {
    if (_keyboardBgView == nil) {
        _keyboardBgView = UIView.new;
    }
    return _keyboardBgView;
}

- (NSMutableArray <BAKeyboardButton *>*)keyBoardButtonsArray {
    if (_keyBoardButtonsArray == nil) {
        _keyBoardButtonsArray = [NSMutableArray array];
    }
    return _keyBoardButtonsArray;
}

- (NSArray *)numbersArray {
    if (_numbersArray == nil) {
        _numbersArray = @[
                          @"1", @"2", @"3",
                          @"4", @"5", @"6",
                          @"7", @"8", @"9",
                          @"0", @"."];
    }
    return _numbersArray;
}

- (float)keyboardWidthScale {
    return 247.0/667;
}

@end
