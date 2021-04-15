//
//  BACircleView.m
//  BACircleDemo
//
//  Created by boai on 2020/7/2.
//

#import "BACircleView.h"
#import "BAButton.h"
#import "BARotationGestureRecognizer.h"

@interface BACircleView ()

@property(nonatomic, strong) NSMutableArray <UIButton *>*buttonArray1;
@property(nonatomic, strong) NSMutableArray <UIButton *>*buttonArray2;

@property(nonatomic, assign) CGFloat circleRadius1;
@property(nonatomic, assign) CGFloat circleRadius2;

@property(nonatomic, assign) CGFloat angle1;
@property(nonatomic, assign) CGFloat angle2;

@property(nonatomic, assign) CGPoint circleCenter;

@property (nonatomic, assign) CGFloat rotationAngleInRadians;

@property (nonatomic, assign) CGFloat buttonWidth1;
@property (nonatomic, assign) CGFloat buttonWidth2;

@property (nonatomic, assign) CGFloat view_width;

@property(nonatomic, strong) NSArray *titleArray1;
@property(nonatomic, strong) NSArray *titleArray2;

@property(nonatomic, strong) NSArray *imageArray1;
@property(nonatomic, strong) NSArray *imageArray2;

@end

@implementation BACircleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self defaultData];
            [self initUI];
            [self initData];
        });
        
    }
    return self;
}

- (void)defaultData {
    self.view_width = self.bounds.size.width;
    
    self.circleCenter = CGPointMake(self.view_width/2.0, self.view_width/2.0);
    
    NSMutableArray *array1 = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; ++i) {
        NSString *name = [@"测试 " stringByAppendingString:@(i).stringValue];
        [array1 addObject:name];
    }
    self.titleArray1 = array1.copy;
    
    NSMutableArray *array2 = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; ++i) {
        NSString *name = [@"test " stringByAppendingString:@(i).stringValue];
        [array2 addObject:name];
    }
    self.titleArray2 = array2.copy;
    
    self.circleRadius1 = (self.view_width - 80)/2.0;
    self.circleRadius2 = (self.view_width - 200)/2.0;
    
    self.angle1 = M_PI * 2.0 / self.titleArray1.count;
    self.angle2 = M_PI * 2.0 / self.titleArray2.count;
    
    self.buttonWidth1 = 75;
    self.buttonWidth2 = 65;
}

- (void)initUI {
    NSInteger lineCount = 5;
    for (NSInteger i = 0; i < lineCount; ++i) {
        CGFloat angle = 360.0/lineCount * (i+1);
        CGPoint startPoint1 = [self getCircleCoordinateWithCircleCenter:self.circleCenter circleRadius:self.circleRadius1 angle:angle];
        CGPoint endPoint1 = [self getCircleCoordinateWithCircleCenter:self.circleCenter circleRadius:self.circleRadius1 angle:angle+180];
        [self addLineWithStrokeColor:BAKit_Color_RandomRGB() lineWidth:1.0 startPoint:startPoint1 endPoint:endPoint1];
    }
    
    [self addShapeLayerWithStrokeColor:UIColor.redColor lineWidth:2 radius:self.circleRadius1];
    [self addShapeLayerWithStrokeColor:UIColor.greenColor lineWidth:2 radius:self.circleRadius2];
        
    for (NSInteger i = 0; i < self.titleArray1.count; ++i) {
        NSString *title = self.titleArray1[i];
        UIButton *button = [self addButtonWithTitle:title image:nil];
        [self addSubview:button];
        [self.buttonArray1 addObject:button];
        
        CGFloat offsetx = self.circleRadius1 * cos(self.angle1 * i + M_PI_2);
        CGFloat offsety = self.circleRadius1 * sin(self.angle1 * i + M_PI_2);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.buttonWidth1);
            make.centerX.mas_equalTo(self.mas_centerX).offset(-offsetx);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-offsety);
        }];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = self.buttonWidth1 / 2.0;
        button.tag = 100+i;
        
//        @weakify(self)
        button.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
