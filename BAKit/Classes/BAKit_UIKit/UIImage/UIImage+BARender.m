//
//  UIImage+BARender.m
//  BAQMUIDemo
//
//  Created by 博爱 on 15/10/16.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIImage+BARender.h"
#import <objc/runtime.h>

#import "BAKit_Helper.h"

#define _FOUR_CC(c1,c2,c3,c4) ((uint32_t)(((c4) << 24) | ((c3) << 16) | ((c2) << 8) | (c1)))
#define _TWO_CC(c1,c2) ((uint16_t)(((c2) << 8) | (c1)))

@implementation UIImage (BARender)

/*!
 让图片不被渲染
 
 @param imageName 图片名称
 @return 不被渲染的图片
 */
+ (UIImage *)ba_imageNamedWithOriginal:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName] ;
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    return image ;
}

/*!
 获得新的圆形图片
 
 @param image 传入需要裁剪成圆形的图片
 @return 返回裁剪好的圆形图片
 */
+ (UIImage *)ba_imageToRoundImageWithImage:(UIImage *)image {
    if (!image)return nil;
    
    /*! 1、开启位图上下文 */
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0) ;
    
    /*! 2、描述圆形裁剪区域 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)] ;
    
    /*! 3、设置裁剪区域 */
    [clipPath addClip] ;
    
    /*! 4、绘图 */
    [image drawAtPoint:CGPointZero] ;
    
    /*! 5、取出图片 */
    image = UIGraphicsGetImageFromCurrentImageContext() ;
    
    /*! 6、关闭图片上下文 */
    UIGraphicsEndImageContext() ;
    
    return image ;
}

/*!
 传入图片，获得有边框、边框颜色的圆形图片
 
 @param borderW 边框宽度
 @param color   变宽颜色
 @param image   传入图片
 
 @return 获得有边框、边框颜色的圆形新图片
 */
+ (UIImage *)ba_imageWithBorderW:(CGFloat)borderW
                     borderColor:(UIColor *)color
                           image:(UIImage *)image {
    if (!image) return nil;
    
    /*! 1.生成一张图片,开启一个位图上下文(大小,图片的宽高 + 2 * 边框宽度) */
    CGSize size = CGSizeMake(image.size.width + 2 *borderW, image.size.height + 2 *borderW);
    UIGraphicsBeginImageContext(size);
    
    /*! 2.绘制一个大圆 */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    
    /*! 3.设置裁剪区域 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    
    /*! 3.1 把路径设置为裁剪区域 */
    [clipPath addClip];
    
    /*! 4 把图片绘制到上下文 */
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    
    /*! 5.从上下文当中获取图片 */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /*! 6.关闭上下文 */
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 UIImage：改变 系统 cell.imageView 的大小

 @param cell cell
 @param image image
 @param imageSize imageSize
 @return 返回自定义大小的系统 cell image
 */
+ (UIImage *)ba_imageToChangeCellNormalImageViewSizeWithCell:(UITableViewCell *)cell
                                                       image:(UIImage *)image
                                                   imageSize:(CGSize)imageSize {
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell.imageView.image;
}

/**
 UIImage：改变 系统 cell.imageView 的大小，返回圆形图像
 
 @param cell cell
 @param image image
 @param imageSize imageSize
 @return 返回自定义大小的圆形系统 cell image
 */
+ (UIImage *)ba_imageToChangeCellRoundImageViewSizeWithCell:(UITableViewCell *)cell
                                                      image:(UIImage *)image
                                                  imageSize:(CGSize)imageSize {
//    UIImage *roundImage = [UIImage ba_imageToRoundImageWithImage:image];
//    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
//    CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
//    [roundImage drawInRect:imageRect];
//    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    BAKit_CFAbsoluteTime_start
    UIImage *roundImage = [UIImage ba_imageToRoundImageWithImage:image];
    cell.imageView.image = roundImage;
//    BAKit_CFAbsoluteTime_end
    return cell.imageView.image;
}

/*!
 *  根据图片url获取图片尺寸
 *
 *  @param imageURL imageURL description
 *
 *  @return 根据图片url获取图片尺寸
 */
+ (CGSize)ba_imageGetImageSizeWithURL:(id)imageURL {
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]) {
        size = [self ba_imageGetPNGImageSizeWithRequest:request];
    } else if([pathExtendsion isEqual:@"gif"]) {
        size = [self ba_imageGetGIFImageSizeWithRequest:request];
    } else if([pathExtendsion isEqual:@"jpeg"]) {
        size = [self ba_imageGetJPEGImageSizeWithRequest:request];
    } else {
        size = [self ba_imageGetJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size)) { // 如果获取文件头信息失败,发送异步请求请求原图
        NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage *image = [UIImage imageWithData:data];
        if(image) {
            size = image.size;
        }
    }
    return size;
}

