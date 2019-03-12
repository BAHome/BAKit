//
//  UIImage+BAGif.h
//  BBB
//
//  Created by 孙博岩 on 2019/2/12.
//  Copyright © 2019 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GIFimageBlock)(UIImage *GIFImage);

@interface UIImage (BAGif)

/** 根据本地GIF图片名 获得GIF image对象 */
+ (UIImage *)imageWithGIFNamed:(NSString *)name;

/** 根据一个GIF图片的data数据 获得GIF image对象 */
+ (UIImage *)imageWithGIFData:(NSData *)data;

/** 根据一个GIF图片的URL 获得GIF image对象 */
+ (void)imageWithGIFUrl:(NSString *)url gifImageBlock:(GIFimageBlock)gifImageBlock;

@end

NS_ASSUME_NONNULL_END
