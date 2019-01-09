//
//  TLArchiverTool.h
//  apartment
//
//  Created by 94bank on 2017/7/17.
//  Copyright © 2017年 统领得一网络科技（上海）有限公司. All rights reserved.
//  解归档方法

#import <Foundation/Foundation.h>

@interface TLArchiverTool : NSObject
//归档的工具方法
+ (void)archiverObject:(id)object ByKey:(NSString *)key
              WithPath:(NSString *)path;

+ (id)unarchiverObjectByKey:(NSString *)key
                   WithPath:(NSString *)path;
@end
