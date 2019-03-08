//
//  TL_DeviceTools.m
//  Bank94
//
//  Created by Liu Hui on 2017/4/24.
//  Copyright © 2017年 tonglingwangluo. All rights reserved.
//

#import "TLDeviceTools.h"
#import <AdSupport/AdSupport.h>

@implementation TLDeviceTools
+(NSString *)getDeviceUUID{
    return [[NSString alloc] initWithString:[[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]];
}
+(NSString *)getDeviceAPPBuildVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleVersion"];
}
+(NSString *)getDeviceAPPVersion{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    return [infoDic objectForKey:@"CFBundleShortVersionString"];
}
+(NSString *)getGID{
    NSString *uuidCut = [[TLDeviceTools getDeviceIdfa] substringFromIndex:[TLDeviceTools getDeviceIdfa].length > 5?[TLDeviceTools getDeviceIdfa].length - 5:0];
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%llu", recordTime];
    NSString *GID = [NSString stringWithFormat:@"%@%@",uuidCut,timeString];
    return GID;
}
+ (NSString *)getDeviceIdfa
{
    //升级版不再判断6以上
    return [[NSString alloc] initWithString:[[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString]];
    
    return nil;
}
@end
