//
//  BACollectionViewCustomFlowLayout.h
//  BAKit_Example
//
//  Created by 博爱 on 2021/1/18.
//  Copyright © 2021 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, kBACollectionViewCustomFlowLayoutType) {
    kBACollectionViewCustomFlowLayoutType_Left = 0,
    kBACollectionViewCustomFlowLayoutType_Center,
    kBACollectionViewCustomFlowLayoutType_Right,
};

@interface BACollectionViewCustomFlowLayout : UICollectionViewFlowLayout

@property(nonatomic, assign) kBACollectionViewCustomFlowLayoutType flowLayoutType;

@end

NS_ASSUME_NONNULL_END