/*!
 *  获取PNG图片的大小
 *
 *  @param request request description
 *
 *  @return 获取PNG图片的大小
 */
+ (CGSize)ba_imageGetPNGImageSizeWithRequest:(NSMutableURLRequest*)request {
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8) {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

/*!
 *  获取gif图片的大小
 *
 *  @param request request description
 *
 *  @return 获取gif图片的大小
 */
+ (CGSize)ba_imageGetGIFImageSizeWithRequest:(NSMutableURLRequest*)request {
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4) {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

/*!
 *  获取jpg图片的大小
 *
 *  @param request request description
 *
 *  @return 获取jpg图片的大小
 */
+ (CGSize)ba_imageGetJPGImageSizeWithRequest:(NSMutableURLRequest*)request {
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
      return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        // 下面注释的两行代码不知为何判断，由于判断JPG JPEG 格式图片无法获取 size，注掉此两行判断现在可以正常获取，使用时请注意此处！
        //[data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        //if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
//        } else {
//            return CGSizeZero;
//        }
    }
}

/*!
 *  获取jpeg图片的大小
 *
 *  @param request request description
 *
 *  @return 获取jpeg图片的大小
 */
+ (CGSize)ba_imageGetJPEGImageSizeWithRequest:(NSMutableURLRequest*)request{
    NSURL *URL = nil;
    NSString *imgUrl = request.URL.relativeString;
    
    if (![imgUrl containsString:@"@"]) {
        imgUrl = [imgUrl stringByAppendingString:@"@100p"];
    }
    URL = [NSURL URLWithString:imgUrl];
    
    request.URL = URL;
    
   CGSize size = [self ba_imageGetJPGImageSizeWithRequest:request];
    
    return size;
}

/*!
 *  根据宽比例去缩放图片
 *
 *  @param width width description
 *
 *  @return return value description
 */
- (UIImage *)ba_imageScaleToWidth:(CGFloat)width {
//    // 如果传入的宽度比当前宽度还要大,就直接返回
//    if (width > self.size.width)
//    {
//        return  self;
//    }
//    
//    // 计算缩放之后的高度
//    CGFloat height = (width / self.size.width) * self.size.height;
//    
//    // 初始化要画的大小
//    CGRect rect = CGRectMake(0, 0, width, height);
//    
//    // 1. 开启图形上下文
//    UIGraphicsBeginImageContext(rect.size);
//    
//    // 2. 画到上下文中 (会把当前image里面的所有内容都画到上下文)
//    [self drawInRect:rect];
//    
//    // 3. 取到图片
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    
//    // 4. 关闭上下文
//    UIGraphicsEndImageContext();
//    // 5. 返回
//    return image;
    
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat old_width = imageSize.width;
    CGFloat old_height = imageSize.height;
    CGFloat targetWidth = width;
    CGFloat targetHeight = old_height / (old_width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / old_width;
        CGFloat heightFactor = targetHeight / old_height;
        if(widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth = old_width * scaleFactor;
        scaledHeight = old_height * scaleFactor;
        if(widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 图片压缩
+ (NSData *)ba_resetSizeOfSourceImage:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self ba_newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self ba_newSizeImage:defaultSize
                                         image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}

#pragma mark 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)ba_newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 二分法
+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"\n\n当前压缩的质量：%ld KB", (unsigned long)sizeOriginKB);
        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf\n\n", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}

/**
 *  截屏功能。via：http://stackoverflow.com/a/8017292/3825920
 *
 *  @return 对当前窗口截屏。（支付宝可能需要）
 */
+ (UIImage *)ba_getCurrentScreenShot {
    CGSize imageSize = CGSizeZero;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        imageSize = [UIScreen mainScreen].bounds.size;
    } else {
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        } else {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)ba_modifyImageToTargetSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
