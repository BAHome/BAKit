//
//  NSString+BAFileManager.m
//  BAQMUIDemo
//
//  Created by boai on 2017/5/28.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "NSString+BAFileManager.h"

@implementation NSString (BAFileManager)

+ (NSString *)ba_path_resourcePath
{
    return [[NSBundle mainBundle] resourcePath];
}

/*! 获取软件沙盒路径 */
+ (NSString *)ba_path_getApplicationSupportPath
{
    //such as:../Applications/9A425424-645E-4337-8730-8A080DF086F4/Library/Application Support
    
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSAllDomainsMask, YES);
    
    NSString *path = nil;
    if ([libraryPaths count] > 0) {
        path = [libraryPaths objectAtIndex:0];
    }
    
    if (![self ba_path_isFileExists:path]) {
        [self ba_path_createDirForPath:path];
    }
    
    return path;
}

/*! 获取软件沙盒 Documents 路径 */
+ (NSString *)ba_path_getDocumentsPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    
    // such as:../Applications/9A425424-645E-4337-8730-8A080DF086F4/Documents
    return documentPath;
}

/*! 获取软件沙盒 cache 路径 */
+ (NSString *)ba_path_getCachePath
{
    // such as : ../Applications/9A425424-645E-4337-8730-8A080DF086F4/Library/Caches
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    return cachePath;
}

+ (NSURL *)ba_path_cacheURLPath
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] firstObject];
}

/*! 获取软件沙盒 cachesDic 路径 */
+ (NSString *)ba_path_getTemPath
{
    NSString *cachesDic = NSTemporaryDirectory();
    return cachesDic;
}

/*! 在软件沙盒指定的路径创建一个目录 */
+ (void)ba_path_createDirForPath:(NSString *)path
{
    if (![self ba_path_isFileExists:path])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"Can't create dir:%@, %@", path, error);
        }
    }
}

/*! 在软件沙盒指定的路径删除一个目录 */
+ (BOOL)ba_path_deleteFilesysItem:(NSString*)strItem
{
    if ([strItem length] == 0) {
        return YES;
    }
    
    NSError * error = nil;
    
    BOOL finished = [[NSFileManager defaultManager] removeItemAtPath:strItem error:&error];
    return finished;
}

/*! 在软件沙盒路径移动一个目录到另一个目录中 */
+ (BOOL)ba_path_moveFilesysItem:(NSString *)srcPath toPath:(NSString *)dstPath
{
    if (![self ba_path_isFileExists:srcPath]) return NO;
    
    NSError * error = nil;
    return [[NSFileManager defaultManager] moveItemAtPath:srcPath
                                                   toPath:dstPath
                                                    error:&error];
}

/*! 在软件沙盒路径中查看有没有这个路径 */
+ (BOOL)ba_path_isFileExists:(NSString *)filePath
{
    //如果传入路径不为nil,则检查传入的路径是否为文件或目录
    return filePath.length > 0 ? [[NSFileManager defaultManager] fileExistsAtPath:filePath] : NO;
}

+ (BOOL)ba_path_isDirExists:(NSString *)dir
{
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:dir isDirectory:&isDir]) {
        return isDir;
    }
    return NO;
}

/*! 在软件沙盒路径中获取指定userPath路径 */
- (NSString *)ba_path_getUserInfoStorePath:(NSString *)userPath
{
    NSString *destPath = [NSString ba_path_getDocumentsPath];
    NSString *userInfoPath = [destPath stringByAppendingString:[NSString stringWithFormat:@"/%@", userPath]];
    return userInfoPath;
}

+ (NSString *)ba_path_documentPathForFile:(NSString *)filename
{
    return [[self ba_path_getDocumentsPath] stringByAppendingPathComponent:filename];
}

+ (NSString *)ba_path_cachePathForFile:(NSString *)filename
{
    return [[self ba_path_getDocumentsPath] stringByAppendingPathComponent:filename];
}

+ (NSString *)ba_path_pathFromBundle:(NSString *)filename
{
    NSString *dir = [filename stringByDeletingLastPathComponent];
    if (dir.length == 0) {
        dir = nil;
    }
    //获取文件或目录 名称
    NSString *realfilename = [filename lastPathComponent];
    // 去掉拓展类型
    NSString *name = [realfilename stringByDeletingPathExtension];
    // 拓展类型名称
    NSString *ext = [realfilename pathExtension];
    
    return [[NSBundle mainBundle] pathForResource:name ofType:ext inDirectory:dir];
}

+ (NSString *)ba_path_pathFromDocumentOrBundle:(NSString *)filename
{
    // 先从Document目录读取
    NSString *filePathInDoc = [self ba_path_documentPathForFile:filename];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePathInDoc])
    {
        return filePathInDoc;
    }
    
    // Document目录没有，从app读取
    return [self ba_path_pathFromBundle:filename];
}

+ (NSArray *)ba_path_fileNamesInDirectorypath:(NSString *)dirPath
{
    
    NSArray *fileArr = nil;
    if (dirPath.length > 0) {
        fileArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    }
    return fileArr;
}

+ (NSString *)ba_path_fileNameInPath:(NSString *)path
{
    return [path lastPathComponent];
}

+ (NSArray<NSString *> *)ba_path_fileListOfDir:(NSString *)dir fileType:(NSString *)type
{
    NSMutableArray *filenamelist = [@[] mutableCopy];
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
    
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dir stringByAppendingPathComponent:filename];
        if ([self ba_path_isFileExists:fullpath]) {
            if (!type.length || [[filename pathExtension] isEqualToString:type]) {
                [filenamelist  addObject:filename];
            }
        }
    }
    
    return filenamelist;
}

+ (NSString *)ba_path_findLastModifiedFileOfDir:(NSString *)dir
{
    if (![self ba_path_isDirExists:dir]) {
        return dir;
    }
    
    NSArray *docFileList = [self ba_path_fileListOfDir:dir fileType:@"log"];
    NSEnumerator *docEnumerator = [docFileList objectEnumerator];
    NSString *docFilePath;
    NSDate *latestModifiedDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSString *lastModifiedFilePath = @"";
    
    while ((docFilePath = [docEnumerator nextObject])) {
        NSString *fullPath = [dir stringByAppendingPathComponent:docFilePath];
        if ([self ba_path_isDirExists:fullPath]) {
            continue;
        }
        
        NSDictionary *fileAttributes = [[NSFileManager defaultManager]  attributesOfItemAtPath:fullPath error:nil];
        NSDate *currentModifiedDate = [fileAttributes fileModificationDate];
        
        if ([latestModifiedDate ba_dateIsEarlierThanDate:currentModifiedDate]) {
            latestModifiedDate = currentModifiedDate;
            lastModifiedFilePath = fullPath;
        }
    }
    
    return lastModifiedFilePath;
}

@end