//            @strongify(self)
            NSString *msg = [NSString stringWithFormat:@"button %ld", (long)button.tag];
            NSLog(@"%@", msg);
        };
    }
    
    for (NSInteger i = 0; i < self.titleArray2.count; ++i) {
        NSString *title = self.titleArray2[i];
        UIButton *button = [self addButtonWithTitle:title image:nil];
        [self addSubview:button];
        [self.buttonArray2 addObject:button];
        
        CGFloat offsetx = self.circleRadius2 * cos(self.angle2 * i + M_PI_2);
        CGFloat offsety = self.circleRadius2 * sin(self.angle2 * i + M_PI_2);
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.buttonWidth2);
            make.centerX.mas_equalTo(self.mas_centerX).offset(-offsetx);
            make.centerY.mas_equalTo(self.mas_centerY).offset(-offsety);
        }];
        
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = self.buttonWidth2 / 2.0;
        button.tag = 1000+i;
        
//        @weakify(self)
        button.ba_buttonActionBlock = ^(UIButton * _Nonnull button) {
//            @strongify(self)
            NSString *msg = [NSString stringWithFormat:@"button %ld", (long)button.tag];
            NSLog(@"%@", msg);
        };
    }
}

/// 计算圆圈上点在圆上的坐标
/// @param circleCenter 圆心坐标
/// @param circleRadius 圆半径
/// @param angle 弧度
- (CGPoint)getCircleCoordinateWithCircleCenter:(CGPoint)circleCenter
                                  circleRadius:(CGFloat)circleRadius
                                         angle:(CGFloat)angle {
//    假设一个圆O(x,y)，半径为r，半径划过的角度为a，求当前角度圆弧上点p(x1,y1)的坐标。
//
//    x1 = x + r * cos(a * π / 180)
//    y1 = y + r * sin(a * π / 180)
    CGFloat x2 = circleRadius * cosf(angle * M_PI/180);
    CGFloat y2 = circleRadius * sinf(angle * M_PI/180);
    return CGPointMake(circleCenter.x + x2, circleCenter.y - y2);
}

- (void)initData {
    [self addGestureRecognizer:[[BARotationGestureRecognizer alloc]initWithTarget:self action:@selector(changeMove:)]];
}

- (UIButton *)addButtonWithTitle:(NSString *)title
                           image:(NSString *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:12];

    [button setBackgroundImage:[UIImage imageNamed:@"chilun"] forState:UIControlStateNormal];

//    button.backgroundColor = kColor_random();
    
    return button;
}

- (void)addShapeLayerWithStrokeColor:(UIColor *)strokeColor
                           lineWidth:(CGFloat)lineWidth
                              radius:(CGFloat)radius{
    CAShapeLayer *shapeLayer = CAShapeLayer.new;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.lineWidth = lineWidth;

    UIBezierPath *bigPath = [UIBezierPath bezierPathWithArcCenter:self.circleCenter radius:radius startAngle:0.0 endAngle:(M_PI * 2) clockwise:YES];

    shapeLayer.path = bigPath.CGPath;
    [self.layer addSublayer:shapeLayer];
}

- (void)addLineWithStrokeColor:(UIColor *)strokeColor
                     lineWidth:(CGFloat)lineWidth
                    startPoint:(CGPoint)startPoint
                      endPoint:(CGPoint)endPoint {
    
    CAShapeLayer *shapeLayer = CAShapeLayer.new;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.lineWidth = lineWidth;

    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:startPoint];
    // 其他点
    [linePath addLineToPoint:endPoint];
    shapeLayer.path = linePath.CGPath;
    [self.layer addSublayer:shapeLayer];
}

/** 移动后btn的位置 */
- (void)changeMove:(BARotationGestureRecognizer *)retation {
    if (self.buttonArray1.count < 13) {
        if (self.rotationAngleInRadians == 0 && retation.rotation > 0) {
            return;
        }
    }
    self.transform = CGAffineTransformMakeRotation(self.rotationAngleInRadians+retation.rotation);
    for (UIButton *btn in self.buttonArray1) {
        btn.transform = CGAffineTransformMakeRotation((self.rotationAngleInRadians+retation.rotation));
    }
    for (UIButton *btn in self.buttonArray2) {
        btn.transform = CGAffineTransformMakeRotation(-(self.rotationAngleInRadians+retation.rotation));
    }
    self.rotationAngleInRadians += retation.rotation;
}

#pragma mark - setter, getter

- (NSMutableArray <UIButton *>*)buttonArray1 {
    if (!_buttonArray1) {
        _buttonArray1 = [NSMutableArray array];
    }
    return _buttonArray1;
}

- (NSMutableArray <UIButton *>*)buttonArray2 {
    if (!_buttonArray2) {
        _buttonArray2 = [NSMutableArray array];
    }
    return _buttonArray2;
}



@end
