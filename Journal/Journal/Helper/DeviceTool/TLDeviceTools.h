//
//  TL_DeviceTools.h
//  Bank94
//
//  Created by Liu Hui on 2017/4/24.
//  Copyright © 2017年 tonglingwangluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLDeviceTools : NSObject

/**
 获取设备的UUID(获取的是广告ID)

 @return UUID
 */
+(NSString *)getDeviceUUID;

/**
 获取当前设备APP的bulid版本号

 @return 当前设备APP的bulid号
 */
+(NSString *)getDeviceAPPBuildVersion;

/**
 获取当前设备的版本号，例如：5.2.5

 @return 获取当前设备的版本号
 */
+(NSString *)getDeviceAPPVersion;

//上传随机码
+ (NSString *)getGID;
@end
