//
//  NSString+BAFileManager.h
//  BAQMUIDemo
//
//  Created by boai on 2017/5/28.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BAFileManager)

#pragma mark - 获取软件沙盒路径 类

+ (NSString *)ba_path_resourcePath;

/*! 获取软件沙盒路径 */
+ (nullable NSString *)ba_path_getApplicationSupportPath;

/*! 获取软件沙盒Documents路径 */
+ (nullable NSString *)ba_path_getDocumentsPath;

/*! 获取软件沙盒cache路径 */
+ (nullable NSString *)ba_path_getCachePath;
+ (NSURL *)ba_path_cacheURLPath;

/*! 获取软件沙盒cachesDic路径 */
+ (nullable NSString *)ba_path_getTemPath;

/*! 在软件沙盒指定的路径创建一个目录 */
+ (void)ba_path_createDirForPath:(NSString *)path;

/*! 在软件沙盒指定的路径删除一个目录 */
+ (BOOL)ba_path_deleteFilesysItem:(nullable NSString*)strItem;

/*! 在软件沙盒路径移动一个目录到另一个目录中 */
+ (BOOL)ba_path_moveFilesysItem:(nullable NSString *)srcPath toPath:(nullable NSString *)dstPath;

/*! 在软件沙盒路径中查看有没有这个路径 */
+ (BOOL)ba_path_isFileExists:(NSString *)filePath;

+ (BOOL)ba_path_isDirExists:(NSString *)dir;

/*! 在软件沙盒路径中获取指定userPath路径 */
- (nullable NSString *)ba_path_getUserInfoStorePath:(nullable NSString *)userPath;

+ (NSString *)ba_path_documentPathForFile:(NSString *)filename;

+ (NSString *)ba_path_cachePathForFile:(NSString *)filename;

+ (NSString *)ba_path_pathFromBundle:(NSString *)filename;

+ (NSString *)ba_path_pathFromDocumentOrBundle:(NSString *)filename;

+ (NSArray *)ba_path_fileNamesInDirectorypath:(NSString *)dirPath;

+ (NSString *)ba_path_fileNameInPath:(NSString *)path;

+ (NSArray<NSString *> *)ba_path_fileListOfDir:(NSString *)dir fileType:(NSString *)type;

+ (NSString *)ba_path_findLastModifiedFileOfDir:(NSString *)dir;

@end

NS_ASSUME_NONNULL_END
