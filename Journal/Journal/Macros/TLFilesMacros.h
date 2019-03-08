//
//  TL_FilesMacros.h
//  bank94
//
//  Created by Liu Hui on 2017/5/15.
//  Copyright © 2017年 com.hongzhe.tldy. All rights reserved.
//

#ifndef TLFilesMacros_h
#define TLFilesMacros_h


/**
 获取沙盒 Document路径

 @param NSDocumentDirectory NSDocumentDirectory
 @param NSUserDomainMask NSUserDomainMask
 @param YES YES
 @return 沙盒 Document路径
 */
#define TL_DocumentPath         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

/**
 获取Library的目录路径

 @param NSLibraryDirectory NSLibraryDirectory description
 @param NSUserDomainMask NSUserDomainMask description
 @param YES YES description
 @return 获取Library的目录路径
 */
#define TL_LibaryPath           [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

/**
 获取沙盒 Cache 路径

 @param NSCachesDirectory NSCachesDirectory description
 @param NSUserDomainMask NSUserDomainMask description
 @param YES YES description
 @return 获取沙盒 Cache 路径
 */
#define TL_CachePath            [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/**
 获取沙盒 temp 路径(注:iPhone 重启会清空)
 
 @param NSCachesDirectory NSCachesDirectory
 @param NSUserDomainMask NSUserDomainMask
 @param YES YES
 @return 获取沙盒 temp 路径
 */
#define TL_TempPath             NSTemporaryDirectory()


/**
 获取缓存文件路径

 @return 获取缓存文件路径
 */
#define TL_ImageCachePath       [TL_CachePath stringByAppendingPathComponent:@"/default/com.hackemist.SDWebImageCache.default"]

#endif /* TL_FilesMacros_h */
