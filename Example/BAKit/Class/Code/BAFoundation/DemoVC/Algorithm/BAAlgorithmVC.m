//
//  BAAlgorithmVC.m
//  BAKit_Example
//
//  Created by 博爱 on 2021/1/21.
//  Copyright © 2021 boai. All rights reserved.
//

#import "BAAlgorithmVC.h"

@interface BAAlgorithmVC ()

@end

@implementation BAAlgorithmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self initData];
}

- (void)initView {
    
}

- (void)initData {
    // 1.字符串反转
    char ch[] = "Hello world!";
    [self charReverseWithChar:ch];
    
    NSString *str = @"Hello world!";
    [self stringReverseWithString:str];
    
    // 2.冒泡排序
    NSArray <NSNumber *>*originArray = @[@3, @2, @6, @8, @10, @9, @7, @5, @1, @4, @0];
    [self sort_bubbleWithArray:originArray];
}

#pragma mark - 1.字符串反转
- (void)charReverseWithChar:(char *)c {
    printf("\norigin char：%s\n", c);

    // 定义头部指针
    char *begin = c;
    // 定义尾部指针
    char *end = c + strlen(c) - 1;
    
    while (begin < end) {
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    };
    
    printf("\nreverse char：%s\n", c);
    /**
     origin char：Hello world!
     reverse char：!dlrow olleH
     */
}

- (void)stringReverseWithString:(NSString *)string {
    NSLog(@"\norigin string：%@", string);
    NSMutableString *tempString = [NSMutableString string];
//    for (NSInteger i = string.length-1; i >= 0; --i) {
//        NSString *c = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
//        [tempString appendString:c];
//    }
    
    [string enumerateSubstringsInRange:NSMakeRange(0, string.length) options:NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [tempString appendString:substring];
    }];
    
    NSLog(@"\nreverse string：%@", tempString);
    /**
     origin string：Hello world!
     reverse string：!dlrow olleH
     */
}

#pragma mark - 2.冒泡排序
/**
 冒泡算法是一种基础的排序算法，这种算法会重复的比较数组中相邻的两个元素，如果一个元素比另一个元素大/小，那么就交换这两个元素的位置。重复一直比较到最后一个元素.
 1.最差时间复杂度：O(n^2);
 2.平均时间复杂度：O(n^2);
 */
- (void)sort_bubbleWithArray:(NSArray *)originArray {
    NSMutableArray <NSNumber *>*tempArray = originArray.mutableCopy;
    NSLog(@"\norigin array：%@", originArray);

    for (NSInteger i = 0; i < tempArray.count; ++i) {
        for (NSInteger j = 0; j < tempArray.count - i - 1; ++j) {
            if (tempArray[j].intValue > tempArray[j+1].intValue) {
                [tempArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"\nreverse array：%@", tempArray);
}


@end
